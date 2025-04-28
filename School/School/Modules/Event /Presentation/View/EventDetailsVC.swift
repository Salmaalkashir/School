//
//  EventDetailsVC.swift
//  School
//
//  Created by Mahmoud on 11/04/2025.
//

import UIKit

class EventDetailsVC: UIViewController {

    @IBOutlet weak var picker: DatePickerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStartDateField()
        // Do any additional setup after loading the view.
    }

    private func configureStartDateField() {
        picker.placeholderText = "Start Date"
        picker.setMinimumDate(Date())
        picker.selectedDate = Date()
        picker.borderColor = .systemBlue
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
