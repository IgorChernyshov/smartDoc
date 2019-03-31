//
//  StatusViewController.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit
import Firebase

/// View Controller that shows user's status
class StatusViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Variables
  
  private lazy var dbReference: DatabaseReference! = {
    Database.database().reference()
  }()
  var charts = [String:[Double]]()
  
  // MARK: - ViewController's lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    
    requestDataFromServer()
    
  }
  
  /// Requests data from Firebase database
  func requestDataFromServer() {
    dbReference.child("user").observe(.value) { [weak self] (snapshot) in
        
//    }
    
//    dbReference.child("user").observeSingleEvent(of: .value) { [weak self] (snapshot) in
        guard let charts = snapshot.value as? /*NSDictionary*/ [String:[Double]] else { return }
      
        self?.charts = charts
        var result = 1.0
//        if charts["blood"]?.last < 3.3 && charts["blood"]?.last > 5.5 {
//            result -= 0.2
//        }
        guard let bloodLast = charts["blood"]?.last, let termometerLast = charts["termometer"]?.last, let weightLast = charts["weight"]?.last, let heartLast = charts["heart"]?.last, let pressureLast = charts["pressure"]?.last else {return}
        if bloodLast < 3.3 || bloodLast > 5.5 { result -= 0.2 }
        if termometerLast < 35.5 || termometerLast > 37.4 { result -= 0.2 }
        if weightLast < 63 || weightLast > 75 { result -= 0.2 }
        if heartLast < 65 || heartLast > 80 { result -= 0.2 }
        if pressureLast < 90 || pressureLast > 140 { result -= 0.2 }
        self?.tableView.reloadData()
        
       var message = ""
        if result >= 0.8 {
            message = "Показатели выше нормы\nРекомендации:\nПродолжайте контролировать свое здоровье\nСледите за динамикой"
        } else if result >= 0.5 {
            message = "Показатели в норме\nРекомендации:\nОбратите внимание на отклонения\n- tº\n- ЭКГ\nОбратитесь к врачу"
        } else if result < 0.5 {
            message = "Показатели ниже нормы\nРекомендации:\nОбратите внимание на\n- tº\n- ЭКГ\n- Сахар\nОбратитесь к врачу"
        }
        
        let alert = UIAlertController(title: "Ваш результат", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let badAction = UIAlertAction(title: "Связь с врачем", style: .default, handler: nil)
        if result >= 0.8 {
            alert.addAction(action)
        } else {
            alert.addAction(action)
            alert.addAction(badAction)
        }
        self?.present(alert, animated: true, completion: nil)
    }
  }

}

// MARK: - TableView delegates

extension StatusViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell") as? ChartCell else { return ChartCell() }
    // Configure chart depending on cell's number
    switch indexPath.row {
    case 0:
      cell.configureCell(withData: self.charts["termometer"] ?? [], andName: "Термометр")
    case 1:
      cell.configureCell(withData: self.charts["heart"] ?? [], andName: "Пульс")
    case 2:
      cell.configureCell(withData: self.charts["blood"] ?? [], andName: "Сахар")
    case 3:
      cell.configureCell(withData: self.charts["pressure"] ?? [], andName: "Давление")
    case 4:
      cell.configureCell(withData: self.charts["weight"] ?? [], andName: "Вес")
    default:
      break
    }
    return cell
  }

}
