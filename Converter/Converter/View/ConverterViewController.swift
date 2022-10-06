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
  
  private var activityIndicatorView: UIActivityIndicatorView!
  
  private var saveButton: UIButton!
  private var descriptionLabel: UILabel!
  
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
    balancesStackView.distribution = .equalCentering
    
    sellCurrencyButton = UIButton(type: .system)
    sellCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
    sellCurrencyButton.backgroundColor = .systemBlue
    sellCurrencyButton.layer.cornerRadius = 8
    sellCurrencyButton.tintColor = .white
    sellCurrencyButton.setTitle(" - ", for: .normal)
    sellCurrencyButton.showsMenuAsPrimaryAction = true
    
    sellCurrencyTextField = UITextField()
    sellCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
    sellCurrencyTextField.placeholder = "0.00"
    sellCurrencyTextField.keyboardType = .decimalPad
    sellCurrencyTextField.textAlignment = .center
    sellCurrencyTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
    
    buyCurrencyButton = UIButton(type: .system)
    buyCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
    buyCurrencyButton.backgroundColor = .systemBlue
    buyCurrencyButton.layer.cornerRadius = 8
    buyCurrencyButton.tintColor = .white
    buyCurrencyButton.setTitle(" - ", for: .normal)
    buyCurrencyButton.showsMenuAsPrimaryAction = true
    
    buyCurrencyTextField = UITextField()
    buyCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
    buyCurrencyTextField.placeholder = "0.00"
    buyCurrencyTextField.isUserInteractionEnabled = false
    buyCurrencyTextField.textAlignment = .center
    
    activityIndicatorView = UIActivityIndicatorView()
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.isHidden = true
    activityIndicatorView.startAnimating()
    
    saveButton = UIButton(type: .system)
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.setTitle("Save", for: .normal)
    saveButton.addTarget(self, action: #selector(handleSaveTap), for: .touchUpInside)
    saveButton.backgroundColor = .systemBlue
    saveButton.tintColor = .white
    saveButton.layer.cornerRadius = 8
    
    descriptionLabel = UILabel()
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.numberOfLines = 2
  }
  
  private func setupHierarchy() {
    view.addSubview(balancesStackView)
    view.addSubview(sellCurrencyButton)
    view.addSubview(sellCurrencyTextField)
    view.addSubview(buyCurrencyButton)
    view.addSubview(buyCurrencyTextField)
    view.addSubview(activityIndicatorView)
    view.addSubview(saveButton)
    view.addSubview(descriptionLabel)
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
      buyCurrencyTextField.heightAnchor.constraint(equalToConstant: 45),
      
      activityIndicatorView.centerXAnchor.constraint(equalTo: buyCurrencyTextField.centerXAnchor),
      activityIndicatorView.centerYAnchor.constraint(equalTo: buyCurrencyTextField.centerYAnchor),
      
      saveButton.topAnchor.constraint(equalTo: sellCurrencyTextField.bottomAnchor, constant: 28),
      saveButton.leadingAnchor.constraint(equalTo: balancesStackView.leadingAnchor),
      saveButton.trailingAnchor.constraint(equalTo: balancesStackView.trailingAnchor),
      saveButton.heightAnchor.constraint(equalToConstant: 45),
      
      descriptionLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
      descriptionLabel.leadingAnchor.constraint(equalTo: saveButton.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: saveButton.trailingAnchor)
    ])
  }
  
  // MARK: - ViewModel Bind
  private func bind() {
    viewModel.didLoadAccount = { [weak self] account in
      guard let self = self else { return }
      self.generateBalancesView(for: account)
      self.generateMenuForCurrencyButton(for: account, type: .sell)
      self.generateMenuForCurrencyButton(for: account, type: .buy)
    }
    
    viewModel.sellCurrency = { [weak self] currency in
      guard let self = self else { return }
      self.sellCurrencyButton.setTitle(currency.code, for: .normal)
    }
    
    viewModel.buyCurrency = { [weak self] currency in
      guard let self = self else { return }
      self.buyCurrencyButton.setTitle(currency.code, for: .normal)
    }
    
    viewModel.buyAmount = { [weak self] exchanged in
      guard let self = self else { return }
      self.buyCurrencyTextField.isHidden = false
      self.activityIndicatorView.isHidden = true
      self.buyCurrencyTextField.text = "\(exchanged)"
    }
    
    viewModel.isSaveEnabled = { [weak self] isEnabled in
      guard let self = self else { return }
      self.saveButton.isEnabled = isEnabled
    }
    
    viewModel.showAlert = { [weak self] result in
      guard let self = self else { return }
      self.showSaveAlert(result: result)
    }
    
    viewModel.resultDidChange = { [weak self] result in
      guard let self = self else { return }
      let feeText = result.exchangeFee != 0 ? "\nFee: \(result.exchangeFee) \(result.fromCurrency.code)" : ""
      
      self.descriptionLabel.text = "Sell: \(result.sellAmount) \(result.fromCurrency.code) | "
      + "Receive: \(result.buyAmount) \(result.toCurrency.code)"
      + feeText
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
    let amount = "\((balance.amount * 100).rounded(.toNearestOrEven) / 100)"
    let view = UILabel()
    view.text = balance.currency.code + " - " + amount
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
      guard let self = self else { return }
      self.didSelect(balance: balance, type: type)
    }
  }
  
  private func didSelect(balance: Balance, type: ExchangeType) {
    switch type {
    case .sell:
      viewModel.setSellBalance(balance)
      sellCurrencyButton.setTitle(balance.currency.code, for: .normal)
    case .buy:
      viewModel.setBuyBalance(balance)
      buyCurrencyButton.setTitle(balance.currency.code, for: .normal)
    }
  }
  
  private func showSaveAlert(result: ConversionResult) {
    let title = "Currency Converted"
    var message = "You have converted \(result.sellAmount) \(result.fromCurrency.code) to \(result.buyAmount) \(result.toCurrency.code)."
    if result.exchangeFee != .zero {
      message += " Commission Fee - \(result.exchangeFee) \(result.fromCurrency.code)"
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(okAction)
    
    present(alertController, animated: true)
  }
  
  @objc private func handleTextInput(_ sender: UITextField) {
    buyCurrencyTextField.isHidden = true
    activityIndicatorView.isHidden = false
    viewModel.sellInputChanged(input: sender.text)
  }
  
  @objc private func handleSaveTap() {
    viewModel.saveExchange()
  }
}

enum ExchangeType {
  case sell
  case buy
}
