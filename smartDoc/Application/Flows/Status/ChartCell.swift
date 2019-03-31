//
//  ChartCell.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit
import Charts

/// Cell that displays chart for user's status
class ChartCell: UITableViewCell {
  
  // MARK: - Outlets

  @IBOutlet weak var chartNameLabel: UILabel!
  @IBOutlet weak var chartView: LineChartView!
  
  // MARK: - Variables
  
  private var name = ""
  private var values: [Double] = [0.0]
  
  // MARK: - Methods
  
  /// Configures cell with data and name that are passed in arguments.
  ///
  /// - Parameters:
  ///   - data: Array of points to draw line.
  ///   - name: Name of chart in russian.
  func configureCell(withData data: [Double], andName name: String) {
    self.values = data
    self.name = name
    self.chartView.isHidden = true
    self.chartNameLabel.text = name
    configureChart()
  }
  
  /// Configures chart
  func configureChart() {
    guard var minimumValue = values.first, var maximumValue = values.first else { return }
    
    // Configure chart
    
    // Create data sets for charts
    var lineChartData: [ChartDataEntry] = []
    var extremumsChartData: [ChartDataEntry] = []
    
    // Set limit lines
    var upperLimit = 0.0
    var lowerLimit = 0.0
    
    // Set limit lines depending on graph's chart
    switch self.name {
    case "Термометр":
      upperLimit = NormalValues.temperatureMax.rawValue
      lowerLimit = NormalValues.temperatureMin.rawValue
    case "Пульс":
      upperLimit = NormalValues.pulseMax.rawValue
      lowerLimit = NormalValues.pulseMin.rawValue
    case "Сахар":
      upperLimit = NormalValues.bloodSugarMax.rawValue
      lowerLimit = NormalValues.bloodSugarMin.rawValue
    case "Давление":
      upperLimit = NormalValues.pressureMax.rawValue
      lowerLimit = NormalValues.pressureMin.rawValue
    case "Вес":
      upperLimit = NormalValues.weightMax.rawValue
      lowerLimit = NormalValues.weightMin.rawValue
    default:
      break
    }
    
    let limitLine1 = ChartLimitLine(limit: upperLimit, label: "")
    limitLine1.lineWidth = 1
    limitLine1.lineDashLengths = [5, 5]
    limitLine1.lineColor = NSUIColor.blue
    
    let limitLine2 = ChartLimitLine(limit: lowerLimit, label: "")
    limitLine2.lineWidth = 1
    limitLine2.lineDashLengths = [5,5]
    limitLine2.lineColor = NSUIColor.blue
    
    // Populate data source
    for index in 0..<values.count {
      let chartPoint = ChartDataEntry(x: Double(index), y: values[index])
      lineChartData.append(chartPoint)
      if values[index] < minimumValue { minimumValue = values[index] }
      if values[index] > maximumValue { maximumValue = values[index] }
      if (values[index] > upperLimit) || (values[index] < lowerLimit) {
        extremumsChartData.append(chartPoint)
      }
    }
    
    // Set base line appearence
    let baseLine = LineChartDataSet(values: lineChartData, label: nil)
    baseLine.lineWidth = 1
    baseLine.circleRadius = 0.0
    baseLine.colors = [NSUIColor.red]
    baseLine.drawValuesEnabled = false
    
    // Set extremum line appearence
    let extremumLine = LineChartDataSet(values: extremumsChartData, label: nil)
    extremumLine.lineWidth = 0
    extremumLine.circleRadius = 1.0
    extremumLine.circleColors = [NSUIColor.red]
    extremumLine.circleHoleColor = NSUIColor.red
    
    // Set chart data source
    let data = LineChartData()
    data.addDataSet(baseLine)
    data.addDataSet(extremumLine)
    
    // Set left Y axis appearence
    let yAxisLeft = chartView.leftAxis
    yAxisLeft.addLimitLine(limitLine1)
    yAxisLeft.addLimitLine(limitLine2)
    yAxisLeft.drawLimitLinesBehindDataEnabled = true
    yAxisLeft.axisMinimum = minimumValue * 0.9
    yAxisLeft.axisMaximum = maximumValue * 1.1
    
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
  
  /// Nulifies values on charts to avoid line dublicates
  override func prepareForReuse() {
    super.prepareForReuse()
    self.values = [0.0]
    chartView.data = LineChartData()
    chartView.clear()
  }
  
}
