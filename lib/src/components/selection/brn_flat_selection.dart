import 'dart:async';

import 'package:bruno/src/components/popup/brn_measure_size.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/selection/brn_selection_view.dart';
import 'package:bruno/src/components/selection/controller/brn_flat_selection_controller.dart';
import 'package:bruno/src/components/selection/converter/brn_selection_converter.dart';
import 'package:bruno/src/components/selection/widget/brn_flat_selection_item.dart';
import 'package:bruno/src/components/toast/brn_toast.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:flutter/material.dart';

/// 支持tag 、输入 、range、选择等类型混合一级筛选
/// 也可支持点击选项跳转二级页面

// ignore: must_be_immutable
class BrnFlatSelection extends StatefulWidget {
  /// 筛选原始数据
  final List<BrnSelectionEntity> entityDataList;

  /// 点击确定回调
  final Function(Map<String, String>) confirmCallback;

  /// 每行展示tag数量  默认真是3个
  final int preLineTagSize;

  /// 当[BrnSelectionEntity.filterType]为[BrnSelectionFilterType.Layer] or[BrnSelectionFilterType.CustomLayer]时
  /// 跳转到二级页面的自定义操作
  final BrnOnCustomFloatingLayerClick onCustomFloatingLayerClick;

  /// controller.dispose() 操作交由外部处理
  final BrnFlatSelectionController controller;

  /// 是否需要配置子选项
  final bool isNeedConfigChild;

  /// 主题配置
  /// 如有对文本样式、圆角、间距等[BrnSelectionConfig]有特定要求可以配置该属性
  BrnSelectionConfig themeData;

  BrnFlatSelection(
      {this.entityDataList,
      this.confirmCallback,
      this.onCustomFloatingLayerClick,
      this.preLineTagSize = 3,
      this.isNeedConfigChild = true,
      this.controller,
      this.themeData}) {
    this.themeData ??= BrnSelectionConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: themeData.configId)
        .selectionConfig
        .merge(themeData);
  }

  @override
  _BrnFlatSelectionState createState() => _BrnFlatSelectionState();
}

class _BrnFlatSelectionState extends State<BrnFlatSelection> with SingleTickerProviderStateMixin {
  List<BrnSelectionEntity> _originalSelectedItemsList;

  StreamController<FlatClearEvent> clearController;
  bool isValid = true;
  BrnFlatSelectionController _controller;

  var _lineWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    if (widget.isNeedConfigChild ?? true) {
      widget.entityDataList?.forEach((f) => f.configRelationshipAndDefaultValue());
    }
    _controller?.addListener(_handleFlatControllerTick);

    _originalSelectedItemsList = List();
    _originalSelectedItemsList.clear();

    List<BrnSelectionEntity> firstColumn = List();
    if (widget.entityDataList != null && widget.entityDataList.length > 0) {
      for (BrnSelectionEntity entity in widget.entityDataList) {
        if (entity.isSelected) {
          firstColumn.add(entity);
        }
      }
    }
    _originalSelectedItemsList.addAll(firstColumn);
    if (firstColumn != null && firstColumn.length > 0) {
      for (BrnSelectionEntity firstEntity in firstColumn) {
        if (firstEntity != null) {
          List<BrnSelectionEntity> secondColumn =
              BrnSelectionUtil.currentSelectListForEntity(firstEntity);
          _originalSelectedItemsList.addAll(secondColumn);
          if (secondColumn != null && secondColumn.length > 0) {
            for (BrnSelectionEntity secondEntity in secondColumn) {
              List<BrnSelectionEntity> thirdColumn =
                  BrnSelectionUtil.currentSelectListForEntity(secondEntity);
              _originalSelectedItemsList.addAll(thirdColumn);
            }
          }
        }
      }
    }

    for (BrnSelectionEntity entity in _originalSelectedItemsList) {
      entity.isSelected = true;
      if (entity.customMap != null) {
        //ori 是存数据     customMap是用来展示ui的
        entity.originalCustomMap = Map.from(entity.customMap);
      }
    }

    clearController = StreamController.broadcast();
  }

  void _handleFlatControllerTick() {
    if (_controller.isResetSelectedOptions) {
      if (mounted) {
        setState(() {
          _resetSelectedOptions();
        });
      }
      _controller.isResetSelectedOptions = false;
    } else if (_controller.isCancelSelectedOptions) {
      // 外部关闭调用无UI更新操作
      _cancelSelectedOptions();
      _controller.isCancelSelectedOptions = false;
    } else if (_controller.isConfirmSelectedOptions) {
      _confirmSelectedOptions();
      _controller.isConfirmSelectedOptions = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
        onChange: (size) {
          setState(() {
            _lineWidth = size.width;
          });
        },
        child: _buildSelectionListView());
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleFlatControllerTick);
    super.dispose();
  }

  /// 取消
  _cancelSelectedOptions() {
    if (widget.entityDataList == null || widget.entityDataList.length <= 0) {
      return;
    }
    for (BrnSelectionEntity entity in widget.entityDataList) {
      BrnSelectionUtil.resetSelectionDatas(entity);
    }
    //把数据还原
    _originalSelectedItemsList.forEach((data) {
      data.isSelected = true;
      if (data.customMap != null) {
        //ori 是存数据     customMap是用来展示ui的
        data.customMap = Map<String, String>();
        if (data.originalCustomMap != null) {
          data.originalCustomMap.forEach((key, value) {
            data.customMap[key.toString()] = value.toString() ?? "";
          });
        }
      }
    });
  }

  /// 重置
  _resetSelectedOptions() {
    clearController.add(FlatClearEvent());
    if (widget.entityDataList != null && widget.entityDataList.length > 0) {
      for (BrnSelectionEntity entity in widget.entityDataList) {
        _clearUIData(entity);
      }
    }
  }

  /// 确定
  void _confirmSelectedOptions() {
    _clearSelectedEntity();
    if (!isValid) {
      isValid = true;
      return;
    }

    widget.entityDataList.forEach((data) {
      if (data.selectedList().isNotEmpty) {
        data.isSelected = true;
      } else {
        data.isSelected = false;
      }
    });

    widget.confirmCallback(DefaultSelectionConverter().convertSelectedData(widget.entityDataList));
  }

  /// 标题+筛选条件的 列表
  Widget _buildSelectionListView() {
    var contentWidget = Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BrnFlatMoreSelection(
                clearController: clearController,
                selectionEntity: widget.entityDataList[index],
                onCustomFloatingLayerClick: widget.onCustomFloatingLayerClick,
                preLineTagSize: widget.preLineTagSize,
                parentWidth: _lineWidth,
                themeData: widget.themeData,
              );
            },
            itemCount: widget.entityDataList.length,
          ),
        ));

    return contentWidget;
  }

  /// 清空UI效果
  void _clearUIData(BrnSelectionEntity entity) {
    entity.isSelected = false;
    entity.customMap = Map<String, String>();
    if (BrnSelectionFilterType.Range == entity.filterType) {
      entity.title = null;
    }
    if (entity.children != null) {
      for (BrnSelectionEntity subEntity in entity.children) {
        _clearUIData(subEntity);
      }
    }
  }

  void _clearSelectedEntity() {
    List<BrnSelectionEntity> tmp = List();
    BrnSelectionEntity node;
    tmp.addAll(widget.entityDataList);
    while (tmp.isNotEmpty) {
      node = tmp.removeLast();
      if (!node.isValidRange()) {
        isValid = false;
        BrnToast.show('您输入的区间有误', context);
        return;
      }
      node.children?.forEach((data) {
        tmp.add(data);
      });
    }
  }
}
