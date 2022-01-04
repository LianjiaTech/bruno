import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/img/brn_theme_img_utils.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

class BrnThemeImg {
  BrnThemeImg._(
    BrnThemeImgUtils? brunoImgUtils,
  ) : _defaultBrunoImg = brunoImgUtils ?? BrnDefaultThemeImgUtil();

  factory BrnThemeImg.register({BrnThemeImgUtils? brunoImgUtils}) {
    _instance = BrnThemeImg._(brunoImgUtils);
    return _instance!;
  }

  static BrnThemeImg get instance {
    if (_instance == null) {
      BrnThemeImg.register();
    }
    return _instance!;
  }

  static BrnThemeImg? _instance;

  BrnThemeImgUtils _defaultBrunoImg;

  Image get arrowRefreshUp =>
      _defaultBrunoImg.arrowRefreshUp ??
      BrunoTools.getAssetImage(BrnAsset.refreshArrowUp);

  Image get arrowRefreshDown =>
      _defaultBrunoImg.arrowRefreshDown ??
      BrunoTools.getAssetImage(BrnAsset.refreshArrowDown);

  Image get checkedStatus =>
      _defaultBrunoImg.checkedStatus ??
      BrunoTools.getAssetImage(BrnAsset.selectCheckedStatus);

  Image get stepIcon {
    return _defaultBrunoImg.stepIcon ??
        BrunoTools.getAssetImage(BrnAsset.stepTitle);
  }
}

class BrnDefaultThemeImgUtil extends BrnThemeImgUtils {
  @override
  Image get arrowRefreshUp {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.refreshArrowUp);
  }

  @override
  Image get arrowRefreshDown {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.refreshArrowDown);
  }

  @override
  Image get checkedStatus {
    return BrunoTools.getAssetImageWithBandColor(
        BrnAsset.selectCheckedStatus);
  }

  @override
  Image get stepIcon {
    return BrunoTools.getAssetImageWithBandColor(BrnAsset.stepTitle);
  }
}
