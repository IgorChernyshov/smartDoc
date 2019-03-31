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
  ///   - data: Array of points to draw a line.
  ///   - name: Chart's name in russian.
  func configureCell(withData data: [Double], andName name: String) {
    self.values = data
    self.name = name
    self.chartView.isHidden = true
    self.chartNameLabel.text = name
    
    configureChart()
  }
  
  /// Configures chart
  func configureChart() {
    // WORKAROUND: - Creates initial extremum point, because Charts didn't want to draw chart for one value
    let initialExtremumValue = ChartDataEntry(x: 0, y: values.count > 0 ? values[0] : 0)
    
    // Create data sets for charts
    var lineChartData: [ChartDataEntry] = []
    var extremumsChartData: [ChartDataEntry] = [initialExtremumValue]
    
    // Set limit lines
    let upperLimit = getChartsUpperLimit()
    let lowerLimit = getChartsLowerLimit()
    
    let limitLine1 = LightBlueChartLimitLine(limit: upperLimit, label: "")
    let limitLine2 = LightBlueChartLimitLine(limit: lowerLimit, label: "")
    
    // Populate data source
    for index in 0..<values.count {
      let chartPoint = ChartDataEntry(x: Double(index), y: values[index])
      lineChartData.append(chartPoint)
      if (values[index] > upperLimit) || (values[index] < lowerLimit) {
        let extremumPoint = ChartDataEntry(x: Double(index), y: values[index])
        extremumsChartData.append(extremumPoint)
      }
    }
  
    // Set base line appearence
    let baseLine = LineChartDataSet(values: lineChartData, label: nil)
    baseLine.lineWidth = 1
    baseLine.colors = [NSUIColor.red]
    baseLine.drawValuesEnabled = false
    baseLine.drawCirclesEnabled = false
    
    // Set extremum line appearence
    let extremumLine = LineChartDataSet(values: extremumsChartData, label: nil)
    extremumLine.lineWidth = 0
    extremumLine.circleRadius = 1.0
    extremumLine.circleColors = [NSUIColor.red]
    extremumLine.circleHoleColor = NSUIColor.red
    
    // Set chart data source
    let data = LineChartData(dataSets: [baseLine, extremumLine])
    
    // Set left Y axis appearence
    let yAxisLeft = chartView.leftAxis
    yAxisLeft.addLimitLine(limitLine1)
    yAxisLeft.addLimitLine(limitLine2)
    yAxisLeft.drawLimitLinesBehindDataEnabled = true
    
    // Disable unused elements
    yAxisLeft.gridLineWidth = 0.0
    chartView.xAxis.drawLabelsEnabled = false
    chartView.rightAxis.enabled = false
    chartView.legend.enabled = false
    chartView.chartDescription?.enabled = false
    chartView.dragEnabled = false
    chartView.pinchZoomEnabled = false
    chartView.setScaleEnabled(false)
    chartView.autoScaleMinMaxEnabled = true

    // Display chart
    self.chartView.isHidden = false
    chartView.data = data
  }
  
  /// Retrieves value's upper limit depending on graph's name
  ///
  /// - Returns: Upper limit that counts as "Normal"
  func getChartsUpperLimit() -> Double {
    switch self.name {
    case "Термометр":
      return NormalValues.temperatureMax.rawValue
    case "Пульс":
      return NormalValues.pulseMax.rawValue
    case "Сахар":
      return NormalValues.bloodSugarMax.rawValue
    case "Давление":
      return NormalValues.pressureMax.rawValue
    case "Вес":
      return NormalValues.weightMax.rawValue
    default:
      return 0.0
    }
  }
  
  /// Retrieves value's lower limit depending on graph's name
  ///
  /// - Returns: Lower limit that counts as "Normal"
  func getChartsLowerLimit() -> Double {
    switch self.name {
    case "Термометр":
      return NormalValues.temperatureMin.rawValue
    case "Пульс":
      return NormalValues.pulseMin.rawValue
    case "Сахар":
      return NormalValues.bloodSugarMin.rawValue
    case "Давление":
      return NormalValues.pressureMin.rawValue
    case "Вес":
      return NormalValues.weightMin.rawValue
    default:
      return 0.0
    }
  }
  
  /// Nulifies values on charts to avoid line dublicates
  override func prepareForReuse() {
    super.prepareForReuse()
    self.values = []
    chartView.data = nil
    chartView.clear()
  }
  
}
