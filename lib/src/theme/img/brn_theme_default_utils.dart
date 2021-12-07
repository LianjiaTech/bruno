import 'dart:ui';

import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/img/brn_theme_img_utils.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

class BrnThemeImg {
  BrnThemeImgUtils _defaultBrunoImg;

  static BrnThemeImg _instance;

  BrnThemeImg._(BrnThemeImgUtils brunoImgUtils) {
    this._defaultBrunoImg = brunoImgUtils ?? BrnDefaultThemeImgUtil();
  }

  factory BrnThemeImg.register({BrnThemeImgUtils brunoImgUtils}) {
    _instance = BrnThemeImg._(brunoImgUtils);
    return _instance;
  }

  static BrnThemeImg get instance {
    if (_instance == null) {
      BrnThemeImg.register();
    }
    return _instance;
  }

  Image get ARROW_REFRESH_UP =>
      _defaultBrunoImg?.getARROW_REFRESH_UP() ??
      BrunoTools.getAssetImage(BrnAsset.refreshArrowUp);

  Image get ARROW_REFRESH_DOWN =>
      _defaultBrunoImg?.getARROW_REFRESH_DOWN() ??
      BrunoTools.getAssetImage(BrnAsset.refreshArrowDown);

  Image get CHECKED_STATUS =>
      _defaultBrunoImg?.getCHECKED_STATUS() ??
      BrunoTools.getAssetImage(BrnAsset.SELECT_CHECKED_STATUS);

  Image get STEP_ICON {
    return _defaultBrunoImg?.getStepIcon() ?? BrunoTools.getAssetImage(BrnAsset.stepTitle);
  }
}

///默认link绿
class BrnDefaultThemeImgUtil extends BrnThemeImgUtils {
  @override
  Image getARROW_REFRESH_UP() {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.refreshArrowUp);
  }

  @override
  Image getARROW_REFRESH_DOWN() {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.refreshArrowDown);
  }

  @override
  Image getCHECKED_STATUS() {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.SELECT_CHECKED_STATUS);
  }

  @override
  Image getStepIcon() {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.stepTitle);
  }
}
