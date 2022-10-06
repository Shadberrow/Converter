//
//  ApiClientType.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

protocol ApiClientType {
  func exchange(amount: Double, fromCurrency: String, toCurrency: String) async throws -> ExchangeResult
}
