//
//  ExchangeFeeCalculator.swift
//  Converter
//
//  Created by Yevhenii on 10/6/22.
//

import Foundation

final class ExchangeFeeCalculator {
  
  private var rules = [FeeRule]()
  
  let exchangeAmount: Double
  let conversionsCount: UInt
  
  init(exchangeAmount: Double, conversionsCount: UInt) {
    self.exchangeAmount = exchangeAmount
    self.conversionsCount = conversionsCount
  }
  
  func addRule(_ rule: FeeRule...) -> ExchangeFeeCalculator {
    rules.append(contentsOf: rule)
    return self
  }
  
  func getFee() -> Double {
    let results = rules.map { rule in
      rule.result(for: exchangeAmount, userExchangesCount: conversionsCount)
    }
    
    guard !results.contains(.free) else { return .zero }
    
    return results.reduce(.zero, { $0 + $1.value })
  }
}

enum FeeRule {
  case standardFee(percent: Double)
  case firstNFree(count: UInt)
  case everyNFree(number: UInt)
  case lessThanNFree(amount: Double)
}

extension FeeRule {
  func result(for exchangeAmount: Double, userExchangesCount: UInt) -> FeeRuleResult {
    switch self {
    case .standardFee(percent: let percent):
      return .some((exchangeAmount * percent) / 100)
      
    case .firstNFree(count: let count):
      return userExchangesCount < count ? .free : .some(0)
        
    case .everyNFree(number: let number):
      return userExchangesCount % number == 0 ? .free : .some(0)
      
    case .lessThanNFree(amount: let amount):
      return exchangeAmount < amount ? .free : .some(0)
    }
  }
}

enum FeeRuleResult: Equatable {
  case free
  case some(Double)
}

extension FeeRuleResult {
  var value: Double {
    switch self {
    case .free:
      return .zero
      
    case let .some(value):
      return value
    }
  }
}
