//
//  HTTPClientMock.swift
//  leboncoinTests
//
//  Created by Messaoui Meriam on 25/09/2022.
//

import Foundation
@testable import leboncoin

class HTTPClientMock: HTTPClientProtocol {
    
    var getListCallsCount: Int = 0
    func getList<T>(api: HTTPApi, completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
        getListCallsCount += 1
        completion(.success(api == HTTPApi.classifiedAds ? ads as! [T] : cats as! [T]))
    }

    var ads: [AdModel] {
        [
            AdModel(id: 1, categoryId: 1, title: "ad1 1", adDescription: "ad1 description 1", price: 1, imageUrl: nil, creationDate: nil, isUrgent: nil),
            AdModel(id: 2, categoryId: 2, title: "ad1 2", adDescription: "ad1 description 2", price: 2, imageUrl: nil, creationDate: nil, isUrgent: nil)
        ]
    }

    var cats: [CategoryModel] {
        [CategoryModel(id: 1, name: "Cat 1")]
    }


}
