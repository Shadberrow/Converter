//
//  ConverterViewController.swift
//  Converter
//
//  Created by Yevhenii on 10/5/22.
//

import UIKit

class ConverterViewController: UIViewController {
  
  // MARK: - Properties
  var viewModel: ConverterViewModel!
  
  // MARK: - Subviews
  private var balancesStackView: UIStackView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    bind()
  }
  
  // MARK: - Setup
  private func setupView() {
    view.backgroundColor = .systemBackground
    
    setupSubviews()
    setupHierarchy()
    setupConstraints()
  }
  
  private func setupSubviews() {
    balancesStackView = UIStackView()
    balancesStackView.axis = .horizontal
    balancesStackView.translatesAutoresizingMaskIntoConstraints = false
    balancesStackView.backgroundColor = .orange
    balancesStackView.distribution = .equalCentering
  }
  
  private func setupHierarchy() {
    view.addSubview(balancesStackView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      balancesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      balancesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      balancesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
    ])
  }
  
  // MARK: - ViewModel Bind
  private func bind() {
    viewModel.account?.balances
      .prefix(3)
      .forEach { balance in
        balancesStackView.addArrangedSubview(makeBalanceLabel(for: balance))
      }
  }
  
  private func makeBalanceLabel(for balance: Balance) -> UIView {
    let view = UILabel()
    view.text = balance.currency.code + " - " + "\(balance.amount)"
    return view
  }
}
