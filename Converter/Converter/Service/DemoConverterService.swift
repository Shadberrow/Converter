//
//  DemoConverterService.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class DemoConverterService: ConverterServiceType {
  
  let dataStore: AccountDataStoreType
  
  init(dataStore: AccountDataStoreType) {
    self.dataStore = dataStore
  }
  
  func loadAccount() -> Account {
    return dataStore.loadAccount()
  }
  
  func exchange(amount: Double, fromCurrency: String, toCurrency: String) -> Double {
    return 104
  }
}
