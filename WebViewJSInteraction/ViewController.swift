//
//  ViewController.swift
//  WebViewJSInteraction
//
//  Created by Doug Mead on 5/25/16.
//  Copyright © 2016 Doug Mead. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var feedbackLabel: UILabel!

    @IBAction func buttonClicked(sender: AnyObject) {
        let js = "doSomethingReturnString()"
        let result = webView.stringByEvaluatingJavaScriptFromString(js)
        feedbackLabel.text = result
        feedbackLabel.sizeToFit()
    }
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.webView = UIWebView(frame: CGRect(x: 0.0, y: 20.0, width: 300.0, height: 175.0))
        webView.delegate = self
        self.view.addSubview(webView)
        
        let customURL = "doug://didClick/data=stuff"
        
        var js = "function onSendClick(){"
        js += "var testDiv = document.getElementById('testDiv');"
        js += "testDiv.innerHTML = '||| changed from js';"
        js += "var src = '\(customURL)';"
        js += "var iframe = document.createElement('iframe'); "
        js += "iframe.setAttribute('src', src); "
        js += "document.documentElement.appendChild(iframe); "
        js += "iframe.parentNode.removeChild(iframe); "
        js += "iframe = null;"
        js += ""
        js += ""
        js += ""
        js += "}"
        
        
        js += "function doSomethingReturnString() {"
        js += "var testDiv = document.getElementById('testDiv');"
        js += "testDiv.innerHTML = '*** changed by iOS!';"
        js += ""
        js += ""
        js += ""
        js += "return 'string returned from js'"
        js += "}"
        
        let body = "<br/><br/><div>Hello, world!</div><div id='testDiv'>was it clicked?</div><div onclick='onSendClick()' style='background-color: #99BBFF;'>click me</div><script>\(js)</script>"
        let htmlString = "<html><head></head><body>\(body)</body></html>"
        
        webView.loadHTMLString(htmlString, baseURL: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URL?.absoluteString == "about:blank" {
            return true
        }
        
        print("\(request.URL?.absoluteString) and type: \(navigationType)")
        
        feedbackLabel.text = "from webview: \(request.URL?.absoluteString ?? "nil")"
        feedbackLabel.sizeToFit()
        
        return false
        
    }
    
}

