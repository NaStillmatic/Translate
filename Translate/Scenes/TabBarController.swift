//
//  ViewController.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/01.
//

import UIKit

final class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let translateViewController = TransLateViewController()
    translateViewController.tabBarItem = UITabBarItem(title: "번역",
                                                      image: UIImage(systemName: "mic"),
                                                      selectedImage: UIImage(systemName: "mic.fill"))
    
    let bookmarkViewController = UINavigationController(rootViewController: BookmakrListViewController())
    bookmarkViewController.tabBarItem = UITabBarItem(title: "즐겨찾기",
                                                    image: UIImage(systemName: "star"),
                                                    selectedImage: UIImage(systemName: "star.fill"))
    
    viewControllers = [translateViewController, bookmarkViewController]
    
    
  }
  
  
}

