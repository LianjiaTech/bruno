class BrnShareItemConstants {
  /// 分享渠道名称列表
  static const List shareItemTitleList = [
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
  static const List shareItemImagePathList = [
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
  static const List disableShareItemImagePathList = [
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
  static const int SHARE_WEIXIN = 0;

  /// 朋友圈
  static const int SHARE_FRIEND = 1;

  /// qq
  static const int SHARE_QQ = 2;

  /// qq空间
  static const int SHARE_QZONE = 3;

  /// 微博
  static const int SHARE_WEIBO = 4;

  /// 链接
  static const int SHARE_LINK = 5;

  /// 短信
  static const int SHARE_SMS = 6;

  /// 剪贴板
  static const int SHARE_COPY_LINK = 7;

  /// 浏览器
  static const int SHARE_BROWSER = 8;

  /// 相册
  static const int SHARE_SAVE_IMAGE = 9;

  /// 自定义
  static const int SHARE_CUSTOM = 100;
}

class BrnSelectionConstant {
  static const int MAX_SELECT_COUNT = 65535;
}
