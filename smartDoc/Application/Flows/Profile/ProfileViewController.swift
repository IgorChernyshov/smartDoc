//
//  ProfileViewController.swift
//  smartDoc
//
//  Created by MacBook-Игорь on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

/// View Controller that shows user's profile
class ProfileViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - View Controller's life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}

// MARK: - Table View Delegates

extension ProfileViewController: UITableViewDelegate { }

extension ProfileViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
    return cell
  }
}
