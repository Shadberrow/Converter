//
//  Account.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class Account {
  var balances: [Balance]
  
  init(balances: [Balance] = []) {
    self.balances = balances
  }
}

class Balance {
  var currency: String
  var amount: Double
  
  init(currency: String, amount: Double) {
    self.currency = currency
    self.amount = amount
  }
}
