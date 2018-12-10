//
//  DetailViewController.swift
//  White House Petitions
//
//  Created by Kumara Prasad on 28/09/18.
//  Copyright © 2018 Matrix. All rights reserved.
//
import UIKit
import WebKit
class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: [String: String]!
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard detailItem != nil else { return }
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=devicewidth,initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}
