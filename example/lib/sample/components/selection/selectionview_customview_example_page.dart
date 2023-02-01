

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectionViewCustomViewExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity>? _filters;

  SelectionViewCustomViewExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState(_filters);
}

class _SelectionViewExamplePageState
    extends State<SelectionViewCustomViewExamplePage> {
  List<BrnSelectionEntity>? _filterData;

  var selectionKey = GlobalKey();
  bool isCustomFilterViewShow = false;
  OverlayEntry? filterViewEntry;

  /// 筛选组件的回调函数，用于把用户选中的参数回传给筛选组件，同意在 onSelectionChanged 回调处理。 参数在 customParams 中存储
  var _customHandleCallBack;

  /// controller  用于控制、刷新 筛选顶部 menu 的状态
  BrnSelectionViewController _selectionViewController =
      BrnSelectionViewController();

  /// 筛选实际选中的参数值，点击【重置】，但是没有点击确定，并不会重置该变量。
  String? _filterSelectedDate;

  /// 用于监听 Calendar日期状态的 notifier
  late ValueNotifier<DateTime?> _currentCalendarSelectedDate;
  String _dateForamt = 'yyyy-MM-dd HH:mm:ss';

  _SelectionViewExamplePageState(List<BrnSelectionEntity>? filters) {
    _filterData = filters;
  }

  @override
  void initState() {
    _currentCalendarSelectedDate =
        ValueNotifier(DateTimeFormatter.convertStringToDate(_dateForamt, _filterSelectedDate));
    super.initState();
  }

  @override
  void dispose() {
    _customHandleCallBack = null;
    closeCustomFilterView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(title: widget._title),
        body: Column(
          children: <Widget>[
            BrnSelectionView(
              key: selectionKey,
              selectionViewController: _selectionViewController,
              originalSelectionData: _filterData!,
              onCustomSelectionMenuClick: (int index,
                  BrnSelectionEntity customMenuItem,
                  BrnSetCustomSelectionParams customHandleCallBack) {
                if (isCustomFilterViewShow) {
                  closeCustomFilterView();
                } else {
                  filterViewEntry = getCustomFilterView();
                  Overlay.of(context).insert(filterViewEntry!);
                  isCustomFilterViewShow = true;
                }
                _customHandleCallBack = customHandleCallBack;
              },
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  BrnSetCustomSelectionMenuTitle setCustomTitleFunction) {
                BrnToast.show(
                    'filterParams : $filterParams' +
                        ',\n customParams : $customParams',
                    context);
                _filterSelectedDate = customParams['date'];
                if (customParams.isNotEmpty) {
                  setCustomTitleFunction(
                      menuTitle: customParams.values.first,
                      isMenuTitleHighLight: true);
                } else {
                  setCustomTitleFunction(
                      menuTitle: '自定义事件选择', isMenuTitleHighLight: false);
                }
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 400),
              alignment: Alignment.center,
              child: Text("背景内容区域"),
            )
          ],
        ));
  }

  OverlayEntry getCustomFilterView() {
    final RenderBox selectionRenderBox =
        selectionKey.currentContext!.findRenderObject() as RenderBox;
    var position =
        selectionRenderBox.localToGlobal(Offset.zero, ancestor: null);
    var size = selectionRenderBox.size;
    double topOffset = size.height + position.dy;
    BrnSelectionListViewController controller =
        BrnSelectionListViewController();
    controller..listViewTop = topOffset;
    controller..screenHeight = MediaQuery.of(context).size.height;

    _currentCalendarSelectedDate = ValueNotifier(
        DateTimeFormatter.convertStringToDate(
            _dateForamt, _filterSelectedDate));

    var content = Column(children: [
      Flexible(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: _currentCalendarSelectedDate,
                builder: (context, dynamic value, widget) {
                  return BrnCalendarView.single(
                      initStartSelectedDate: _currentCalendarSelectedDate.value,
                      initEndSelectedDate: _currentCalendarSelectedDate.value,
                      dateChange: (_) {
                        _currentCalendarSelectedDate.value = _;
                      });
                },
              ),
            ],
          ),
        ),
      ),
      _bottomWidget(),
    ]);

    OverlayEntry entry = OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: () {
          _currentCalendarSelectedDate.value = null;
          closeCustomFilterView();
        },
        child: Container(
          padding: EdgeInsets.only(
            top: topOffset,
          ),
          child: Stack(
            children: <Widget>[
              BrnSelectionAnimationWidget(controller: controller, view: content)
            ],
          ),
        ),
      );
    });

    return entry;
  }

  Widget _bottomWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, 11, 20, 11),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 24,
                    width: 24,
                    child:
                        BrunoTools.getAssetImage(BrnAsset.iconSelectionReset),
                  ),
                  Text(
                    '重置',
                    style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                  )
                ],
              ),
            ),
            onTap: () {
              /// TODO  清除筛选
              _currentCalendarSelectedDate.value = null;
            },
          ),
          Expanded(
            child: BrnBigMainButton(
              onTap: () {
                /// 真正点击【确定】时，选中的参数才有意义
                if (_customHandleCallBack != null)
                  _customHandleCallBack(_currentCalendarSelectedDate.value ==
                          null
                      ? Map<String, String>()
                      : {
                          'date': _currentCalendarSelectedDate.value.toString()
                        });
                _filterSelectedDate =
                    _currentCalendarSelectedDate.value?.toString();
                closeCustomFilterView();
              },
              title: '确定',
            ),
          )
        ],
      ),
    );
  }

  void closeCustomFilterView() {
    _selectionViewController.closeSelectionView();
    _selectionViewController.refreshSelectionTitle();
    filterViewEntry?.remove();
    filterViewEntry = null;
    isCustomFilterViewShow = false;
  }
}
