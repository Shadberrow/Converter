//
//  DemoConverterService.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class DemoConverterService: ConverterServiceType {
  
  private let apiClient: ApiClientType
  private let dataStore: AccountDataStoreType
  
  init(apiClient: ApiClientType, dataStore: AccountDataStoreType) {
    self.apiClient = apiClient
    self.dataStore = dataStore
  }
  
  func loadAccount() -> Account {
    return dataStore.loadAccount()
  }
  
  func exchange(amount: Double, fromCurrency: String, toCurrency: String) async -> Double {
    let amount = try? await apiClient.exchange(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency).amount
    return ((amount ?? "") as NSString).doubleValue
  }
}
