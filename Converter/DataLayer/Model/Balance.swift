//
//  Balance.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class Balance {
  var currency: Currency
  var amount: Double
  var fee: Double = 0
  
  init(currency: Currency, amount: Double) {
    self.currency = currency
    self.amount = amount
  }
}
