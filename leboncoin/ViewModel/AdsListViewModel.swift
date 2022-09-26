//
//  AdsListViewModel.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import Foundation


protocol AdsListViewModelProtocol {
    func fetchData()
    var didGetData: (([AdViewModel], [CategoryViewModel]) -> Void)? { get set }
    var didFail: ((String) -> Void)? { get set }
    func filterAdsByCategory(categoryId: Int)
}
class AdsListViewModel: AdsListViewModelProtocol {
    
    var didGetData: (([AdViewModel], [CategoryViewModel]) -> Void)?
    var didFail: ((String) -> Void)?
    var httpClient: HTTPClientProtocol
    
    // MARK: - Private Vars
    private var allAds = [AdModel]()
    private var categories = [CategoryModel]()
    private var categoriesViewModels : [CategoryViewModel] {
        categories.compactMap({CategoryViewModel(category: $0)})
    }
    private var adsViewModels: [AdViewModel] {
        filtredAds.compactMap { ad in
            AdViewModel(ad: ad, category: categories.first { $0.id == ad.categoryId})
        }
    }

    private(set) var filtredAds = [AdModel]() {
        didSet {
            didGetData?(adsViewModels, categoriesViewModels)
        }
    }

    // MARK: - Init
    required init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    // MARK: - Public Methods
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getCategoriesList {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getAdsList {
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {[weak self] in
            guard let self = self else {
                return
            }
            self.filtredAds = self.allAds
        }
    }

    func filterAdsByCategory(categoryId: Int){
        if categoryId > -1 {
            filtredAds = allAds.filter({$0.categoryId == categoryId})
        } else {
            filtredAds = allAds
        }
    }
    // MARK: - Private Methods
    private func getAdsList(completion: @escaping () -> Void) {
        httpClient.getList(api: .classifiedAds) { [weak self] (result: Result<[AdModel], NetworkError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let adsModels):
                self.allAds = adsModels
                self.sortAds(adsModels: &self.allAds)
            case .failure(let error):
                self.didFail?(error.description)
                break
            }
            completion()
        }
    }

    private func getCategoriesList(completion: @escaping () -> Void) {
        httpClient.getList(api: .categories) { [weak self] (result: Result<[CategoryModel], NetworkError>) in
            switch result {
            case .success(let categoryModel):
                self?.categories = [CategoryModel(id: -1, name: Constants.allCat)] + categoryModel
            case .failure(let error):
                self?.didFail?(error.description)
                break
            }
            completion()
        }
    }
    
    private func sortAds(adsModels: inout [AdModel]) {
        adsModels = adsModels.sorted { ad0, ad1 in
            guard let isUrgent0 = ad0.isUrgent,
                    let isUrgent1 = ad1.isUrgent,
                    let date0 = ad0.creationDate,
                    let date1 = ad1.creationDate else {
                return false
            }
            if ad0.isUrgent != ad1.isUrgent {
                return isUrgent0 && !isUrgent1
            } else {
                return date0 < date1
            }
        }
    }
}
