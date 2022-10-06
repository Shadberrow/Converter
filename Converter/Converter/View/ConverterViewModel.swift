//
//  ConverterViewModel.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class ConverterViewModel {
  
  private var account: Account!
  
  var didLoadAccount: ((Account) -> Void)?
  var sellCurrency: ((Currency) -> Void)?
  var buyCurrency: ((Currency) -> Void)?
  var buyAmount: ((Double) -> Void)?
  
  private var sellBalance: Balance!
  private var buyBalance: Balance!
  
  let service: ConverterServiceType
  
  init(servie: ConverterServiceType) {
    self.service = servie
  }
  
  func loadData() {
    account = service.loadAccount()
    
    didLoadAccount?(account)
    
    guard
      let sellBalance = account.balances.first(where: { $0.currency == account.defauleSellCurrency }),
      let buyBalance = account.balances.first(where: { $0.currency == account.defauleBuyCurrency })
    else { return }
    
    setSellBalance(sellBalance)
    setBuyBalance(buyBalance)
    
    sellCurrency?(sellBalance.currency)
    buyCurrency?(buyBalance.currency)
  }
  
  func setSellBalance(_ balance: Balance) {
    sellBalance = balance
  }
  
  func setBuyBalance(_ balance: Balance) {
    buyBalance = balance
  }
  
  func sellInputChanged(input: String?) {
    guard let input = input else { return }
    let amount = (input as NSString).doubleValue
    
    let exchanged = service.exchange(
      amount: amount,
      fromCurrency: sellBalance.currency.code,
      toCurrency: buyBalance.currency.code
    )
    
    buyAmount?(exchanged)
  }
  
  func saveExchange() {
    
  }
}
