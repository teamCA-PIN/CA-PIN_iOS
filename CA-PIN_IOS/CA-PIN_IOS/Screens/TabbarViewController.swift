//
//  TabbarViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

class TabbarViewController: UITabBarController {
  
  var defaultIndex = 0 {
    didSet {
      self.selectedIndex = defaultIndex
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.selectedIndex = defaultIndex
  }
}

extension TabbarViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  
    let firstNavigationController = UINavigationController()
    let firstTabController = MapViewController()
    firstNavigationController.addChild(firstTabController)
    
    let secondNavigationController = UINavigationController()
    let secondTabController = CafeTIViewController()
    secondNavigationController.addChild(secondTabController)
    
    let thirdNavigationController = UINavigationController()
    let thirdTabController = EditCategoryViewController()
    thirdNavigationController.addChild(thirdTabController)
    
    
    let viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController]
    self.setViewControllers(viewControllers, animated: true)
    
    let tabBar: UITabBar = self.tabBar
    tabBar.backgroundColor = UIColor.clear
    tabBar.barTintColor = UIColor.white
    tabBar.isHidden = false
    
    let titles = ["한솔", "지수", "서현"]

    for (index, value) in (tabBar.items?.enumerated())! {
      let tabBarItem: UITabBarItem = value as UITabBarItem
      tabBarItem.title = titles[index]
      tabBarItem.imageInsets.left = 4
    }
    self.hidesBottomBarWhenPushed = false
  }
}
