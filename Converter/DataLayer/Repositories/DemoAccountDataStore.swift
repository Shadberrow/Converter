//
//  DemoAccountDataStore.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class DemoAccountDataStore: AccountDataStoreType {
  func loadAccount() -> Account {
    return Account(balances: [
      Balance(currency: .USD, amount: 1e3),
      Balance(currency: .EUR, amount: .zero),
      Balance(currency: .JPY, amount: .zero)
    ])
  }
}
