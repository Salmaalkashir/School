//
//  HomeViewController.swift
//  School
//
//  Created by Salma Alkashir on 23/02/2025.
//

import UIKit

class HomeViewController: UIViewController {
  //MARK: - IBOutlets
  @IBOutlet private weak var eventsCollectionView: UICollectionView!
  @IBOutlet private weak var announcementsCollectionView: UICollectionView!
  @IBOutlet private weak var categoriesCollectionView: UICollectionView!
  
  //MARK: - Properties
  var categoryImage = ["attendance","Quiz", "assignment", "classSchedule", "results", "schoolHoliday", "examSchedule"]
  var categoryTitles = ["Attendance", "Quiz", "Assignment", "Class Schedule", "Results", "School Holiday", "Exam Schedule"]

  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  //MARK: - Setup View
  private func setupView() {
    eventsCollectionView.dataSource = self
    eventsCollectionView.delegate = self
    
    announcementsCollectionView.dataSource = self
    announcementsCollectionView.delegate = self
    
    categoriesCollectionView.dataSource = self
    categoriesCollectionView.delegate = self
    
    eventsCollectionView.registerNib(cellType: EventsCollectionViewCell.self, identifier: "events")
    announcementsCollectionView.registerNib(cellType: AnnouncementsCollectionViewCell.self, identifier: "announcement")
    categoriesCollectionView.registerNib(cellType: CategoriesCollectionViewCell.self,  identifier: "categories")
  }
}

//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case eventsCollectionView: return 5
    case announcementsCollectionView: return 6
    case categoriesCollectionView: return 7
    default: return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case eventsCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "events", for: indexPath) as! EventsCollectionViewCell
      return cell
      
    case announcementsCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcement", for: indexPath) as! AnnouncementsCollectionViewCell
      return cell
      
    case categoriesCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategoriesCollectionViewCell
      cell.configureCell(image: categoryImage[indexPath.row], name: categoryTitles[indexPath.row])
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case eventsCollectionView: break
    case announcementsCollectionView:
      if let tabBarController = self.tabBarController as? CustomTabBar {
        tabBarController.selectedIndex = 1
      }
    case categoriesCollectionView: break
    default: break
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {
    case eventsCollectionView: return CGSize(width: 345, height: 140)
    case announcementsCollectionView: return CGSize(width: 200, height: 120)
    case categoriesCollectionView: 
      let numberOfCellsPerRow: CGFloat = 3
      let spacing: CGFloat = 10 
      let totalSpacing = spacing * (numberOfCellsPerRow - 1)
      let availableWidth = collectionView.frame.width - totalSpacing
      let cellWidth = availableWidth / numberOfCellsPerRow
      return CGSize(width: cellWidth, height: 100)
    default: return CGSize(width: 200, height: 120)
    }
  }
  
}
