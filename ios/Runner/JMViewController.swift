//
//  JMViewController.swift
//  Runner
//
//  Created by 张涵 on 2021/2/4.
//
import UIKit
import Flutter

class JMViewController: FlutterViewController {
    var first = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        if (first) {
            GeneratedPluginRegistrant.register(with: self)
            first = false
        }
        
//        UIApplication.shared.isStatusBarHidden = true
//        if (self.responds(to: #selector(self.setNeedsStatusBarAppearanceUpdate))) {
//            self.prefersStatusBarHidden
//            self.perform(#selector(self.setNeedsStatusBarAppearanceUpdate))
//        }
//        self.responds(to: Selector("setNeedsStatusBarAppearanceUpdate:"))
//        if([self responds(to: Selector.init("setNeedsStatusBarAppearanceUpdate:"))){
//            [self prefersStatusBarHidden];
//            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//        }.

        self.automaticallyAdjustsScrollViewInsets = false
//        var img: UIImage = UIImage(cgImage: CGImage())
//        UIImage *backImage = [self imageWithColor:[UIColor clearColor]];
//
//       [self.navigationController.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
//
//       [self.navigationController.navigationBar setShadowImage:backImage];
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let channel = FlutterMethodChannel(name: "com.jm/jmGoToNativePage",
                                               binaryMessenger: self as! FlutterBinaryMessenger)
    ////
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in

            let arguments = call.arguments as! NSDictionary

            guard call.method == "goToNativePage" else {
                result(FlutterMethodNotImplemented)
                return
            }
    //        self?.window.rootViewController
            self?.goToNativePage(result: arguments)
        })
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
        
    }
    override var childForStatusBarStyle: UIViewController?{
        return self
    }
    
    private func goToNativePage(result: NSDictionary) {
        let url: String = result["url"] as! String
        let json: String = result["json"] as! String
        let vc:UIViewController! = JMWebController(String(url), String(json))
        self.navigationController?.pushViewController(vc, animated: true)
  }
}
