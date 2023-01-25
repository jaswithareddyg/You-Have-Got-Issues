//
//  ViewController.swift
//  You've Got Issues!
//
//  Created by Jaswitha Reddy Guntaka on 1/24/23.
//

import UIKit


class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBar.items?[0].title = "Open Issues"
    tabBar.items?[0].image = UIImage(systemName: "envelope.open.fill")
    tabBar.items?[1].title = "Closed Issues"
    tabBar.items?[1].image = UIImage(systemName: "envelope.fill")
  }
}
