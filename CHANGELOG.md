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

