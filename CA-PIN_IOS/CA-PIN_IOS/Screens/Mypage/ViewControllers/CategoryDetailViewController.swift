//
//  CategoryDetailViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - CategoryDetailViewController
class CategoryDetailViewController: UIViewController {
    
    // MARK: - Components
    let navigationContainerView = UIView()
    let backButton = UIButton()
    let categoryNameLabel = UILabel()
    let deleteButton = UIButton()
    let pinNumberLabel = UILabel()
    let cafeListTableView = UITableView()
    
    // MARK: - Variables
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


// MARK: Extensions
extension CategoryDetailViewController {
    // MARK: - Helpers
    func register() {
        self.cafeListTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
    }
    func attribute() {
//        self.cafeListTableView.delegate = self
//        self.cafeListTableView.dataSource = self
    }
    
    //MARK: - Layout Helpers
    func layout() {
        layoutNavigationContainerView()
        layoutBackButton()
        layoutCategoryNameLabel()
        layoutDeleteButton()
        layoutPinNumberLabel()
        layoutCafeListTableView()
    }
    func layoutNavigationContainerView() {
        self.view.add(self.navigationContainerView) {
            $0.snp.makeConstraints {
                $0.width.equalTo(self.screenWidth)
                $0.height.equalTo(29)
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                $0.centerX.equalToSuperview()
            }
        }
    }
    func layoutBackButton() {
        self.navigationContainerView.add(self.backButton) {
            $0.setImage(UIImage(named: "logo"), for: .normal)
            $0.snp.makeConstraints {
                $0.width.equalTo(28)
                $0.height.equalTo(28)
                $0.top.equalTo(self.navigationContainerView.snp.top).offset(-1)
                $0.leading.equalTo(self.view.snp.leading).offset(20)
            }
        }
    }
    func layoutCategoryNameLabel() {
        self.navigationContainerView.add(self.categoryNameLabel) {
            $0.setupLabel(text: "기본 카테고리", color: .black, font: UIFont.systemFont(ofSize: 20), align: .center)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.navigationContainerView.snp.top)
                $0.width.equalTo(160)
                $0.height.equalTo(29)
                $0.centerX.equalTo(self.navigationContainerView.center)
            }
        }
    }
    func layoutDeleteButton() {
        self.navigationContainerView.add(self.deleteButton) {
            $0.setImage(UIImage(named: "logo"), for: .normal)
            $0.snp.makeConstraints {
                $0.width.equalTo(28)
                $0.height.equalTo(28)
                $0.top.equalTo(self.navigationContainerView.snp.top).offset(-1)
                $0.trailing.equalTo(self.navigationContainerView.snp.trailing).offset(-20)
            }
        }
    }
    func layoutPinNumberLabel() {
        self.view.add(self.pinNumberLabel) {
            $0.setupLabel(text: "총 8개의 핀", color: .gray, font: UIFont.systemFont(ofSize: 14))
            $0.snp.makeConstraints {
                $0.height.equalTo(16)
                $0.width.equalTo(80)
                $0.top.equalTo(self.navigationContainerView.snp.bottom).offset(-27)
                $0.leading.equalTo(self.view.snp.leading).offset(22)
            }
        }
    }
    func layoutCafeListTableView() {
        self.view.add(self.cafeListTableView) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.pinNumberLabel.snp.bottom).offset(8)
                $0.leading.equalTo(self.view.snp.leading)
                $0.trailing.equalTo(self.view.snp.trailing)
                $0.bottom.equalTo(self.view.snp.bottom)
            }
        }
    }
}

extension CategoryDetailViewController: UITableViewDelegate {
}

//extension CategoryDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cafeListCell = tableView.dequeueReusableCell(withIdentifier: cafeListTableViewCell.reuseIdentifier, for: indexPath)
//    }
//}
