//
//  EventVC.swift
//  School
//
//  Created by Mahmoud on 11/04/2025.
//

import UIKit

class EventVC: UIViewController {
    @IBOutlet weak var eventLabel: UILabel!
    
    @IBOutlet weak var searchTextfiled: UITextField!
    @IBOutlet weak var eventCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        eventCollection.dataSource = self
        eventCollection.delegate = self
        eventCollection.registerNib(cellType: EventsCollectionViewCell.self, identifier: "events")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EventVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "events", for: indexPath) as! EventsCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return CGSize(width: 345, height: 140)}
    
}
