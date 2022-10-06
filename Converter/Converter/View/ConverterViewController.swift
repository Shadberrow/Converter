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
  private var sellCurrencyTextField: UITextField!
  
  private var buyCurrencyButton: UIButton!
  private var buyCurrencyTextField: UITextField!
  
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
    
    sellCurrencyTextField = UITextField()
    sellCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
    sellCurrencyTextField.placeholder = "0.00"
    sellCurrencyTextField.keyboardType = .numberPad
    sellCurrencyTextField.textAlignment = .center
    sellCurrencyTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
    
    buyCurrencyButton = UIButton(type: .system)
    buyCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
    buyCurrencyButton.backgroundColor = .systemPurple
    buyCurrencyButton.layer.cornerRadius = 8
    buyCurrencyButton.tintColor = .white
    buyCurrencyButton.setTitle(" - ", for: .normal)
    buyCurrencyButton.showsMenuAsPrimaryAction = true
    
    buyCurrencyTextField = UITextField()
    buyCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
    buyCurrencyTextField.placeholder = "0.00"
    buyCurrencyTextField.isUserInteractionEnabled = false
    buyCurrencyTextField.textAlignment = .center
  }
  
  private func setupHierarchy() {
    view.addSubview(balancesStackView)
    view.addSubview(sellCurrencyButton)
    view.addSubview(sellCurrencyTextField)
    view.addSubview(buyCurrencyButton)
    view.addSubview(buyCurrencyTextField)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      balancesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      balancesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      balancesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      
      sellCurrencyButton.topAnchor.constraint(equalTo: balancesStackView.bottomAnchor, constant: 28),
      sellCurrencyButton.leadingAnchor.constraint(equalTo: balancesStackView.leadingAnchor),
      sellCurrencyButton.widthAnchor.constraint(equalTo: balancesStackView.widthAnchor, multiplier: 0.35),
      sellCurrencyButton.heightAnchor.constraint(equalToConstant: 45),
      
      sellCurrencyTextField.topAnchor.constraint(equalTo: sellCurrencyButton.bottomAnchor, constant: 8),
      sellCurrencyTextField.leadingAnchor.constraint(equalTo: sellCurrencyButton.leadingAnchor),
      sellCurrencyTextField.trailingAnchor.constraint(equalTo: sellCurrencyButton.trailingAnchor),
      sellCurrencyTextField.heightAnchor.constraint(equalToConstant: 45),
      
      buyCurrencyButton.topAnchor.constraint(equalTo: balancesStackView.bottomAnchor, constant: 28),
      buyCurrencyButton.trailingAnchor.constraint(equalTo: balancesStackView.trailingAnchor),
      buyCurrencyButton.widthAnchor.constraint(equalTo: balancesStackView.widthAnchor, multiplier: 0.35),
      buyCurrencyButton.heightAnchor.constraint(equalToConstant: 45),
      
      buyCurrencyTextField.topAnchor.constraint(equalTo: buyCurrencyButton.bottomAnchor, constant: 8),
      buyCurrencyTextField.leadingAnchor.constraint(equalTo: buyCurrencyButton.leadingAnchor),
      buyCurrencyTextField.trailingAnchor.constraint(equalTo: buyCurrencyButton.trailingAnchor),
      buyCurrencyTextField.heightAnchor.constraint(equalToConstant: 45)
    ])
  }
  
  // MARK: - ViewModel Bind
  private func bind() {
    viewModel.didLoadAccount = { [weak self] account in
      self?.generateBalancesView(for: account)
      self?.generateMenuForCurrencyButton(for: account, type: .sell)
      self?.generateMenuForCurrencyButton(for: account, type: .buy)
    }
    
    viewModel.sellCurrency = { [weak self] currency in
      self?.sellCurrencyButton.setTitle(currency.code, for: .normal)
    }
    
    viewModel.buyCurrency = { [weak self] currency in
      self?.buyCurrencyButton.setTitle(currency.code, for: .normal)
    }
    
    viewModel.buyAmount = { [weak self] exchanged in
      self?.buyCurrencyTextField.text = "\(exchanged)"
    }
    
    viewModel.loadData()
  }
  
  private func generateBalancesView(for account: Account) {
    balancesStackView.subviews.forEach { view in
      view.removeFromSuperview()
    }
    
    account.balances
      .prefix(3)
      .forEach { balancesStackView.addArrangedSubview(makeBalanceLabel(for: $0)) }
  }
  
  private func makeBalanceLabel(for balance: Balance) -> UIView {
    let view = UILabel()
    view.text = balance.currency.code + " - " + "\(balance.amount)"
    return view
  }
  
  private func generateMenuForCurrencyButton(for account: Account, type: ExchangeType) {
    let title = "Select Currency"
    let children = account.balances.map { createMenuAction(for: $0, type: type) }
    let menu = UIMenu(title: title, image: nil, identifier: nil, options: [], children: children)
    
    switch type {
    case .sell:
      sellCurrencyButton.menu = menu
    case .buy:
      buyCurrencyButton.menu = menu
    }
  }
  
  private func createMenuAction(for balance: Balance, type: ExchangeType) -> UIAction {
    return UIAction(title: balance.currency.code) { [weak self] _ in
      self?.didSelect(balance: balance, type: type)
    }
  }
  
  private func didSelect(balance: Balance, type: ExchangeType) {
    viewModel.setSellBalance(balance)
    
    switch type {
    case .sell:
      sellCurrencyButton.setTitle(balance.currency.code, for: .normal)
    case .buy:
      buyCurrencyButton.setTitle(balance.currency.code, for: .normal)
    }
  }
  
  @objc private func handleTextInput(_ sender: UITextField) {
    viewModel.sellInputChanged(input: sender.text)
  }
}

enum ExchangeType {
  case sell
  case buy
}
