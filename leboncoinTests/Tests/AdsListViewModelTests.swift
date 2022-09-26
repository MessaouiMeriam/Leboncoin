//
//  HomeViewModelTests.swift
//  leboncoinTests
//
//  Created by Messaoui Meriam on 25/09/2022.
//

import XCTest
@testable import leboncoin

class AdsListViewModelTests: XCTestCase {

    var sut: AdsListViewModel!
    var httpClientMock: HTTPClientMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        httpClientMock = HTTPClientMock()
        sut = AdsListViewModel(httpClient: httpClientMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        httpClientMock = nil
        try super.tearDownWithError()
    }

    func testfechDataShouldFetchCategoriesAndAds() {
      // given
      // when
        sut.fetchData()

      // then
        XCTAssertEqual(httpClientMock.getListCallsCount, 2)
    }

    func testFilterAdsShouldReturnAllAdsWhenAllCategoriesIsSelected() {
        //given
        sut.fetchData()
        //when
        sut.filterAdsByCategory(categoryId: -1)
        //then
        XCTAssertEqual(sut.filtredAds.count, 2)
    }

}
