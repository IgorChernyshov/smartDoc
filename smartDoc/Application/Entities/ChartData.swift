//
//  ChartData.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

class ChartData: Codable {
  
  let name: String
  let values: [Double]
  
  init(name: String, values: [Double]) {
    self.name = name
    self.values = values
  }
}
