//
//  AnnouncementViewController.swift
//  School
//
//  Created by Salma Alkashir on 07/03/2025.
//

import UIKit

class AnnouncementViewController: UIViewController {
  //MARK: - IBOutlets
  @IBOutlet private weak var announcementTableView: UITableView!
  
  var messages = ["تم فتح باب التقديمات بروضة مدرستنا للسنة الدراسية الجديدة ٢٠٢٥/٢٠٢٦", "📢 عودة الدراسة للفصل الدراسى الثانى 📢 إن شاء الله ستبدأ الدراسة من جديد يوم الأحد٩/٢ و نحب نطمنكم إن كل حاجة زى ماهى ، لا تغيير فى الأدوات ولا تغيير فى الجدول. بنطلب من كل الطلاب إنهم يحافظوا على مستواهم و يبذلوا أقصى جهدهم ."]
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    announcementTableView.delegate = self
    announcementTableView.dataSource = self
    announcementTableView.registerNib(cellType: AnnouncementTableViewCell.self, identifier: "announcement")
  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
  }
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AnnouncementViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return  messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "announcement") as! AnnouncementTableViewCell
    cell.message.text = messages[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 154
  }
  
}
