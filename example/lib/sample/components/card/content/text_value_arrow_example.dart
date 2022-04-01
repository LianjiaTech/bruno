

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class TextValueArrowContentExample extends StatefulWidget {
  @override
  _TextValueArrowContentExampleState createState() =>
      _TextValueArrowContentExampleState();
}

class _TextValueArrowContentExampleState
    extends State<TextValueArrowContentExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: 'value带有操作箭头',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '规则',
              style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            BrnBubbleText(
              maxLines: 4,
              text: 'value带有操作箭头，箭头在最右侧，value单行展示',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnPairInfoTable(
              isValueAlign: false,
              children: <BrnInfoModal>[
                BrnInfoModal(
                    keyPart: "名称：",
                    valuePart: "内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal(
                    keyPart: "名称名：",
                    valuePart: "内容内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.keyOrValueLastQuestionInfo("名称名称名称", "内容内容内容内容内容",
                    keyShow: true,
                    valueShow: true,
                    keyCallback: () {
                      BrnToast.show('key question', context);
                    },
                    valueCallback: () {
                      BrnToast.show('value question', context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.valueLastClickInfo("名称名称名称", "内容内容内容内容内容", "超链接",
                    clickCallback: (value) {
                      BrnToast.show(value!, context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
              ],
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnPairInfoTable(
              isValueAlign: true,
              children: <BrnInfoModal>[
                BrnInfoModal(
                    keyPart: "名称：",
                    valuePart: "内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal(
                    keyPart: "名称名：",
                    valuePart: "内容内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.keyOrValueLastQuestionInfo("名称名称名称", "内容内容内容内容内容",
                    keyShow: true,
                    valueShow: true,
                    keyCallback: () {
                      BrnToast.show('key question', context);
                    },
                    valueCallback: () {
                      BrnToast.show('value question', context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.valueLastClickInfo("名称名称名称", "内容内容内容内容内容", "超链接",
                    clickCallback: (value) {
                      BrnToast.show(value!, context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    })
              ],
            ),
            Text(
              '异常案例正常案例 key过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnPairInfoTable(
              isValueAlign: false,
              children: <BrnInfoModal>[
                BrnInfoModal(
                    keyPart: "名称：",
                    valuePart: "内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal(
                    keyPart: "名称名：",
                    valuePart: "内容内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.keyOrValueLastQuestionInfo(
                    "名称名称名称名称名称名名称名称名称名称", "内容内容内容内容内容",
                    keyShow: true,
                    valueShow: true,
                    keyCallback: () {
                      BrnToast.show('key question', context);
                    },
                    valueCallback: () {
                      BrnToast.show('value question', context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
              ],
            ),
            Text(
              '异常案例正常案例 key过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnPairInfoTable(
              isValueAlign: true,
              children: <BrnInfoModal>[
                BrnInfoModal(
                    keyPart: "名称：",
                    valuePart: "内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal(
                    keyPart: "名称名：",
                    valuePart: "内容内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.keyOrValueLastQuestionInfo(
                    "名称名称名称名称名称名名称名称名称名称", "内容内容内容内容内容",
                    keyShow: true,
                    valueShow: true,
                    keyCallback: () {
                      BrnToast.show('key question', context);
                    },
                    valueCallback: () {
                      BrnToast.show('value question', context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
              ],
            ),
            Text(
              '异常案例正常案例 内容过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnPairInfoTable(
              isValueAlign: true,
              children: <BrnInfoModal>[
                BrnInfoModal(
                    keyPart: "名称：",
                    valuePart: "内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal(
                    keyPart: "名称名：",
                    valuePart: "内容内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.keyOrValueLastQuestionInfo(
                    "名称名称名", "内容内容内容内容内容内容内容内容内容内容",
                    keyShow: true,
                    valueShow: true,
                    keyCallback: () {
                      BrnToast.show('key question', context);
                    },
                    valueCallback: () {
                      BrnToast.show('value question', context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
              ],
            ),
            Text(
              '异常案例正常案例 内容过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnPairInfoTable(
              isValueAlign: false,
              children: <BrnInfoModal>[
                BrnInfoModal(
                    keyPart: "名称：",
                    valuePart: "内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal(
                    keyPart: "名称名：",
                    valuePart: "内容内容内容内容内容",
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
                BrnInfoModal.keyOrValueLastQuestionInfo(
                    "名称名称名", "内容内容内容内容内容内容内容内容内容内容",
                    keyShow: true,
                    valueShow: true,
                    keyCallback: () {
                      BrnToast.show('key question', context);
                    },
                    valueCallback: () {
                      BrnToast.show('value question', context);
                    },
                    isArrow: true,
                    valueClickCallback: () {
                      BrnToast.show('内容内容内容内容', context);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
