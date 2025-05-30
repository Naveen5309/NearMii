import UIKit
import Flutter
import GoogleMobileAds

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
          // Initialize Google Mobile Ads
     GADMobileAds.sharedInstance().start(completionHandler: nil)
     GADMobileAds.sharedInstance().start(completionHandler: nil)
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
