//
//  AdsListViewController.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import UIKit

class AdsListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let tabsView = TabsView()
    
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = AppStyle.Color.mainOrange
        loader.hidesWhenStopped = true
        return loader
    }()

    private var viewModel: AdsListViewModelProtocol
    private var categories = [CategoryViewModel]()
    private var ads = [AdViewModel]()
    
    // MARK: - Init
    init(viewModel: AdsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didGetData = {[weak self] ads, categories in
            guard let self = self else {
                return
            }
            self.loader.stopAnimating()
            self.ads = ads
            self.tableView.reloadData()
            if self.categories.isEmpty {
                self.categories = categories
                self.setupTabsView()
            }
        }
        viewModel.didFail = {[weak self] error in
            guard let self = self else {
                return
            }
            self.loader.stopAnimating()
            let alert = UIAlertController(title: Constants.appName, message: error, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        loader.startAnimating()
        viewModel.fetchData()
        setupView()
    }
    // MARK: - Private Method
    private func setupUI() {
        // add subviews
        view.addSubview(tableView)
        view.addSubview(tabsView)
        view.addSubview(loader)
        // tableView
        tableView.register(AdTableViewCell.self, forCellReuseIdentifier: AdTableViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.setAnchors(top: tabsView.bottomAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             leading: view.leadingAnchor,
                             trailing: view.trailingAnchor,
                             distance: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        // tabsView
        tabsView.setAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            distance: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10),
                            size: CGSize(width: 0, height: 30))
        
        //loader View
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    private func setupView() {
        
        tableView.separatorStyle = .none
        view.backgroundColor = AppStyle.Color.white
        // setup navigationBar
        title = Constants.appName
        navigationController?.navigationBar.tintColor = AppStyle.Color.mainOrange
        
    }
    private func setupTabsView() {
        tabsView.layer.cornerRadius = tabsView.frame.height / 2
        tabsView.load(tabs:categories ,
                      selectedTabIndex: 0,
                      seletionColor: AppStyle.Color.lightGray) { [weak self] index in
            guard let self = self else {
                return
            }
            self.viewModel.filterAdsByCategory(categoryId: self.categories[index].id)
        }
    }
}

// MARK: - UITableView Datasource
extension AdsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = adTableViewCell(for: indexPath)
        cell.viewModel = ads[indexPath.row]
        return cell
    }
    
    private func adTableViewCell(for indexPath: IndexPath) -> AdTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.Identifier, for: indexPath) as? AdTableViewCell else {
            return AdTableViewCell()
        }
        return cell
    }
    
}
// MARK: - UITableView Delegate
extension AdsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adDetailsVC = AdDetailsViewController(viewModel: ads[indexPath.row])
        navigationController?.pushViewController(adDetailsVC, animated: true)
    }
}
