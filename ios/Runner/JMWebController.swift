//
//  JMWebController.swift
//  Runner
//
//  Created by 张涵 on 2021/2/3.
//

import UIKit
import WebKit

class JMWebController: UIViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler{
    var url: String?;
    var json: String?;
//    var uivc: UIViewController;
    init(_ webUrl: String,_ jsjson :String) {
        super.init(nibName: nil, bundle: nil)
        self.url = webUrl
        self.json = jsjson
//        uivc = uiVC
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.setupWebView()
    }

    func setupWebView() {
        self.view.addSubview(self.webView)
    }


    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        // JS端调用prompt函数时，会触发此方法
        // 要求输入一段文本
        // 在原生输入得到文本内容后，通过completionHandler回调给JS
        let alertTextField = UIAlertController.init(title: "请输入", message: "JS调用输入框", preferredStyle: UIAlertController.Style.alert)
        alertTextField.addTextField { (textField:UITextField) in
            //设置textField相关属性
            textField.textColor = UIColor.red
        }
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.destructive) { (action:UIAlertAction) in
            //确定
            completionHandler(alertTextField.textFields?.last?.text)
        }
        alertTextField.addAction(okAction)
        self.present(alertTextField, animated: true, completion: nil)
    }

    //MARK:-WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //页面开始加载，可在这里给用户loading提示
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //内容开始到达时
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //页面加载完成时
        webView.evaluateJavaScript(self.json!) { (_ result: Any?, _ err:Error?) in
//            print("Any === \(result) err === \(err)")
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //页面加载出错，可在这里给用户错误提示
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        //收到服务器重定向请求
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // 在请求开始加载之前调用，决定是否跳转
        decisionHandler(WKNavigationActionPolicy.allow)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //在收到响应开始加载后，决定是否跳转
        decisionHandler(WKNavigationResponsePolicy.allow)
    }

    //MARK:-WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //h5给端传值的内容，可在这里实现h5与原生的交互时间
        let messageDic = message.body
        let messageName = message.name
        
        if (message.name == "back" && self.url?.range(of:"summary") != nil) {
            self.navigationController?.popViewController(animated: true);
        }
//
        print(messageDic)
        print(messageName)
        
    }
    

    //MARK:-lazy
    
    lazy var webView: WKWebView = {
        let screenBounds = UIScreen.main.bounds
        let myWebView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height), configuration: self.webConfiguration)
//        let web_url = URL.init(string: self.url!)
        let web_url = URL.init(string: self.url!)
        myWebView.load(URLRequest.init(url: web_url!))
        myWebView.navigationDelegate = self
        myWebView.uiDelegate = self
        
        if #available(iOS 11.0, *) {
            myWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
            self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        }
        
        return myWebView
    }()

    lazy var webConfiguration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration.init()
        let preferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        configuration.preferences = preferences
        configuration.userContentController = self.webUserContentController
        return configuration
    }()

    lazy var webUserContentController: WKUserContentController = {
        let userConetentController = WKUserContentController.init()
        userConetentController.add(self, name: "back")
        return userConetentController
    }()
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
