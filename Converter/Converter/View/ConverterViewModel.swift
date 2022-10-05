//
//  ConverterViewModel.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import Foundation

class ConverterViewModel {
  
  var account: Account?
  let service: ConverterServiceType
  
  init(servie: ConverterServiceType) {
    self.service = servie
    loadData()
  }
  
  private func loadData() {
    account = service.loadAccount()
  }
}