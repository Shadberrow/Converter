//
//  ConverterServiceType.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

protocol ConverterServiceType {
  func loadAccount() -> Account
  func exchange(amount: Double, fromCurrency: String, toCurrency: String) async -> Double
}
