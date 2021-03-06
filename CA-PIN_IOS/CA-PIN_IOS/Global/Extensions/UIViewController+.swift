//
//  CALayer+.swift
//  CA-PIN_IOS
//
//  Created by ๋ธํ์ on 2021/06/28.
//


import UIKit

extension UIViewController {
  
  /// ๐
  /// - Parameters:
  ///   - message: ๋ฉ์ธ์ง
  ///   - isBottom: ํ ์คํธ ๋ฉ์ธ์ง๊ฐ ์ด๋์ ๋ถ๋์ง ์ง์ ์ ํด์ค๋๋ค. ( true: top / false: bottom)
  ///   - yAnchor: ํ ์คํธ ๋ฉ์ธ์ง๊ฐ safeArea๋ก๋ถํฐ ์ผ๋ง๋ ๋จ์ด์ ธ์์์ง ์ค์ ํด์ค๋๋ค.
  ///   - textColor: text color
  ///   - textFont: text font
  ///   - backgroundColor: background color
  ///   - backgroundRadius: ํ๋๋ฆฌ์ radius
  ///   - duration: ์ง์ ์๊ฐ์ ์ง์ ํด์ค๋๋ค.

  
  func showGrayToast(message: String) {
    
    /// ๋ทฐ๊ฐ ์์นํ  ์์น๋ฅผ ์ง์ ํด์ค๋ค. ์ฌ๊ธฐ์๋ ์๋๋ก๋ถํฐ 99๋งํผ ๋จ์ด์ ธ์๊ณ , ๋๋น๋ ์์ชฝ์ 20๋งํผ ์ฌ๋ฐฑ์ ๊ฐ์ง๋ฉฐ, ๋์ด๋ 48๋ก
    let toastView = UIView()
    
    let containerView = UIView() /// ์ด๋ฏธ์ง . ๋ฉ์์ง
    
    let iconImage = UIImageView()
    iconImage.image = UIImage(named: "icnError")
    
    /// ์ฌ์ฉํ๋ ค๋ ๋ผ๋ฒจ ํฌ๊ธฐ ๋ฐ์์ ๋์ ์ผ๋ก ํฌ๊ธฐ ๋ง์ถฐ์ค๊ฑฐ์
    let toastLabel = UILabel().then {
      $0.textColor = UIColor.black
      $0.letterSpacing = -0.7
      $0.textAlignment = .center
      $0.font = .notoSansKRRegularFont(fontSize: 14)
      $0.text = message
      $0.sizeToFit()
    }
    let width = toastLabel.frame.width
    
    self.view.addSubview(toastView)
    toastView.addSubview(containerView)
    containerView.addSubview(iconImage)
    containerView.addSubview(toastLabel)
    
    toastView.translatesAutoresizingMaskIntoConstraints = false
    toastView.widthAnchor.constraint(equalToConstant: view.frame.size.width-40).isActive = true
    toastView.heightAnchor.constraint(equalToConstant: 49).isActive = true
    toastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    toastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    toastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -99).isActive = true
    toastView.cornerRadius = 10
    toastView.backgroundColor = .gray1
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.widthAnchor.constraint(equalToConstant: 32+width).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    containerView.centerXAnchor.constraint(equalTo: toastView.centerXAnchor).isActive = true
    containerView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor).isActive = true
    containerView.backgroundColor = .clear
    
    iconImage.translatesAutoresizingMaskIntoConstraints = false
    iconImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
    iconImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
    iconImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    iconImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    iconImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor).isActive = true
    toastLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
  
    UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
        toastView.alpha = 0.0
    }, completion: { _ in
        toastView.removeFromSuperview()
    })
  }
  
  func showGreenToast(message: String) {
    
    /// ๋ทฐ๊ฐ ์์นํ  ์์น๋ฅผ ์ง์ ํด์ค๋ค. ์ฌ๊ธฐ์๋ ์๋๋ก๋ถํฐ 99๋งํผ ๋จ์ด์ ธ์๊ณ , ๋๋น๋ ์์ชฝ์ 20๋งํผ ์ฌ๋ฐฑ์ ๊ฐ์ง๋ฉฐ, ๋์ด๋ 48๋ก
    let toastView = UIView()
    
    let containerView = UIView() /// ์ด๋ฏธ์ง . ๋ฉ์์ง
    
    let iconImage = UIImageView()
    iconImage.image = UIImage(named: "checkRoundOn")
    
    /// ์ฌ์ฉํ๋ ค๋ ๋ผ๋ฒจ ํฌ๊ธฐ ๋ฐ์์ ๋์ ์ผ๋ก ํฌ๊ธฐ ๋ง์ถฐ์ค๊ฑฐ์
    let toastLabel = UILabel().then {
      $0.textColor = UIColor.white
      $0.letterSpacing = -0.7
      $0.textAlignment = .center
      $0.font = .notoSansKRRegularFont(fontSize: 14)
      $0.text = message
      $0.sizeToFit()
    }
    let width = toastLabel.frame.width
    
    self.view.addSubview(toastView)
    toastView.addSubview(containerView)
    containerView.addSubview(iconImage)
    containerView.addSubview(toastLabel)
    
    toastView.translatesAutoresizingMaskIntoConstraints = false
    toastView.widthAnchor.constraint(equalToConstant: view.frame.size.width-40).isActive = true
    toastView.heightAnchor.constraint(equalToConstant: 49).isActive = true
    toastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    toastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    toastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -99).isActive = true
    toastView.cornerRadius = 10
    toastView.backgroundColor = .pointcolorGreen
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.widthAnchor.constraint(equalToConstant: 32+width).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    containerView.centerXAnchor.constraint(equalTo: toastView.centerXAnchor).isActive = true
    containerView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor).isActive = true
    containerView.backgroundColor = .clear
    
    iconImage.translatesAutoresizingMaskIntoConstraints = false
    iconImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
    iconImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
    iconImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    iconImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    iconImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor).isActive = true
    toastLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
  
    UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
        toastView.alpha = 0.0
    }, completion: { _ in
        toastView.removeFromSuperview()
    })
  }
  
  func showShortGrayToast(message: String) {
    
    /// ๋ทฐ๊ฐ ์์นํ  ์์น๋ฅผ ์ง์ ํด์ค๋ค. ์ฌ๊ธฐ์๋ ์๋๋ก๋ถํฐ 99๋งํผ ๋จ์ด์ ธ์๊ณ , ๋๋น๋ ์์ชฝ์ 20๋งํผ ์ฌ๋ฐฑ์ ๊ฐ์ง๋ฉฐ, ๋์ด๋ 48๋ก
    let toastView = UIView()
    
    let containerView = UIView() /// ์ด๋ฏธ์ง . ๋ฉ์์ง
    
    let iconImage = UIImageView()
    iconImage.image = UIImage(named: "component40Eror")
    
    /// ์ฌ์ฉํ๋ ค๋ ๋ผ๋ฒจ ํฌ๊ธฐ ๋ฐ์์ ๋์ ์ผ๋ก ํฌ๊ธฐ ๋ง์ถฐ์ค๊ฑฐ์
    let toastLabel = UILabel().then {
      $0.textColor = UIColor.black
      $0.letterSpacing = -0.7
      $0.textAlignment = .center
      $0.font = .notoSansKRRegularFont(fontSize: 14)
      $0.text = message
      $0.sizeToFit()
    }
    let width = toastLabel.frame.width
    
    self.view.addSubview(toastView)
    toastView.addSubview(containerView)
    containerView.addSubview(iconImage)
    containerView.addSubview(toastLabel)
    
    toastView.translatesAutoresizingMaskIntoConstraints = false
    toastView.widthAnchor.constraint(equalToConstant: view.frame.size.width-40).isActive = true
    toastView.heightAnchor.constraint(equalToConstant: 49).isActive = true
    toastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    toastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    toastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -99).isActive = true
    toastView.cornerRadius = 10
    toastView.backgroundColor = .gray1
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.widthAnchor.constraint(equalToConstant: 32+width).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    containerView.centerXAnchor.constraint(equalTo: toastView.centerXAnchor).isActive = true
    containerView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor).isActive = true
    containerView.backgroundColor = .clear
    
    iconImage.translatesAutoresizingMaskIntoConstraints = false
    iconImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
    iconImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
    iconImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    iconImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    iconImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor).isActive = true
    toastLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
  
    UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
        toastView.alpha = 0.0
    }, completion: { _ in
        toastView.removeFromSuperview()
    })
  }
  
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
