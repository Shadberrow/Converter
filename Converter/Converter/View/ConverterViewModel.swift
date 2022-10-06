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
  var isSaveEnabled: ((Bool) -> Void)?
  var showAlert: ((ConversionResult) -> Void)?
  var resultDidChange: ((ConversionResult) -> Void)?
  
  private var sellBalance: Balance!
  private var buyBalance: Balance!
  private var sellExchanged: Double = 0
  private var buyExchanged: Double = 0
  private var exchangeFee: Double = 0
  private var conversionResult: ConversionResult?
  
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
    loadExchage()
  }
  
  func setBuyBalance(_ balance: Balance) {
    buyBalance = balance
    loadExchage()
  }
  
  func sellInputChanged(input: String?) {
    guard let input = input else { return }
    let amount = (input as NSString).doubleValue
    sellExchanged = (amount * 100).rounded(.toNearestOrEven) / 100
    loadExchage()
  }
  
  func saveExchange() {
    sellBalance.amount -= sellExchanged + exchangeFee
    buyBalance.amount += buyExchanged
    
    didLoadAccount?(account)
    checkSaveEnabledState()
    service.incrementConversionsCount()
    
    updateConversionResult()
    
    guard let conversionResult = conversionResult else { return }
    showAlert?(conversionResult)
    postLoadUpdate()
  }
  
  private func loadExchage() {
    Task {
      let exchanged = await service.exchange(
        amount: sellExchanged,
        fromCurrency: sellBalance.currency.code,
        toCurrency: buyBalance.currency.code)
      
      buyExchanged = exchanged
      
      DispatchQueue.main.async {
        self.buyAmount?(exchanged)
        self.postLoadUpdate()
      }
    }
  }
  
  private func postLoadUpdate() {
    exchangeFee = service.getFee(exchangeAmount: sellExchanged)
    
    checkSaveEnabledState()
    updateConversionResult()
    
    guard let conversionResult = conversionResult else { return }
    resultDidChange?(conversionResult)
  }
  
  private func checkSaveEnabledState() {
    isSaveEnabled?(sellBalance.amount >= (sellExchanged + exchangeFee) && sellBalance.amount != 0)
  }
  
  private func updateConversionResult() {
    conversionResult = ConversionResult(
      sellAmount: sellExchanged, buyAmount: buyExchanged,
      fromCurrency: sellBalance.currency, toCurrency: buyBalance.currency,
      exchangeFee: exchangeFee)
  }
}

struct ConversionResult {
  var sellAmount: Double
  var buyAmount: Double
  var fromCurrency: Currency
  var toCurrency: Currency
  var exchangeFee: Double
}
