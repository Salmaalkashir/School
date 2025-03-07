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
  
  var categoryImage = ["attendance","quiz", "assignment", "classSchedule", "results", "schoolHoliday", "examSchedule"]
  var categoryTitles = ["Attendance", "Quiz", "Assignment", "Class Schedule", "Results", "School Holiday", "Exam Schedule"]
  override func viewDidLoad() {
    super.viewDidLoad()
    
    eventsCollectionView.dataSource = self
    eventsCollectionView.delegate = self
    
    announcementsCollectionView.dataSource = self
    announcementsCollectionView.delegate = self
    
    categoriesCollectionView.dataSource = self
    categoriesCollectionView.delegate = self
      
      Helpers.registerNib(nibName: "EventsCollectionViewCell", cellName: "events", view: eventsCollectionView as UICollectionView)
    
//    let nib = UINib(nibName: , bundle: nil)
//    .register(nib, forCellWithReuseIdentifier: "events")
    
    let nib1 = UINib(nibName: "AnnouncementsCollectionViewCell", bundle: nil)
    announcementsCollectionView.register(nib1, forCellWithReuseIdentifier: "announcement")
    
    let nib2 = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
    categoriesCollectionView.register(nib2, forCellWithReuseIdentifier: "categories")
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {
    case eventsCollectionView: return CGSize(width: 345, height: 140)
    case announcementsCollectionView: return CGSize(width: 200, height: 120)
    case categoriesCollectionView: 
      let numberOfCellsPerRow: CGFloat = 3
             let spacing: CGFloat = 10 // المسافة بين الخلايا
             let totalSpacing = spacing * (numberOfCellsPerRow - 1) // إجمالي المسافات
             let availableWidth = collectionView.frame.width - totalSpacing
             let cellWidth = availableWidth / numberOfCellsPerRow
             
             return CGSize(width: cellWidth, height: 100) //
     // return CGSize(width: 120, height: 100)
    default: return CGSize(width: 200, height: 120)
    }
  }
  
}
