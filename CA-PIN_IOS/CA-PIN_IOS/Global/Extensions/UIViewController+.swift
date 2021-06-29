//
//  CALayer+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//


import UIKit

extension UIViewController {
	
	/// 🍞
	/// - Parameters:
	///   - message: 메세지
	///   - isBottom: 토스트 메세지가 어디에 붙는지 지정을 해줍니다. ( true: top / false: bottom)
	///   - yAnchor: 토스트 메세지가 safeArea로부터 얼마나 떨어져있을지 설정해줍니다.
	///   - textColor: text color
	///   - textFont: text font
	///   - backgroundColor: background color
	///   - backgroundRadius: 테두리의 radius
	///   - duration: 지속 시간을 지정해줍니다.
	
	func showToast(_ message: String,
								 isBottom: Bool = true,
								 yAnchor: CGFloat = 0,
								 textColor: UIColor = .white,
								 textFont: UIFont = .boldSystemFont(ofSize: 16),
								 backgroundColor: UIColor = .black,
								 backgroundRadius: CGFloat = 6,
								 duration: TimeInterval = 5) {
		
		let label = UILabel()
		let backgroundView = UIView()
		
		backgroundView.backgroundColor = backgroundColor.withAlphaComponent(0.6)
		backgroundView.layer.cornerRadius = backgroundRadius
		label.textColor = textColor
		label.textAlignment = .center
		label.font = textFont
		label.text = message
		label.alpha = 1.0
		label.clipsToBounds  =  true
		
		self.view.addSubview(backgroundView)
		self.view.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		if isBottom {
			label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
																		constant: -yAnchor).isActive = true
		} else {
			label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
																 constant: yAnchor).isActive = true
			
		}
		label.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
		backgroundView.leadingAnchor.constraint(equalTo: label.leadingAnchor,
																						constant: -20).isActive = true
		backgroundView.trailingAnchor.constraint(equalTo: label.trailingAnchor,
																						 constant: 20).isActive = true
		backgroundView.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
		
		UIView.animate(withDuration: duration,
                   delay: 0.1,
                   options: .curveEaseOut,
                   animations: {
			label.alpha = 0.0
			backgroundView.alpha = 0.0
		},
                   completion: { _ in
			label.removeFromSuperview()
			backgroundView.removeFromSuperview()
		})
	}
	func setupStatusBar(_ color: UIColor) {
		if #available(iOS 13.0, *) {
			let margin = view.layoutMarginsGuide
			let statusbarView = UIView()
			statusbarView.backgroundColor = color
			statusbarView.frame = CGRect.zero
			view.addSubview(statusbarView)
			statusbarView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
				statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
				statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
			])
			
		} else {
			let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
			statusBar?.backgroundColor = color
		}
	}
	func setupNavigationBar(_ color: UIColor) {
		guard let navigationBar = self.navigationController?.navigationBar else { return }
		
		navigationBar.isTranslucent = true
		navigationBar.backgroundColor = color
		navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationBar.shadowImage = UIImage()
	}
	func pullToRefresh(collectionview: UICollectionView) {
		let refreshControl = UIRefreshControl()
		collectionview.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refresh(_:)),
                             for: .valueChanged)
	}
	func pullToRefresh(tableview: UITableView) {
		let refreshControl = UIRefreshControl()
		tableview.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refresh(_:)),
                             for: .valueChanged)
	}
	func pullToRefresh(scrollview: UIScrollView) {
		let refreshControl = UIRefreshControl()
		scrollview.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refresh(_:)),
                             for: .valueChanged)
	}
	@objc private func refresh(_ sender: UIRefreshControl) {
		self.viewDidLoad()
		sender.endRefreshing()
	}
}
