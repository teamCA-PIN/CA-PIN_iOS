//
//  CafeTITest1ViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/01.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - CafeTITest1ViewController

class CafeTITest1ViewController: UIViewController {
  
  // MARK: - Components
  
  let questiontitleLabel = UILabel()
  let coffeeImageView = UIImageView()
  let contentLabel = UILabel()
  let questionLabel = UILabel()
  let buttonContainerView = UIView()
  let backButton = UIButton()
  let nextButton = UIButton()
  
  
  private let questionTableView = UITableView()
  
  
  var questionList : [CAFETIQuestionDataModel] = []
  
  
  
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    register()
    setQuestionList()
    self.questionTableView.delegate = self
    self.questionTableView.dataSource = self
    questionTableView.separatorStyle = .none
    self.navigationController?.navigationBar.isHidden = true
    
  }
  func setQuestionList() {
    questionList.append(contentsOf : [
      CAFETIQuestionDataModel(questiontitle : "커피"),
      CAFETIQuestionDataModel(questiontitle : "논커피")
    ])
  }
  
  
}

// MARK: - Extensions

extension CafeTITest1ViewController {
  
  // MARK: - Helper
  
  func register() {
    self.questionTableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.reuseIdentifier)
  }
  func layout() {
    layoutQuestionTitleLabel()
    layoutCoffeeImageView()
    layoutContentLabel()
    layoutButtonContainerView()
    layoutQuestionTableView()
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
  func layoutQuestionTableView() {
    self.view.add(questionTableView) {
      $0.backgroundColor = .clear
      $0.estimatedRowHeight = 290
      $0.rowHeight = UITableView.automaticDimension
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.separatorStyle = .none
      $0.snp.makeConstraints {
//        $0.top.equalTo(self.contentLabel.snp.bottom).offset(113)
        $0.centerY.equalTo(self.contentLabel.snp.bottom).offset(168)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.bottom.equalTo(self.buttonContainerView.snp.top).offset(-68)
      }
    }
  }
  func layoutButtonContainerView() {
    self.view.add(self.buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-34)
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
      //            $0.addTarget(self, action: #selector(self.nextButtonClicked), for: .touchUpInside)
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
  
  //    @objc func nextButtonClicked() {
  //        let CafeTITest21ViewController = CafeTITest21ViewController()
  //        self.navigationController?.pushViewController(CafeTITest21ViewController, animated: false)
  //    }
  
}

// MARK: - UIViewDelegate

extension CafeTITest1ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
}


// MARK: - UITableViewDataSource

extension CafeTITest1ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let questionCell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.reuseIdentifier, for: indexPath) as? QuestionTableViewCell else {return UITableViewCell() }
    questionCell.setData(questiontitle : questionList[indexPath.row].questiontitle)
    questionCell.awakeFromNib()
    return questionCell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let questionCell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.reuseIdentifier, for: indexPath) as? QuestionTableViewCell else { return }
    questionCell.backview.addBorder(.all, color: 0x947d6c.color, thickness: 2)
    tableView.layoutSubviews()
  }
  
}
