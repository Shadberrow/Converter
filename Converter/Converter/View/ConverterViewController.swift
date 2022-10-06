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
  private var sellCurrencyButton: UIButton!
  
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
    balancesStackView.translatesAutoresizingMaskIntoConstraints = false
    balancesStackView.axis = .horizontal
    balancesStackView.backgroundColor = .orange
    balancesStackView.distribution = .equalCentering
    
    sellCurrencyButton = UIButton(type: .system)
    sellCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
    sellCurrencyButton.backgroundColor = .systemPurple
    sellCurrencyButton.layer.cornerRadius = 8
    sellCurrencyButton.tintColor = .white
    sellCurrencyButton.setTitle(" - ", for: .normal)
    sellCurrencyButton.showsMenuAsPrimaryAction = true
  }
  
  private func setupHierarchy() {
    view.addSubview(balancesStackView)
    view.addSubview(sellCurrencyButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      balancesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      balancesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      balancesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      
      sellCurrencyButton.topAnchor.constraint(equalTo: balancesStackView.bottomAnchor, constant: 28),
      sellCurrencyButton.leadingAnchor.constraint(equalTo: balancesStackView.leadingAnchor),
      sellCurrencyButton.widthAnchor.constraint(equalTo: balancesStackView.widthAnchor, multiplier: 0.35),
      sellCurrencyButton.heightAnchor.constraint(equalToConstant: 45)
    ])
  }
  
  // MARK: - ViewModel Bind
  private func bind() {
    viewModel.didLoadAccount = { [weak self] account in
      self?.generateBalancesView(for: account)
      self?.generateMenuForSellCurrencyButton(for: account)
    }
    
    viewModel.sellCurrency = { [weak self] currency in
      self?.sellCurrencyButton.setTitle(currency.code, for: .normal)
    }
    
    viewModel.loadData()
  }
  
  private func generateBalancesView(for account: Account) {
    account.balances
      .prefix(3)
      .forEach { balancesStackView.addArrangedSubview(makeBalanceLabel(for: $0)) }
  }
  
  private func makeBalanceLabel(for balance: Balance) -> UIView {
    let view = UILabel()
    view.text = balance.currency.code + " - " + "\(balance.amount)"
    return view
  }
  
  private func generateMenuForSellCurrencyButton(for account: Account) {
    let title = "Select Currency"
    let children = account.balances.map { createMenuAction(for: $0) }
    
    sellCurrencyButton.menu = UIMenu(title: title, image: nil, identifier: nil, options: [], children: children)
  }
  
  private func createMenuAction(for balance: Balance) -> UIAction {
    return UIAction(title: balance.currency.code) { [weak self] _ in
      self?.didSelect(balance: balance)
    }
  }
  
  private func didSelect(balance: Balance) {
    viewModel.setSellBalance(balance)
    sellCurrencyButton.setTitle(balance.currency.code, for: .normal)
  }
}
