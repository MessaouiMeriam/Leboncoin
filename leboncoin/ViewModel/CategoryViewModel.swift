//
//  CategoryViewModel.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 22/09/2022.
//

import Foundation

class CategoryViewModel {
    // MARK: - Outputs
    
    var id: Int {
        category.id
    }
    var name: String? {
        category.name
    }
    // MARK: - Private
    private var category: CategoryModel
    
    // MARK: - Init
    required init(category: CategoryModel) {
        self.category = category
    }
}


