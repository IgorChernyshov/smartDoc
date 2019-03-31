//
//  LightBlueChartLimitLine.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 31/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation
import Charts

/// This is a light blue rgba(0, 0, 1, 0.2) chart limit line
class LightBlueChartLimitLine: ChartLimitLine {
  
  override init(limit: Double, label: String)
  {
    // Standard initializer
    super.init()
    self.limit = limit
    self.label = label
    // View customization
    self.lineWidth = 1
    self.lineDashLengths = [5,5]
    self.lineColor = NSUIColor.init(red: 0, green: 0, blue: 1, alpha: 0.2)
  }
  
}
