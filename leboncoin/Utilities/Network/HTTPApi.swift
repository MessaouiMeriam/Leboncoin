//
//  HTTPApi.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import Foundation

enum HTTPApi {
    
    static let baseUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master"

    case classifiedAds
    case categories
        
    var path: String {
        switch self {
        case .classifiedAds:
            return "/listing.json"
        case .categories:
            return "/categories.json"
        }
    }
}
