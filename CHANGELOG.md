

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
- <code>BrnCalendarView</code> : optimizes the time range selection supports selecting the same day [#200](https://github.com/LianjiaTech/bruno/issues/200) .
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

