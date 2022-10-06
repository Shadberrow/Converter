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
  private let feeCalculator: ExchangeFeeCalculator
  
  private var conversionsCount: UInt = 0
  
  init(apiClient: ApiClientType, dataStore: AccountDataStoreType, feeCalculator: ExchangeFeeCalculator) {
    self.apiClient = apiClient
    self.dataStore = dataStore
    self.feeCalculator = feeCalculator
  }
  
  func loadAccount() -> Account {
    return dataStore.loadAccount()
  }
  
  func exchange(amount: Double, fromCurrency: String, toCurrency: String) async -> Double {
    let amount = try? await apiClient.exchange(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency).amount
    return ((amount ?? "") as NSString).doubleValue
  }
  
  func getFee(exchangeAmount: Double) -> Double {
    return feeCalculator
      .setExchangeAmount(amount: exchangeAmount)
      .setConversionsCount(count: conversionsCount)
      .getFee()
  }
  
  func incrementConversionsCount() {
    conversionsCount += 1
  }
}
