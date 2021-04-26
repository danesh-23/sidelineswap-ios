//
//  ItemsTableVC.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-22.
//

import UIKit

class ItemsTableVC: UITableViewController {
    
    let itemsTableVM: ItemsTableViewModel = ItemsTableViewModel()
    let searchBar = SearchBar()
    
    var loadingScreenView: UIView?
    var activityIndicatorView: UIActivityIndicatorView?
    var retryButton: UIButton?
    var messageLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoadingScreen()
        setupTableViewModel()
        tableView.allowsSelection = false
   
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemsTableVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsTableVM.numberOfRowsForSection(at: section)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard itemsTableVM.filtered.count == 0 else { return }
        let numOfRows = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == numOfRows - 3 {
            itemsTableVM.populateData()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsCell.identifier, for: indexPath) as! ItemsCell
            let itemsCellVM = itemsTableVM.itemForRowAt(at: indexPath.row)
            cell.configureCell(vm: itemsCellVM)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            cell.loadingIndicator.startAnimating()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 350 : 42.5
    }
    
    func setupTableViewModel() {
        itemsTableVM.refreshTableBinding = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        itemsTableVM.removeLoadingScreenBinding = { [weak self] in
            self?.loadingScreenRemoved()
        }
        
        itemsTableVM.showAlert = displayAlertView(with:)
        
        itemsTableVM.populateData()
        hideKeyboardWhenTappedOutsideSearch()
    }
    
    func hideKeyboardWhenTappedOutsideSearch() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    func configureLoadingScreen() {
        loadingScreenView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView = UIActivityIndicatorView()
        messageLabel = UILabel()
        guard let loadingScreenView = loadingScreenView, let activityIndicatorView = activityIndicatorView, let messageLabel = messageLabel else { return }
        
        loadingScreenView.backgroundColor = .black
        tableView.isScrollEnabled = false
        
        activityIndicatorView.center = loadingScreenView.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        
        messageLabel.numberOfLines = 3
        messageLabel.text = "Loading..."
        messageLabel.font = UIFont(name: "Futura-Bold", size: 20)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        
        tableView.addSubview(loadingScreenView)
        loadingScreenView.addSubview(activityIndicatorView)
        loadingScreenView.addSubview(messageLabel)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: loadingScreenView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: loadingScreenView.centerYAnchor).isActive = true
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: loadingScreenView.centerXAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: activityIndicatorView.topAnchor, constant: -20).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: loadingScreenView.leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: loadingScreenView.trailingAnchor, constant: -20).isActive = true
    }
    
    func loadingScreenRemoved() {
        DispatchQueue.main.async { [weak self] in
            guard self?.loadingScreenView != nil, self?.activityIndicatorView != nil else { return }
            
            self?.activityIndicatorView!.stopAnimating()
            self?.loadingScreenView?.removeFromSuperview()
            self?.tableView.isScrollEnabled = true
            self?.tableView.separatorColor = .white
        }
    }
    
    func displayAlertView(with string: String) {
        DispatchQueue.main.async { [weak self] in
            let alertViewController = UIAlertController(title: "Couldn't load items", message: "\(string.capitalized). Please fix this and try again.", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alertViewController, animated: true, completion: self?.changeMessageLabel)
            
        }
    }
    
    func changeMessageLabel() {
        guard let messageLabel = messageLabel, let activity = activityIndicatorView else { return }
        messageLabel.text = "Try again"
        activity.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(retryPopulating))
        tapGesture.numberOfTapsRequired = 1
        messageLabel.isUserInteractionEnabled = true
        messageLabel.addGestureRecognizer(tapGesture)
        messageLabel.textColor = .systemBlue
    }
    
    @objc func retryPopulating() {
        guard let activity = activityIndicatorView else { return }
        activity.isHidden = false
        itemsTableVM.populateData()
    }
}

extension ItemsTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        itemsTableVM.searchFieldEntered(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        itemsTableVM.searchBarEntered(searchText: text)
        self.searchBar.endEditing(true)
    }
}


