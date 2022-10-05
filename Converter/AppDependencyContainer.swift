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
  
  init() {
    func makeApiClient() -> ApiClientType {
      return DemoApiClient()
    }
    
    func makeAccountDataStore() -> AccountDataStoreType {
      return DemoAccountDataStore()
    }
    
    self.sharedApiClient = makeApiClient()
    self.sharedAccountDataStore = makeAccountDataStore()
  }
  
  func makeRootViewController() -> UIViewController {
    let viewController = makeConverterViewController()
    return UINavigationController(rootViewController: viewController)
  }
  
  func makeConverterViewController() -> UIViewController {
    return ViewController()
  }
  
}
