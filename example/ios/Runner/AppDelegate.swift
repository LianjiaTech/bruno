import UIKit
import Flutter

/// 如果要调试局部显示 flutter 页面的功能，请打开此开关
let kShouldDebugFlutterInNative = false;

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
//    if (kShouldDebugFlutterInNative) {
//        self.window.backgroundColor = UIColor.white;
//        let homeVC = HomeViewController.init();
//        homeVC.flutterVC = self.window.rootViewController!;
//        homeVC.addChild(homeVC.flutterVC);
//        homeVC.flutterVC.view.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 100), size: CGSize.init(width: 200, height: 400));
//        homeVC.view.addSubview(homeVC.flutterVC.view);
//        self.window.rootViewController = homeVC;
//    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
