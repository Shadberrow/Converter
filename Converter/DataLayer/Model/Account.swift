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
