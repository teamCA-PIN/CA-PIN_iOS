//
//  EditProfileViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/11/16.
//

import UIKit
import Then
import Moya
import RxMoya
import RxSwift

// MARK: - EditProfileViewController

class EditProfileViewController: UIViewController {
  
  // MARK: - Components
  let backButton = UIButton()
  let editProfileLabel = UILabel()
  let profileImageView = UIView()
  let myImageView = UIImageView()
  let editImageButton = UIButton()
  let nameTextView = UIView()
  let editNameLabel = UILabel()
  let nameExplanationLabel = UILabel()
  let nameTextField = UITextField()
  let separateView = UIView()
  let countLabel = UILabel()
  let completeButton = UIButton()
  let imagePicker = UIImagePickerController()
  
  let disposeBag = DisposeBag()
  let editProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  
  // MARK: - Variables
  var profileImage: String = ""
  var plainImage: String = ""
  var userName: String = ""
  var maxLength = 10
  var nameCount: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    layout()
    imagePicker.delegate = self
    nameTextField.delegate = self
    nameTextField.isUserInteractionEnabled = true
    nameTextView.bringSubviewToFront(nameTextField)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.textDidChange(_:)),
                                           name: UITextField.textDidChangeNotification,
                                           object: self.nameTextField)
  }
  
  override func viewDidLayoutSubviews() {
    ///subview들이 자리 잡은 후 레이아웃 조정 필요할 때 (ex. radius 값)
    self.myImageView.setRounded(radius: self.myImageView.frame.width/2)
    self.nameTextField.clearButtonMode = .whileEditing
  }
}

extension EditProfileViewController {
  func layout() {
    layoutBackButton()
    layoutEditProfileLabel()
    layoutProfileImageView()
    layoutMyImageView()
    layoutEditImageButton()
    layoutNameTextView()
    layoutEditNameLabel()
    layoutNameExplanationLabel()
    layoutNameTextField()
    layoutSeparateView()
    layoutCountLabel()
    layoutCompleteButton()
  }
  func layoutBackButton() {
    view.add(backButton) {
      $0.setImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(51)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.width.height.equalTo(28)
      }
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
    }
  }
  func layoutEditProfileLabel() {
    view.add(editProfileLabel) {
      $0.setupLabel(text: "프로필 편집", color: .black, font: .notoSansKRMediumFont(fontSize: 20), align: .center)
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(50)
        $0.height.equalTo(20)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutProfileImageView() {
    view.add(profileImageView) {
      $0.snp.makeConstraints {
        $0.width.height.equalTo(150)
        $0.top.equalTo(self.editProfileLabel.snp.bottom).offset(94)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutMyImageView() {
    profileImageView.add(myImageView) {
      $0.imageFromUrl(self.profileImage, defaultImgPath: "colorchip7")
      $0.snp.makeConstraints {
        $0.width.height.equalTo(150)
        $0.centerX.centerY.equalToSuperview()
      }
    }
  }
  func layoutEditImageButton() {
    profileImageView.add(editImageButton) {
      $0.setImage(UIImage(named: "component96"), for: .normal)
      $0.addTarget(self, action: #selector(self.editImageButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.height.equalTo(38)
        $0.trailing.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
  }
  func layoutNameTextView() {
    view.add(nameTextView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.profileImageView.snp.bottom).offset(43)
        $0.leading.equalToSuperview().offset(21)
        $0.trailing.equalToSuperview().offset(-21)
        $0.height.equalTo(118)
//        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutEditNameLabel() {
    self.nameTextView.add(editNameLabel) {
      $0.setupLabel(text: "이름 변경하기", color: .black, font: .notoSansKRMediumFont(fontSize: 20))
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutNameExplanationLabel() {
    self.nameTextView.add(nameExplanationLabel) {
      $0.setupLabel(text: "공백없이 2-10자 이내로 한글, 영문, 숫자만 입력 가능합니다.", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(32)
        $0.height.equalTo(17)
      }
    }
  }
  func layoutNameTextField() {
    self.nameTextView.add(nameTextField) {
      $0.configureTextField(textColor: .gray4, font: .notoSansKRRegularFont(fontSize: 16))
//      $0.placeholder = self.userName
//      $0.text = self.userName
      $0.attributedPlaceholder = NSAttributedString(string: self.userName,
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray4])
      $0.returnKeyType = .default
      $0.snp.makeConstraints {
        $0.trailing.equalToSuperview()
        $0.leading.equalToSuperview()
        $0.top.equalToSuperview().offset(65)
        $0.height.equalTo(28)
      }
    }
  }
  func layoutSeparateView() {
    self.nameTextView.add(separateView) {
      $0.backgroundColor = .gray4
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.leading.trailing.equalToSuperview()
        $0.top.equalTo(self.nameTextField.snp.bottom).offset(2)
      }
    }
  }
  func layoutCountLabel() {
    self.nameTextView.add(countLabel) {
      self.nameCount = self.nameTextField.text?.count ?? 0
      $0.setupLabel(text: "\(self.nameCount)/10",
                    color: .gray4,
                    font: .notoSansKRRegularFont(fontSize: 12),
                    align: .right)
      $0.snp.makeConstraints {
        $0.trailing.equalToSuperview().offset(-6)
        $0.top.equalTo(self.nameTextField.snp.bottom).offset(7)
      }
    }
  }
  func layoutCompleteButton() {
    view.add(completeButton) {
      $0.setupButton(title: "완료", color: .white,
                     font: .notoSansKRMediumFont(fontSize: 16), backgroundColor: .pointcolor1,
                     state: .normal, radius: 24.5)
      $0.addTarget(self, action: #selector(self.completeButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalToSuperview().offset(110)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(49)
        $0.bottom.equalTo(self.view.snp.bottom).offset(-34)
      }
    }
  }
  
  // MARK: - objc functions
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: true)
  }
  @objc func editImageButtonClicked() {
    let alertController: UIAlertController
    alertController = UIAlertController(title: "프로필 사진 설정", message: nil, preferredStyle: .actionSheet)
    
    let chooseFromAlbumAction: UIAlertAction
    chooseFromAlbumAction = UIAlertAction(title: "앨범에서 사진 선택", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
      self.imagePicker.sourceType = .photoLibrary
      self.imagePicker.allowsEditing = true
      self.present(self.imagePicker, animated: true, completion: nil)
    })
    let chooseDefaultAction: UIAlertAction
    chooseDefaultAction = UIAlertAction(title: "기본 이미지로 변경", style: .default, handler: { (action: UIAlertAction) in
      self.myImageView.imageFromUrl(self.plainImage, defaultImgPath: "colorchip7")
    })
    
    let cancelAction: UIAlertAction
    cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
    
    alertController.addAction(chooseFromAlbumAction)
    alertController.addAction(chooseDefaultAction)
    alertController.addAction(cancelAction)
    
    alertController.view.tintColor = .maincolor1
    
    self.present(alertController, animated: true, completion: nil)
  }
  @objc func completeButtonClicked() {
    editProfile()
  }
  
  @objc func textDidChange(_ notification: Notification) {
    if let textField = notification.object as? UITextField {
      if let text = textField.text {
        self.countLabel.text = "\(text.count)/10"
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
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - General Helpers
  func editProfile() {
    var newUserName = ""
    
    if self.nameTextField.hasText == false { /// 원래 이름 그대로
      newUserName = userName
    }
    else { /// 새로운 이름
      newUserName = nameTextField.text!
    }

    var newProfileImage = UIImage()
    newProfileImage = self.myImageView.image!
    
    editProvider.rx.request(.editMyInfo(nickname: newUserName, profilImg: newProfileImage))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            var index = self.navigationController?.viewControllers.endIndex ?? 1
            guard let mypageVC = self.navigationController?.viewControllers[index-2] as? MypageViewController else { return }
            mypageVC.nicknameLabel.text = newUserName
            mypageVC.profileImageView.image = newProfileImage
            self.navigationController?.popViewController(animated: false) {
              mypageVC.showGreenToast(message: "프로필 편집이 완료되었습니다.")
            }
          } catch {
            print(error)
          }
        }
        else {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(Response.self, from: response.data)
            if let message = data.message {
              self.showGrayToast(message: message)
            }
          } catch {
            
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] {
      myImageView.image = image as! UIImage
      
      myImageView.layer.cornerRadius = myImageView.frame.height / 2
      myImageView.layer.borderWidth = 1
      myImageView.layer.borderColor = UIColor.clear.cgColor
      myImageView.clipsToBounds = true
    }
    dismiss(animated: true , completion: nil)
  }
}

extension EditProfileViewController: UINavigationControllerDelegate {
  
}

extension EditProfileViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true
    guard let text = textField.text else {return false}
    if text.count >= self.maxLength &&
        range.length == 0 &&
        range.location < self.maxLength {
      return false
    }
    return false
  }
}
