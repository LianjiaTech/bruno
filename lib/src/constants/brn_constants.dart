class BrnShareItemConstants {
  /// 分享渠道名称列表
  static const List<String> shareItemTitleList = [
    "微信",
    "朋友圈",
    "QQ",
    "QQ空间",
    "微博",
    "链接",
    "短信",
    "剪贴板",
    "浏览器",
    "相册"
  ];

  /// 分享渠道图片地址列表
  static const List<String> shareItemImagePathList = [
    "images/icon_share_weChat.png",
    "images/icon_share_moments.png",
    "images/icon_share_qq.png",
    "images/icon_share_zone.png",
    "images/icon_share_weibo.png",
    "images/icon_share_shareLink.png",
    "images/icon_share_message.png",
    "images/icon_share_copy.png",
    "images/icon_share_browser.png",
    "images/icon_share_save_image.png",
  ];

  /// 不可点击的分享渠道图片地址列表
  static const List<String> disableShareItemImagePathList = [
    "images/icon_share_weChat_disable.png",
    "images/icon_share_moments_disable.png",
    "images/icon_share_qq_disble.png",
    "images/icon_share_zone_disable.png",
    "images/icon_share_weibo_disable.png",
    "images/icon_share_shareLink_disable.png",
    "images/icon_share_message_disable.png",
    "images/icon_share_copy_disable.png",
    "images/icon_share_browser_disable.png",
    "images/icon_share_save_image_disable.png",
  ];

  /// 微信
  static const int shareWeiXin = 0;

  /// 朋友圈
  static const int shareFriend = 1;

  /// qq
  static const int shareQQ = 2;

  /// qq空间
  static const int shareQZone = 3;

  /// 微博
  static const int shareWeiBo = 4;

  /// 链接
  static const int shareLink = 5;

  /// 短信
  static const int shareSms = 6;

  /// 剪贴板
  static const int shareCopyLink = 7;

  /// 浏览器
  static const int shareBrowser = 8;

  /// 相册
  static const int shareSaveImage = 9;

  /// 自定义
  static const int shareCustom = 100;
}

class BrnSelectionConstant {
  static const int maxSelectCount = 65535;
}

class BrnButtonConstant {
  /// 默认水平间距
  static const double horizontalPadding = 6;

  /// 默认垂直间距
  static const double verticalPadding = 8;
}