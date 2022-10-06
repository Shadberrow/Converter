//
//  AppDependencyContainer.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import UIKit

final class AppDependencyContainer {
  
  let sharedApiClient: ApiClientType
  let sharedAccountDataStore: AccountDataStoreType
  let sharedExchangeFeeCalculator: ExchangeFeeCalculator
  
  init() {
    func makeApiClient() -> ApiClientType {
      return DemoApiClient()
    }
    
    func makeAccountDataStore() -> AccountDataStoreType {
      return DemoAccountDataStore()
    }
    
    func makeExchangeFeeCalculator() -> ExchangeFeeCalculator {
      let calculator = ExchangeFeeCalculator()
        .addRules(.standardFee(percent: 0.7), .firstNFree(count: 5))
      return calculator
    }
    
    self.sharedApiClient = makeApiClient()
    self.sharedAccountDataStore = makeAccountDataStore()
    self.sharedExchangeFeeCalculator = makeExchangeFeeCalculator()
  }
  
  func makeRootViewController() -> UIViewController {
    let viewController = makeConverterViewController()
    return UINavigationController(rootViewController: viewController)
  }
  
  func makeConverterViewController() -> UIViewController {
    let viewModel = makeConverterViewModel()
    let viewController = ConverterViewController()
    viewController.viewModel = viewModel
    return viewController
  }
  
  func makeConverterViewModel() -> ConverterViewModel {
    let service = makeConverterService()
    return ConverterViewModel(servie: service)
  }
  
  func makeConverterService() -> ConverterServiceType {
    return DemoConverterService(
      apiClient: sharedApiClient,
      dataStore: sharedAccountDataStore,
      feeCalculator: sharedExchangeFeeCalculator)
  }
}
