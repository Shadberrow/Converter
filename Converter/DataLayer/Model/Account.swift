//
//  Account.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class Account {
  var balances: [Balance]
  
  var defauleSellCurrency: Currency = .USD
  var defauleBuyCurrency: Currency = .EUR
  
  init(balances: [Balance] = []) {
    self.balances = balances
  }
}
