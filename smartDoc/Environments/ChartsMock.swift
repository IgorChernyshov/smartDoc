//
//  ChartsMock.swift
//  smartDoc
//
//  Created by Igor Chernyshov on 30/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import Foundation

class ChartsMock {
  static let temperatureMock = ChartData(name: "Температура", values: [36.6, 36.6, 36.6, 36.7, 36.6, 36.6, 36.6, 36.6])
  static let pulseMock = ChartData(name: "Пульс", values: [60.0, 63.0, 61.0, 80.0, 61.0, 62.0, 61.0, 60.0])
  static let sugarMock = ChartData(name: "Сахар", values: [4.2, 4.1, 4.3, 4.0, 4.5, 4.3, 4.1, 4.0])
  static let weightMock = ChartData(name: "Вес", values: [78.8, 78.8, 78.8, 78.8, 78.9, 78.9, 78.9, 78.8])
}
