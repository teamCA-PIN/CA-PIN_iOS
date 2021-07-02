//
//  CafeTITest1ViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/01.
//

import UIKit

import SnapKit
import Then

// MARK: - CafeTITest1ViewController

class CafeTITest1ViewController: UIViewController {

    // MARK: - Components
    
    let questiontitleLabel = UILabel()
    let coffeeImageView = UIImageView()
    let contentLabel = UILabel()
    let coffeeButton = UIButton()
    let noncoffeeButton = UIButton()
    let buttonContainerView = UIView()
    let backButton = UIButton()
    let nextButton = UIButton()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        self.navigationController?.navigationBar.isHidden = true
       
    }

}

// MARK: - Extensions

extension CafeTITest1ViewController {
    
    // MARK: - Layout Helper
    func layout() {
        layoutQuestionTitleLabel()
        layoutCoffeeImageView()
        layoutContentLabel()
        layoutCoffeeButton()
        layoutNonCoffeeButton()
        layoutButtonContainerView()
        layoutBackButton()
        layoutNextButton()
    }
    
    func layoutQuestionTitleLabel() {
        self.view.add(self.questiontitleLabel) {
            $0.setupLabel(text: "Question.01", color: .blue, font: UIFont.notoSansKRMediumFont(fontSize: 20))
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
                $0.centerX.equalToSuperview()
            }
        }
    }
    func layoutCoffeeImageView() {
        self.view.add(self.coffeeImageView) {
            $0.image = UIImage(named: "Component3")
            $0.snp.makeConstraints {
                $0.top.equalTo(self.questiontitleLabel.snp.bottom).offset(58)
                $0.leading.equalTo(self.view.snp.leading).offset(138)
                $0.width.equalTo(117)
                $0.height.equalTo(119)
            }
        }
    }
    func layoutContentLabel() {
        self.view.add(self.contentLabel) {
            $0.setupLabel(text: "주로 마시는 음료는 무엇인가요?", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
            $0.snp.makeConstraints {
                $0.top.equalTo(self.coffeeImageView.snp.bottom).offset(59)
                $0.centerX.equalToSuperview()
            }
        }
    }
    func layoutCoffeeButton() {
        self.view.add(self.coffeeButton) {
            $0.setTitle("커피", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .lightGray
            $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
           ///버튼 클릭시 보더 색상 변경 넣어야함 + 클릭해도 상태 유지되게
            $0.setRounded(radius: 5)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.contentLabel.snp.bottom).offset(113)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(335)
                $0.height.equalTo(50)
            }
        }
    }
    func layoutNonCoffeeButton() {
        self.view.add(self.noncoffeeButton) {
            $0.setTitle("논커피", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .lightGray
            $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
           
            ///버튼 클릭시 보더 색상 변경 넣어야함
            $0.setRounded(radius: 5)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.coffeeButton.snp.bottom).offset(10)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(335)
                $0.height.equalTo(50)
            }
        }
    }
    func layoutButtonContainerView() {
      self.view.add(self.buttonContainerView) {
        $0.backgroundColor = .clear
        $0.snp.makeConstraints {
          $0.centerX.equalToSuperview()
          $0.top.equalTo(self.noncoffeeButton.snp.bottom).offset(161)
          $0.width.equalTo(318)
          $0.height.equalTo(49)
        }
      }
    }
    func layoutBackButton() {
        self.view.add(self.backButton) {
            $0.setTitle("이전", for: .normal)
            $0.setTitleColor(.gray, for: .normal)
            $0.backgroundColor = .lightGray
            $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
            $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
            $0.setRounded(radius: 24.5)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.buttonContainerView.snp.top)
                $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
                $0.leading.equalTo(self.buttonContainerView.snp.leading)
                $0.width.equalTo(154)
            }
        }
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    func layoutNextButton() {
        self.view.add(self.nextButton) {
            $0.setTitle("다음", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .blue
            $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
            $0.addTarget(self, action: #selector(self.nextButtonClicked), for: .touchUpInside)
            $0.setRounded(radius: 24.5)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.buttonContainerView.snp.top)
                $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
                $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
                $0.width.equalTo(154)
            }
        }
    }

    /// 만약 커피버튼을 눌렀으면 21로 논커피 버튼을 눌렀으면 22로 보내게끔 수정
    
    @objc func nextButtonClicked() {
        let CafeTITest21ViewController = CafeTITest21ViewController()
        self.navigationController?.pushViewController(CafeTITest21ViewController, animated: false)
    }
 
}
