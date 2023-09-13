## [3.4.3] - 2023-9-13

### Changed

#### base

- Fixed the problem that some component documents cannot be viewed [#495](https://github.com/LianjiaTech/bruno/issues/495).

#### components

- <code>BrnPopupWindow</code> : fixed issue [#486](https://github.com/LianjiaTech/bruno/issues/486) which is called after initState and whenever the dependencies change thereafter.
- <code>BrnTabBar</code>: fixed the issue [#487](https://github.com/LianjiaTech/bruno/issues/487)  of invalid setting of badge.
- <code>BrnStepInputFormItem</code>: fixed the situation where manually input numbers are preceded by 0 [#458](https://github.com/LianjiaTech/bruno/issues/458).



## [3.4.2] - 2023-8-23

### Changed

#### base

- add dart doc.



## [3.4.1] - 2023-8-4

### Changed

#### base

- Fix dart analysis check warning.

#### components

- **Breaking change**: remove deprecated  attribute <code>fontSize</code> in  <code>BrnIconButton</code>, use <code>style</code> instead .

- **Breaking change**: in order to optimize the use of <code>MediaQueryData.fromWindow</code> and replace it with the official suggested api, add attribute <code> context </code> to the <code>keyOrValueLastQuestionInfo</code> method and <code>valueLastClickInfo</code> method in <code>BrnInfoModal</code>.

- **Breaking change**: remove deprecated  attribute <code>isShowXDial</code>in <code>BrnPointsLine</code>, use <code>isShowXDial</code> in <code>BrnLinePainter</code> instead.



## [3.4.0] - 2023-7-24

### Changed

#### base

- Adapt flutter sdk 3.10.0.

#### components

- **Breaking change**: Since flutter sdk 3.10.0 deletes the <code>brightness</code> and <code>textTheme</code> attributes of <code>Appbar</code>,<code> BrnAppBar </code>、<code>BrnSearchAppbar</code> is deleted synchronously. Instead, use <code>themeData</code>. <code>BrnAppBarConfig</code> will support all your needs. For details, see Demo usage.
- <code>BrnSimpleSelection</code> : support theme configuration [#420 ](https://github.com/LianjiaTech/bruno/pull/420) , thanks to **JunCaiLi** .
- Add missing themeData for <code>BrnNormalFormGroup</code> and <code>BrnPortraitRadioGroup</code> [#455](https://github.com/LianjiaTech/bruno/pull/445), thanks to **Kingtous**.
- <code>BrnTabBar</code> : add <code>onTap</code> method for <code>_TabBarOverlayWidget</code> [#393](https://github.com/LianjiaTech/bruno/pull/393).
- <code>BrnExpandFormGroup</code> and <code>BrnNormalFormGroup</code> remove invalid attribute <code>tipLabel</code>.
- <code>BrnIconButton</code> : fix the abnormal position of icons and text.




## [3.3.0] - 2023-2-1

### Changed

- fix the NullPointerException caused by not configuring <code>BrnIntl</code> [#398](https://github.com/LianjiaTech/bruno/issues/398).
- optimize internal import references.
- adapt flutter sdk 3.7.0 to fix badge reference conflict [#406](https://github.com/LianjiaTech/bruno/issues/406).



## [3.2.0] - 2022-12-29

### Changed

#### base 

- support for localization capabilities.
- add pad theme configuration.
- expend title click area in pickers [#369](https://github.com/LianjiaTech/bruno/issues/369).

#### components

- <code>BrnMultiSelectListPicker</code> : add generics for more flexible data transfer  [#336](https://github.com/LianjiaTech/bruno/issues/336) .
- <code>BrnLinePainter</code> : add the limit of  yDialMax > yDialMin to fix the NaN error when calculating the path [359](https://github.com/LianjiaTech/bruno/issues/359).
- <code>BrnTabBar</code> : fix the overflow error when setting <code>BrnTabBarBadgeMode.origin</code> mode [#340](https://github.com/LianjiaTech/bruno/issues/340).
- <code>BrnAppraise</code>: fix  gif file error [#372](https://github.com/LianjiaTech/bruno/issues/372).
- <code>BrnTextInputFormItem</code>: fix attribute <code>textInputAction</code>  does not take effect and add attribute <code>obscureText</code>, thank to **echo-LuGuang**.
- <code>BrnAppBar</code>: expand <code>BrnTextAction</code> click area.
- <code>BrnEnhanceNumberCard</code>: fix  the number card is not centered [#380](https://github.com/LianjiaTech/bruno/issues/380).



## [3.1.0] - 2022-9-30

### Changed

#### base 

- Adapt flutter sdk 3.3.0 and update dart sdk version to >=2.17.0.
- add <code>BrnSafeDialog[dismiss]</code>  instead of Navigator.pop to close the Dialog [#317](https://github.com/LianjiaTech/bruno/issues/317).
- optimize the upper font of form items [#330](https://github.com/LianjiaTech/bruno/issues/330).

#### components

- <code>BrnPageLoading</code> : calculated the range of loading based on screen width [#295](https://github.com/LianjiaTech/bruno/issues/295) .
- <code>BrnBottomTabBar</code> : fix attributes <code>selectedTextStyle </code>and <code>unSelectedTextStyle</code>  do not take effectc [#285](https://github.com/LianjiaTech/bruno/issues/285) , thanks to **JunCaiLi** .
- <code>BrnSearchText</code> : fix an abnormal display when BrnSearchText sets the innerColor property [#275](https://github.com/LianjiaTech/bruno/issues/275), thanks to **xyhuangjia**.
- <code>BrnBrokenLine</code>: xDial support selected style [#282](https://github.com/LianjiaTech/bruno/issues/282).
- <code>BrnMultiSelectTagsPicker</code>: fix when setting properties layoutStyle value of <code>BrnMultiSelectTagsLayoutStyle. Auto</code> display abnormal [#316](https://github.com/LianjiaTech/bruno/issues/316), thanks to **JunCaiLi**.
- <code>BrnCommonCardTitle</code>: fix the theme customization does not take effect, thanks to **JunCaiLi**.
- <code>BrnMiddleInputDialog</code>: add attribute <code>keyboardType</code>, thanks to **moqi2011**.
- <code>BrnCheckbox</code>: fix unsynchronized internal and external check states [#333](https://github.com/LianjiaTech/bruno/issues/333), thanks to **moqi2011**.
- <code>BrnTextInputFormItem</code>: add attribute <code>focusNode</code>, thanks to **Ives7**.
- <code>BrnProgressChart</code>: fix invalid setting color, background color, and animation [#322](https://github.com/LianjiaTech/bruno/pull/322).
- <code>BrnToast</code>: fix default value error in attribute <code>gravity</code> [#341](https://github.com/LianjiaTech/bruno/issues/341).
- <code>BrnTextInputFormItem</code>: add attribute <code>textInputAction</code> , thanks to **Ives7**.
- <code>BrnIconButton</code>: fix setting attribute <code>fontsize</code> does not take effect [#345](https://github.com/LianjiaTech/bruno/issues/345) and tag deprecated it use <code>style</code> is recommended.
- .<code>BrnSingleSelectCityPage</code>: add attribute <code>emptyImage</code> [#329](https://github.com/LianjiaTech/bruno/issues/329) and optimize default images of <code>BrnAbnormalStateWidget</code>.



## [3.0.0] - 2022-7-8

### Changed

#### base 

- Adapt flutter sdk 3.0.3.
- Add the attribute <code>backgroundColor</code>  to the form item and fix issue [#260](https://github.com/LianjiaTech/bruno/issues/260) , thanks to **Kingtous** find it.
- <code>pubspec.yaml</code> : upgrade <code>photo_view</code> version to v0.14.0 and remove <code>provider</code>.

#### components

- <code>BrnBottomPicker</code> : fix the title setting in the <code>show</code> method does not take effect [#212](https://github.com/LianjiaTech/bruno/issues/212) , thanks to **laiiihz** .
- <code>BrnStepInputFormItem</code> : fix cursor confusion [#235](https://github.com/LianjiaTech/bruno/issues/235) , thanks to **jixiaoyong** .
- <code>BrnSmallOutlineButton</code> : fix attribute <code>lineColor</code> does not take effect,thanks to **Story5** .
- <code>BrnAddLabel</code> : support theme config.
- <code>BrnBigMainButton</code> : fix the theme configuration <code>borderRadius</code> and <code>fontSize</code> does not take effect [#214](https://github.com/LianjiaTech/bruno/issues/214) .
- <code>BrnCalendarView</code> : optimize the time range selection supports selecting the same day [#200](https://github.com/LianjiaTech/bruno/issues/200) .
- <code>BrnProgressBarChart</code>：remove useless attribute <code>hasMark</code> in class <code>ChartAxis</code>.
- <code>BrnSmallOutlineButton</code> : fix attribute <code>fontWeight</code> does not take effect [#233](https://github.com/LianjiaTech/bruno/issues/233) .
- <code>BrnDialog</code> : fix <code>themeData</code>  does not take effec [#259](https://github.com/LianjiaTech/bruno/issues/259) .



## [2.2.0] - 2022-4-29

### Changed

#### base 
- Adapt flutter sdk 2.10.5.
- Fix flutter analyze issues.
- Fixed  some component theme configurations customization not taking effect  [#177](https://github.com/LianjiaTech/bruno/issues/177)  . 

#### components

**New components** <code>BrnSwitchFormItem</code> <code>BrnGeneralFormItem</code> <code>BrnSwitchButton</code>.

- <code>BrnTitleFormItem</code>: fix  <code>isRequire</code> parameter invalid [#179](https://github.com/LianjiaTech/bruno/issues/179).
- <code>BrnTextBlockInputFormItem</code> : change the <code>minLines</code> and <code>maxLines</code> attributes  to be nullable [#181](https://github.com/LianjiaTech/bruno/pull/181) thanks to **xiao luobei**.
- <code>BrnSelectionView</code> : fix "unlimited" option not taking effect .
- <code>BrnBottomTabBar</code>: remove the restriction on <code> type</code>  by <code> item.length</code> in the construction method.
- <code>BrnPairInfoTable</code> adds a callback attribute <code>onFolded</code> for expanding and collapsing state changes.
- <code>BrnCheckbox</code>:  add attribute <code>crossAxisAlignment</code>.
- <code>BrnRadioButton</code>: add attribute <code>crossAxisAlignment</code>.
- <code>BrnMiddleInputDialog</code>: add attribute <code>themeData</code> support theme.
- <code>BrnTextButtonPanel</code>: optimize button display, fix the space cannot be filled in some cases.
- <code>BrnCommonCardTitle</code>: add attribute <code>titleMaxLines</code> and <code>titleOverflow</code>.
- <code>BrnMultiSelectDialog</code>: uses the default contentStyle of BrnDialogConfig.
- <code>BrnScrollableTextDialog</code>: optimize ScrollBar placement and styling.
- <code>BrnSingleSelectDialog</code>: Add click callback for closeIcon.
- <code>BrnSelectionView</code>: optimizes the data display of the [More] filter page, and supports the display of up to 2 rows.
- <code>BrnTextInputFormItem</code> <code>BrnTextBlockInputFormItem</code> <code>BrnTitleSelectInputFormItem</code> : add attribute <code>autofocus</code> and default value is false.
- <code>BrnAppBar</code> theme customization <code>BrnAppBarConfig</code> supports the attribute <code>showDefaultBottom</code> to control the bottom dividing line of the AppBar
- <code>BrnMultiDataPicker</code>:  add default delegate implementation<code>BrnDefaultMultiDataPickerDelegate</code>.
- <code>BrnStepInputFormItem</code>: add attribute <code>canManualInput</code> and <code>controller</code> to support manual input function.
- <code>BrnSearchText</code>: add attribute <code>inputFormatters</code><code>textInputType</code>.
- <code>BrnAnchorTab</code>: support content dynamic change.
- <code>BrnProgressBarChart</code>: when <code>barChartStyle</code> is  <code>BarChartStyle.horizontal</code> support item click callback.



## [2.1.1] - 2022-4-1

### Changed

#### base

- **Breaking change**: Sound null safety support, thanks to  @leftcoding #39#33 @donywan #20 @laiiihz #80#64#59#32#14  @kalifun #36 @jojinshallar #81#75#65#62#56#42 @junlandroid #73 @Kenneth #53 @HappyImp #55 @kkkman22 #23 @AlexV525 #30
- **Breaking change**: Refer to the dart language specification to optimized constant and enum naming.
- Replace <code>DIN Font</code> with <code>Bebas Font</code> .

#### components

- **Breaking change**: remove <code>BrnHorizontalStepsManager</code> and put function <code>forwardStep()</code>  <code>backStep()</code> into <code>BrnStepsController</code> thanks to leftcoding.
- **Breaking change**:  remove <code>BrnDialogStyle</code> and replace with <code>BrnDialogConfig</code>.
- <code>BrnCalendarView</code>: add <code>BrnCalendarView.single()</code> and <code>BrnCalendarView.range()</code> constructor and had its argument <code>startEndDateChange</code> removed.
- <code>BrnSelectionEntityListBean</code>: <code>fromMap</code> is renamed to <code>fromJson</code>.
- <code>BrnRadioButton</code>: optimize click area [#31](https://github.com/LianjiaTech/bruno/pull/31) , thanks to **a1017480401** .
- <code>BrnScrollableTextDialog</code>: remove Navigator.pop(context) in <code>onSubmit()</code> and hand it over to external processing (user).
- <code>BrnBubbleText</code>: add attribute <code>bgColor</code> and <code>textStyle</code>.
- <code>BrnPairInfoTable</code>: add attribute <code>defaultVerticalAlignment</code>.
- <code>BrnSingleSelectDialog</code> : add attribute <code>messageText</code> and <code>messageWidget</code>.




### Fixed

- Fix example error [#71](https://github.com/LianjiaTech/bruno/issues/71) thanks to **leftcoding** fixing this issue.
- Fix <code>BrnPickerTitleConfig</code>  <code>titleContent</code> setting is invalid  [#70](https://github.com/LianjiaTech/bruno/issues/70).
- Optimize <code>BrnPopupWindow </code> <code>onItemClick</code>  logic  [#57 ](https://github.com/LianjiaTech/bruno/issues/57) .
- Fix <code>BrnDialog</code>  is obscured  by keyboard  [#7](https://github.com/LianjiaTech/bruno/issues/7) .
- Fix <code>BrnTextSelectFormItem</code> set <code>titlePaddingLg</code> doesn't work [#108](https://github.com/LianjiaTech/bruno/issues/108).
- Fix  the bottom text of <code>BrnBottomTabBar</code>  cannot be displayed in some cases [#141](https://github.com/LianjiaTech/bruno/issues/141).

Thanks again to **leftcoding**,  **jojinshallar**,  **laiiihz**,  **donywan**,  **kalifun**,  **junlandroid**, **Kenneth**, **HappyImp**,  **kkkman22** , **a1017480401** and  **Alex**.



## [2.0.0] - 2021-12-8

- Adapt flutter sdk 2.2.2

## [1.0.0] - 2021-12-7

- First publish adapt flutter sdk 1.22.4

