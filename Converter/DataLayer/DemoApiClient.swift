//
//  DemoApiClient.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class DemoApiClient: ApiClientType {
  
  enum ApiError: Error {
    case badURL
  }
  
  private var session = URLSession.shared
  
  func exchange(amount: Double, fromCurrency: String, toCurrency: String) async throws -> ExchangeResult {
    guard let url = URL(string: "http://api.evp.lt/currency/commercial/exchange/\(amount)-\(fromCurrency)/\(toCurrency)/latest") else {
      throw ApiError.badURL
    }
    
    let (data, _) = try await session.data(from: url)
    let decoder = JSONDecoder()
    return try decoder.decode(ExchangeResult.self, from: data)
  }
}
