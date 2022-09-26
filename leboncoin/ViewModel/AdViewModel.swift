//
//  AdViewModel.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import Foundation

class AdViewModel {
    // MARK: - Outputs
    var title: String? {
        ad.title
    }
    var adDescription: String? {
        ad.adDescription
    }
    var price: String? {
        String(format: "%g €",ad.price ?? 0)
    }
    var smallUrl: String? {
        ad.imageUrl?.small
    }
    var thumb: String? {
        ad.imageUrl?.thumb
    }
    var creationDate: String? {
        ad.creationDate?.formattedAdDate()
    }
    var isUrgent: Bool? {
        ad.isUrgent
    }
    var categoryName: String? {
        category?.name
    }

    // MARK: - Private
    private var ad: AdModel
    private var category: CategoryModel?
    
    // MARK: - Init
    required init(ad: AdModel, category: CategoryModel?) {
        self.ad = ad
        self.category = category
    }
}

