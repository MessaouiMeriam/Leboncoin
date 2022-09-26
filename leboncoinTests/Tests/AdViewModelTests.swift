//
//  AdViewModelTests.swift
//  leboncoinTests
//
//  Created by Messaoui Meriam on 26/09/2022.
//

import XCTest
@testable import leboncoin

class AdViewModelTests: XCTestCase {
    private let ad = AdModel(id: 1, categoryId: 1, title: "ad 1", adDescription: "ad1 description", price: 1, imageUrl: nil, creationDate: "2019-11-05T15:56:59+0000", isUrgent: nil)
    private let cat = CategoryModel(id: 1, name: "cat 1")

    var sut: AdViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AdViewModel(ad: ad, category: cat)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testViewModelTitle() {
        // given
        // when
        let title = sut.title

        // then
        XCTAssert(title == "ad 1")

    }
    
    func testViewModelPrice() {
        // given
        // when
        let price = sut.price

        // then
        XCTAssert(price == "1 €")
    }
    
    func testViewModelDate() {
        // given
        // when
        let date = sut.creationDate
        // then
        XCTAssert(date == "05/11/2019 à 16:56")
    }
    
}

