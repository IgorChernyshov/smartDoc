//
//  StatusViewController.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit
import Firebase

class StatusViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Variables
  var dbReference: DatabaseReference!
  var data: [Double] = []
  
  // MARK: - ViewController's lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    dbReference = Database.database().reference()
    
    dbReference.child("user").child("1553959702").child("heart").observeSingleEvent(of: .value) { [weak self] (snapshot) in
      guard let value = snapshot.value as? [Double] else { return }
      self?.data = value
      self?.tableView.reloadData()
    }
  }

}

// MARK: - TableView delegates

extension StatusViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell") as? ChartCell else { return ChartCell() }
    let chartData = self.data
    cell.configureCell(with: chartData)
    return cell
  }

}
