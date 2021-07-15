//
//  CreateCategoryViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/02.
//

import UIKit

import Moya
import RxMoya
import RxSwift
import SnapKit
import SwiftyColor
import Then

// MARK: - CreateCategoryViewController
class CreateCategoryViewController: UIViewController {
  
  // MARK: - Components
  let backButton = UIButton()
  let titleLabel = UILabel()
  let categoryNameLabel = UILabel()
  let categoryNameTextField = UITextField()
  let categoryNameCountLabel = UILabel()
  let categoryCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: flowLayout)
    collectionView.isScrollEnabled = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let confirmButton = UIButton()
  final let maxLength = 10
  
  var nameCount = 0
  var selectedNumber: Int?
  
  let disposeBag = DisposeBag()
  let categoryProvider = MoyaProvider<CategoryService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
    register()
    self.categoryCollectionView.delegate = self
    self.categoryCollectionView.dataSource = self
    self.categoryNameTextField.delegate = self
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.textDidChange(_:)),
                                           name: UITextField.textDidChangeNotification,
                                           object: self.categoryNameTextField)
  }
  override func viewDidLayoutSubviews() {
    super .viewDidLayoutSubviews()
    self.categoryNameTextField.underlined(color: 0xC4C4C4.color)
    self.categoryNameTextField.clearButtonMode = .whileEditing
  }
}

// MARK: - Extensions
extension CreateCategoryViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = .white
    layoutBackButton()
    layoutTitleLabel()
    layoutCategoryNameLabel()
    layoutCategoryNameTextField()
    layoutCategoryNameCountLabel()
    layoutConfirmButton()
    layoutCategoryCollectionView()
  }
  func layoutBackButton() {
    view.add(backButton) {
      $0.setBackgroundImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedBackButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(29)
        $0.leading.equalTo(self.view.snp.leading).offset(31)
        $0.width.equalTo(10)
        $0.height.equalTo(18)
      }
    }
  }
  func layoutTitleLabel() {
    view.add(titleLabel) {
      $0.setupLabel(text: "새 카테고리",
                    color: .black,
                    font: .notoSansKRRegularFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.centerY.equalTo(self.backButton.snp.centerY)
      }
    }
  }
  func layoutCategoryNameLabel() {
    view.add(categoryNameLabel) {
      $0.setupLabel(text: "이름",
                    color: .black,
                    font: .notoSansKRBoldFont(fontSize: 15))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.backButton.snp.leading)
        $0.top.equalTo(self.backButton.snp.bottom).offset(62)
      }
    }
  }
  func layoutCategoryNameTextField() {
    view.add(categoryNameTextField) {
      $0.configureTextField(textColor: .black,
                            font: .notoSansKRRegularFont(fontSize: 15))
      $0.attributedPlaceholder =
        NSAttributedString(string: "새 카테고리 이름",
                           attributes:
                            [NSAttributedString.Key.font:
                              UIFont.notoSansKRRegularFont(fontSize: 15),
                             NSAttributedString.Key.foregroundColor:
                              0x929292.color])
      $0.returnKeyType = .default
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.categoryNameLabel.snp.leading)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.categoryNameLabel.snp.bottom).offset(17)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutCategoryNameCountLabel() {
    view.add(categoryNameCountLabel) {
      self.nameCount = self.categoryNameTextField.text?.count ?? 0
      $0.setupLabel(text: "\(self.nameCount)/10",
                    color: 0x929292.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.categoryNameTextField.snp.bottom).offset(10)
        $0.leading.equalTo(self.view.snp.trailing).offset(-60)
      }
    }
  }
  func layoutConfirmButton() {
    view.add(confirmButton) {
      $0.setupButton(title: "완료",
                     color: .white,
                     font: .notoSansKRMediumFont(fontSize: 16),
                     backgroundColor: 0xC4C4C4.color, state: .normal,
                     radius: 24.5)
      $0.addTarget(self,
                   action: #selector(self.clickedConfirmButton),
                   for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.bottom.equalTo(self.view.snp.bottom).offset(-260)
        $0.width.equalTo(154)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutCategoryCollectionView() {
    view.add(categoryCollectionView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.snp.leading).offset(38)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.categoryNameTextField.snp.bottom).offset(60)
        $0.height.equalTo(119)
      }
    }
  }
  // MARK: - General Helpers
  func register() {
    self.categoryCollectionView.register(
      CategoryCollectionViewCell.self,
      forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
  }
  @objc func clickedBackButton() {
    self.navigationController?.popViewController(animated: true)
  }
  @objc func clickedConfirmButton() {
    /// TOOD: Server Connection
    if self.selectedNumber == nil {
      self.showGrayToast(message: "카테고리를 선택해주세요")
    }
    else if self.categoryNameTextField.hasText == false {
      self.showGrayToast(message: "카테고리 이름을 입력해주세요")
    }
    else {
      addCategory(colorIndex: self.selectedNumber!, categoryName: self.categoryNameTextField.text!)
    }
    self.navigationController?.viewControllers[0].dismiss(animated: false, completion: nil)
    self.navigationController?.popToRootViewController(animated: true)
  }
  @objc func textDidChange(_ notification: Notification) {
    if let textField = notification.object as? UITextField {
      if let text = textField.text {
        self.categoryNameCountLabel.text = "\(text.count)/10"
        if text.count > self.maxLength {
          textField.resignFirstResponder()
        }
        if text.count >= maxLength {
          let index = text.index(text.startIndex, offsetBy: maxLength)
          let newString = text[text.startIndex..<index]
          textField.text = String(newString)
        }
      }
    }
  }
  func addCategory(colorIndex: Int, categoryName: String) {
    categoryProvider.rx.request(.createCategory(colorIndex: colorIndex, categoryName: categoryName))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            print(response.statusCode)
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
}

// MARK: - CategoryCollectionView DataSource
extension CreateCategoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let categoryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? CategoryCollectionViewCell else {
      return UICollectionViewCell()
    }
    categoryCell.awakeFromNib()
    categoryCell.colorView.image = UIImage(named: "colorchip\(indexPath.item+1)")
    if selectedNumber == indexPath.item {
      categoryCell.colorView.image = UIImage(named: "colorchipSelected\(indexPath.item+1)")
    }
    return categoryCell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.selectedNumber = indexPath.item
    collectionView.reloadData()
  }
}

// MARK: - CategoryCollectionView DelegateFlowLayout
extension CreateCategoryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 68)
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}

// MARK: - CategoryNameTextField Delegate
extension CreateCategoryViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else {return false}
    if text.count >= self.maxLength &&
        range.length == 0 &&
        range.location < self.maxLength {
      return false
    }
    return true
  }
}
