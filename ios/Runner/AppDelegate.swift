import UIKit
import Flutter
import flutter_downloader
import FirebaseCore
import flutter_local_notifications


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "custom_share"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
          GeneratedPluginRegistrant.register(with: registry)
    }

    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let customShareChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

      customShareChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "shareUrl" else {
          result(FlutterMethodNotImplemented)
          return
        }
        self?.shareUrl(call: call, result: result)
      }
      
    if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
          }
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func shareUrl(call: FlutterMethodCall, result: @escaping FlutterResult) {
      guard let args = call.arguments as? [String: Any],
            let urlString = args["url"] as? String,
            let url = URL(string: urlString) else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "URL is null", details: nil))
        return
      }
        

      let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
      controller.popoverPresentationController?.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
      UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true, completion: nil)
      result(nil)
    }
}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}




