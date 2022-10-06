//
//  Currency.swift
//  Converter
//
//  Created by Yevhenii on 10/6/22.
//

import Foundation

struct Currency: Equatable {
  let code: String
  let name: String
  
  init(code: String, name: String) {
    self.code = code
    self.name = name
  }
  
  init(code: String) {
    self.code = code
    self.name = Locale.current.localizedString(forCurrencyCode: code) ?? "NA"
  }
}

extension Currency {
  static let USD = Currency(code: "USD")
  static let EUR = Currency(code: "EUR")
  static let JPY = Currency(code: "JPY")
}
