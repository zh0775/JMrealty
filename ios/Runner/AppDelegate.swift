import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    GeneratedPluginRegistrant.register(with: self)
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let viewController = storyboard.instantiateViewController(withIdentifier: "JMViewController")
//////
//    window = UIWindow(frame: UIScreen.main.bounds)
//    window?.rootViewController = UINavigationController(rootViewController: viewController)
//    window?.makeKeyAndVisible()
    
    Thread.sleep(forTimeInterval: 3.0);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
    

}




