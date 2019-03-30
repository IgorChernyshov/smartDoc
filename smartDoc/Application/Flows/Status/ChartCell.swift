//
//  ChartCell.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit
import Charts

class ChartCell: UITableViewCell {
  
  // MARK: - Outlets

  @IBOutlet weak var chartNameLabel: UILabel!
  @IBOutlet weak var chartView: LineChartView!
  
  // MARK: - Variables
  
  private var name = ""
  private var values: [Double] = [0.0]
  private var lineChartData: [ChartDataEntry] = []
  
  // MARK: - Methods
  
  func configureCell(with data: [Double]) {
    self.name = "ЭКГ"
    self.values = data
    
    self.chartNameLabel.text = name
    configureChart()
  }
  
  func configureChart() {
    // Populate data source
    for index in 0..<values.count {
      let chartPoint = ChartDataEntry(x: Double(index), y: values[index])
      lineChartData.append(chartPoint)
    }
    
    // Configure chart
    
    // Set line appearence
    let line = LineChartDataSet(values: lineChartData, label: nil)
    line.circleRadius = 0.0
    line.colors = [NSUIColor.red]
    
    // Set chart data source
    let data = LineChartData()
    data.addDataSet(line)
    
    // Set left Y axis appearence
    let yAxisLeft = chartView.leftAxis
    yAxisLeft.axisMinimum = 0
    yAxisLeft.axisMaximum = 1.5
    
    // Disable unused elements
    yAxisLeft.gridLineWidth = 0.0
    chartView.rightAxis.enabled = false
    chartView.legend.enabled = false
    chartView.chartDescription?.enabled = false
    chartView.dragEnabled = false
    chartView.pinchZoomEnabled = false
    chartView.setScaleEnabled(false)

    // Display chart
    chartView.data = data
  }
  
}
