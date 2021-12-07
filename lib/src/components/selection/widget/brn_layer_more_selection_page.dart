import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_more_selection.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/toast/brn_toast.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/theme/img/brn_theme_default_utils.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 用于展示浮层的筛选项 如商圈
/// 左侧是：二级筛选项 右侧是三级筛选项
/// 默认将第一个元素选中
// ignore: must_be_immutable
class BrnLayerMoreSelectionPage extends StatefulWidget {
  //entity是商圈
  final BrnSelectionEntity entityData;
  BrnSelectionConfig themeData;

  BrnLayerMoreSelectionPage({this.entityData, this.themeData});

  @override
  _BrnLayerMoreSelectionPageState createState() => _BrnLayerMoreSelectionPageState();
}

class _BrnLayerMoreSelectionPageState extends State<BrnLayerMoreSelectionPage>
    with SingleTickerProviderStateMixin {
  List<BrnSelectionEntity> firstList;

  List<BrnSelectionEntity> _originalSelectedItemsList;

  ///当前选中的 一级筛选条件
  BrnSelectionEntity currentFirstEntity;

  ///当前选中的 一级筛选条件的索引
  int currentIndex;

  AnimationController _controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween(end: Offset.zero, begin: Offset(1.0, 0.0)).animate(_controller);
    _controller.forward();

    currentIndex = 0;
    firstList = List();
    _originalSelectedItemsList = widget.entityData.selectedList();

    _initData();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: <Widget>[
          _buildLeftSlide(context),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SlideTransition(
                position: animation,
                child: child,
              );
            },
            child: _buildRightSlide(context),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  ///左侧是黑色浮层
  Widget _buildLeftSlide(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          BrnSelectionUtil.resetSelectionDatas(widget.entityData);
          _originalSelectedItemsList.forEach((data) {
            data.isSelected = true;
          });
          Navigator.maybePop(context);
        },
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  ///右侧是二级列表
  Widget _buildRightSlide(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 0),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBar(
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
                  ),
                  onPressed: () {
                    //将选中的筛选项返回
                    _originalSelectedItemsList.forEach((data) {
                      data.isSelected = true;
                    });
                    Navigator.pop(context, widget.entityData);
                  },
                ),
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                title: Text(
                  '选择${widget.entityData.title}',
                  style: TextStyle(
                      color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              BrnLine(),
              _buildSelectionListView(),
              BrnLine(),
              _buildBottomBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionListView() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Color(0xfff8F8F8),
              child: _buildLeftListView(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0),
                itemBuilder: (context, index) {
                  return _buildRightItem(index);
                },
                itemCount: currentFirstEntity.children.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeftListView() {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //一级按钮的点击：1、处理点击 2、设置二级的默认选中
            //如果是单选：
            //      如果是选中的情况，则将已选中的兄弟节点清除
            //      如果是未选的情况，则直接选中

            if (index == currentIndex) {
              return;
            }
            if (firstList[index].filterType == BrnSelectionFilterType.Radio) {
              setState(() {
                currentIndex = index;
                currentFirstEntity = firstList[index];
                if (currentFirstEntity.isSelected) {
                  currentFirstEntity.clearSelectedEntity();
                } else {
                  currentFirstEntity.parent.clearSelectedEntity();
                  //设置不限
                  setInitialSecondShowingItem();
                }
              });
            } else {
              firstList[index].parent?.children?.where((data) {
                return data.filterType != BrnSelectionFilterType.Checkbox;
              })?.forEach((data) {
                data.isSelected = false;
                data.clearChildSelection();
              });

              if (!this.firstList[index].isSelected) {
                if (!BrnSelectionUtil.checkMaxSelectionCount(firstList[index])) {
                  BrnToast.show('您选择的筛选条件数量已达上限', context);
                  setState(() {});
                  return;
                } else {
                  currentIndex = index;
                  currentFirstEntity = firstList[index];
                  //一级选中的情况，初始化二级
                  setInitialSecondShowingItem();
                  setState(() {});
                }
              } else {
                currentIndex = index;
                currentFirstEntity = firstList[index];
                setState(() {});
              }
            }
          },
          child: _buildLeftItem(index),
        );
      },
      itemCount: firstList.length,
    );
  }

  //清空
  Widget _buildBottomBtn() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 80,
        child: MoreBottomSelectionWidget(
          //entity是商圈
          entity: widget.entityData,
          themeData: widget.themeData,
          clearCallback: () {
            setState(() {
              //商圈的重置
              widget.entityData.clearSelectedEntity();
            });
          },
          conformCallback: (data) {
            //带着商圈的数据返回
            data.children.forEach((value) {
              // 如果房山没有选中的子节点， 那么房山就是未选中
              if (value.selectedList().isEmpty) {
                value.isSelected = false;
              } else {
                value.isSelected = true;
              }
            });
            //如果商圈没有选中的 那么商圈就是未选中
            if (data.selectedList().isNotEmpty) {
              data.isSelected = true;
            } else {
              data.isSelected = false;
            }
            Navigator.maybePop(context, data);
          },
        ),
      ),
    );
  }

  Widget _buildLeftItem(int index) {
    //如果房山 被选中了或者房山处于正在选择的状态 则加粗
    TextStyle textStyle = widget.themeData.flayNormalTextStyle.generateTextStyle();
    if (index == currentIndex) {
      textStyle = widget.themeData.flatSelectedTextStyle.generateTextStyle();
    } else if ((firstList[index].isSelected) && firstList[index].selectedList().isNotEmpty) {
      textStyle = widget.themeData.flatBoldTextStyle.generateTextStyle();
    }

    List<BrnSelectionEntity> list = firstList[index].selectedList();
    //如果选中了不限 则展示 房山全部
    //如果选中了某几个
    //        如果可以跨区域 则显示数量 否则只加粗
    String name = firstList[index].title;

    if (list.isNotEmpty) {
      if (list.every((data) {
        return data.isUnLimit();
      })) {
        name += '(全部)';
      } else {
        bool containsCheck = firstList[index].hasCheckBoxBrother();
        bool containsCheckChildren = false;

        if (firstList[index].children.isNotEmpty) {
          containsCheckChildren = firstList[index].children[0].hasCheckBoxBrother();
        }
        if (containsCheck && containsCheckChildren) {
          name += '(${list.length})';
        }
      }
    }
    return Container(
      alignment: Alignment.centerLeft,
      height: 48,
      color: index == currentIndex ? Colors.white : Color(0xff8F8F8),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          name,
          style: textStyle,
        ),
      ),
    );
  }

  Widget _buildRightItem(int index) {
    bool isSingle =
        (currentFirstEntity.children[index].filterType == BrnSelectionFilterType.Radio) ||
            (currentFirstEntity.children[index].filterType == BrnSelectionFilterType.UnLimit);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSingle) {
            currentFirstEntity.clearSelectedEntity();
            currentFirstEntity.isSelected = true;
            currentFirstEntity.children[index].isSelected = true;
            //Navigator.pop(context, widget.entityData);
          } else {
            currentFirstEntity.children?.where((data) {
              return data.filterType != BrnSelectionFilterType.Checkbox;
            })?.forEach((data) {
              data.isSelected = false;
            });
            if (!currentFirstEntity.children[index].isSelected) {
              if (!BrnSelectionUtil.checkMaxSelectionCount(
                  this.currentFirstEntity.children[index])) {
                BrnToast.show('您选择的筛选条件数量已达上限', context);
                return;
              }
            }
            this.currentFirstEntity.children[index].isSelected =
                !this.currentFirstEntity.children[index].isSelected;
          }

          //如果二级没有任何选中的，那么一级为不选中
          if (currentFirstEntity.selectedList().isEmpty) {
            currentFirstEntity.isSelected = false;
          } else {
            currentFirstEntity.isSelected = true;
          }
        });
      },
      child: Container(
        alignment: isSingle ? Alignment.centerLeft : Alignment.centerLeft,
        height: 48,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: isSingle
              ? _buildRightSingleItem(currentFirstEntity.children[index])
              : _buildRightMultiItem(currentFirstEntity.children[index]),
        ),
      ),
    );
  }

  void _initData() {
    //填充一级筛选数据
    firstList = widget.entityData.children ?? List();
    //找到一级需要显示 的索引
    for (int i = 0; i < firstList.length; i++) {
      if (firstList[i].selectedList().isNotEmpty) {
        firstList[i].isSelected = true;
      }
    }
    currentIndex = firstList.indexWhere((data) {
      return data.isSelected;
    });

    if (currentIndex >= firstList.length || currentIndex == -1) {
      currentIndex = 0;
    }
    //当前选中的一级筛选条件
    currentFirstEntity = firstList[currentIndex];
    currentFirstEntity.isSelected = true;

    //找到第二级需要默认选中的索引
    setInitialSecondShowingItem();
  }

  Widget _buildRightMultiItem(BrnSelectionEntity tmp) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            tmp.title.toString(),
            style: tmp.isSelected
                ? widget.themeData.flatSelectedTextStyle.generateTextStyle()
                : widget.themeData.flayNormalTextStyle.generateTextStyle(),
          ),
        ),
        Container(
          height: 16,
          width: 16,
          child: tmp.isSelected
              ? BrnThemeImg.instance.CHECKED_STATUS
              : BrunoTools.getAssetImage(BrnAsset.iconUnSelect),
        )
      ],
    );
  }

  Widget _buildRightSingleItem(BrnSelectionEntity tmp) {
    return Text(tmp.title.toString(),
        textAlign: TextAlign.left,
        style: tmp.isSelected
            ? widget.themeData.flatSelectedTextStyle.generateTextStyle()
            : widget.themeData.flayNormalTextStyle.generateTextStyle());
  }

  //初始化二级的选中（小白楼）
  //规则：如果二级没有选中的，那么 选中二级的不限
  void setInitialSecondShowingItem() {
    //设置初始化的二级筛选条件 -1没有
    int secondIndex = currentFirstEntity.getFirstSelectedChildIndex();

    // 配置选中不限 : 第一层级是checkbox 并且 没有默认选中的
    if (secondIndex == -1 && currentFirstEntity.children.isNotEmpty) {
      for (int i = 0, n = currentFirstEntity.children.length; i < n; i++) {
        if (currentFirstEntity.children[i].isUnLimit() &&
            currentFirstEntity.filterType == BrnSelectionFilterType.Checkbox) {
          currentFirstEntity.children[i].isSelected = true;
          break;
        }
      }
    }

    //如果二级有选中的，一级配置为选中，否则为不选中
    int selectedIndex = currentFirstEntity.children.indexWhere((data) {
      return data.isSelected;
    });
    if (selectedIndex != -1 && currentFirstEntity.children.isNotEmpty) {
      currentFirstEntity.isSelected = true;
    } else {
      currentFirstEntity.isSelected = false;
    }
  }
}
