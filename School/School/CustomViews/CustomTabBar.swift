//
//  CustomTabBar.swift
//  School
//
//  Created by Salma Alkashir on 23/02/2025.
//

import UIKit

class CustomTabBar: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSomeTabItems()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
    addSomeTabItems()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if let tabBar = self.tabBarController?.tabBar {
      var tabFrame = tabBar.frame
      tabFrame.size.height = 80
      tabFrame.origin.y = view.frame.height - tabFrame.size.height
      tabBar.frame = tabFrame
    }
  }
  
  
  override func loadView() {
    super.loadView()
    setupCustomTabBar()
    UITabBar.appearance().tintColor = UIColor(named: "Primary")
  }
  
  //MARK: - CustomTabBar Setup
  func setupCustomTabBar() {
    let path: UIBezierPath = getPathForTabBar()
    let shape = CAShapeLayer()
    
    shape.path = path.cgPath
    shape.lineWidth = 3
    shape.fillColor = UIColor(named: "2nd Background")?.cgColor
    shape.masksToBounds = false
    
    self.tabBar.layer.insertSublayer(shape, at: 0)
    self.tabBar.itemWidth = 40
    self.tabBar.itemPositioning = .centered
    self.tabBar.itemSpacing = 100
  }
  
  //MARK: - TabBarItems
  func addSomeTabItems() {
    let v1 = UINavigationController(rootViewController: HomeViewController())
    let v2 = UINavigationController(rootViewController: AnnouncementViewController())
    let v3 = UINavigationController(rootViewController: HomeViewController())
    let v4 = UINavigationController(rootViewController: HomeViewController())
    v1.title = "Home"
    v2.title = "Announcement"
    v3.title = "Chat"
    v4.title = "Profile"
    setViewControllers([v1, v2, v3, v4], animated: false)
    
    guard let items = tabBar.items else { return }
    items[0].image = UIImage(named: "HomeIcon")
    items[1].image = UIImage(named: "AnnouncementIcon")
    items[2].image = UIImage(named: "ChatIcon")
    items[3].image = UIImage(named: "ProfileIcon")
    
    let font = UIFont(name: "Poppins-Regular", size: 12)!
    let attributes = [NSAttributedString.Key.font: font]
    
    items.forEach { item in
      item.setTitleTextAttributes(attributes, for: .normal)
      item.setTitleTextAttributes(attributes, for: .selected)
    }
  }
  
  //MARK: - BezierPath
  func getPathForTabBar() -> UIBezierPath {
    let frameWidth = self.tabBar.bounds.width
    let frameHeight = self.tabBar.bounds.height + 100
    
    let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight))
    
    return path
  }
  
}
