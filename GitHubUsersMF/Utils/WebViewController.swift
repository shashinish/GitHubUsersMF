//
//  WebViewController.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    var webView: WKWebView?
    var repoURLString: String?
    var repoName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.frame, configuration: theConfiguration)
        
        guard let url = repoURLString else {return}
        print(url)
        let nsurl = URL(string: url)
        var nsrequest: URLRequest? = nil
        if let nsurl = nsurl {
            nsrequest = URLRequest(url: nsurl)
        }
        if let nsrequest = nsrequest {
            webView?.load(nsrequest)
        }
        if let webView = self.webView {
            view.addSubview(webView)
        }
        
        if let repoName = self.repoName {
            title = repoName
        }

    }
    
    init(repoUrl: String, repoName: String){
        super.init(nibName: nil, bundle: nil)
        self.repoURLString = repoUrl
        self.repoName = repoName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
