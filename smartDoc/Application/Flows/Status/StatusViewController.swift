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
  
  var dbReference: DatabaseReference!
  var charts = [String:[Double]]()
  
  // MARK: - ViewController's lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    dbReference = Database.database().reference()
    
    dbReference.child("user").observeSingleEvent(of: .value) { [weak self] (snapshot) in
      guard let charts = snapshot.value as? NSDictionary else { return }
  
      for chart in charts {
        self?.charts[chart.key as! String] = chart.value as? [Double]
      }
      self?.tableView.reloadData()
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
    // SHIT CODE: Configure chart depending on cell's number
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
