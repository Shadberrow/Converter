//
//  ConverterViewController.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import UIKit

class ConverterViewController: UIViewController {
  
  // MARK: - Properties
  var viewModel: ConverterViewModel! {
    didSet { bind() }
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - Setup
  private func setupView() {
    view.backgroundColor = .systemBackground
    
    setupSubviews()
    setupHierarchy()
    setupConstraints()
  }
  
  private func setupSubviews() {
    
  }
  
  private func setupHierarchy() {
    
  }
  
  private func setupConstraints() {
    
  }
  
  // MARK: - ViewModel Bind
  private func bind() {
    
  }
}
