//
//  TermsWebViewController.swift
//  CA-PIN_IOS
//
//  Created by hansol on 2022/01/21.
//

import UIKit
import WebKit

import SnapKit
import Then

// MARK: - TermsWebViewController

final class TermsWebViewController: UIViewController {

    // MARK: - Components
    
    private let termsWebView = WKWebView()
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
}

// MARK: - Extensions

extension TermsWebViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.add(termsWebView)
        termsWebView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(address: String) {
        termsWebView.load(URLRequest(url: URL(string: address)!))
    }
}
