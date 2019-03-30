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
  
  private var values: [Double] = [0.0]
  private var lineChartData: [ChartDataEntry] = []
  
  // MARK: - Methods
  
  func configureCell(withData data: [Double], andName name: String) {
    self.values = data
    self.chartView.isHidden = true
    self.chartNameLabel.text = name
    configureChart()
  }
  
  func configureChart() {
    guard var minimumValue = values.first, var maximumValue = values.first else { return }
    // Populate data source
    for index in 0..<values.count {
      let chartPoint = ChartDataEntry(x: Double(index), y: values[index])
      lineChartData.append(chartPoint)
      if values[index] < minimumValue { minimumValue = values[index] }
      if values[index] > maximumValue { maximumValue = values[index] }
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
    yAxisLeft.axisMinimum = minimumValue - minimumValue * 0.3
    yAxisLeft.axisMaximum = maximumValue + maximumValue * 0.3
    
    // Disable unused elements
    yAxisLeft.gridLineWidth = 0.0
    chartView.xAxis.drawLabelsEnabled = false
    chartView.rightAxis.enabled = false
    chartView.legend.enabled = false
    chartView.chartDescription?.enabled = false
    chartView.dragEnabled = false
    chartView.pinchZoomEnabled = false
    chartView.setScaleEnabled(false)

    // Display chart
    self.chartView.isHidden = false
    chartView.data = data
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    chartView.clear()
  }
  
}
