//
//  HTTPClientTests.swift
//  leboncoinTests
//
//  Created by Messaoui Meriam on 26/09/2022.
//

import XCTest

class HTTPClientTests: XCTestCase {

    var session: URLSessionMock!
    var sut: HTTPClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = URLSessionMock()
        sut = HTTPClient(session: session)
    }

    override func tearDownWithError() throws {
        session = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetDataShouldCallSameURL() {
        //given
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else {
            XCTAssert(false, "BAD URL")
            return
        }
        //when
        sut.get(url: url) { (data, response, error) in
        }
        //then
        XCTAssert(url == session.currentURL)
    }

    func testGetDataShoulResumeDataTask() {
        //given
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            XCTAssert(false, "BAD URL")
            return
        }
        //when
        sut.get(url: url) { (data, response, error) in
        }
        //then
        XCTAssert(session.currentTask.didResume == true)
    }

    func testGetListShouldAddCorrectBaseURL() {
        //given
        let api = HTTPApi.classifiedAds
        //when
        sut.getList(api: api) {(result: Result<[AdModel], NetworkError>) in
        }
        //then
        XCTAssert(session.currentURL.absoluteString == HTTPApi.baseUrl + HTTPApi.classifiedAds.path)
    }

    func testGetListShouldDecodeAdsData() {
        //given
        let api = HTTPApi.classifiedAds
        //when
        let exp = expectation(description: "Decoding Ads")

        sut.getList(api: api) {(result: Result<[AdModel], NetworkError>) in
                switch result {
                case let .success(ads):
                    //then
                    XCTAssertEqual(ads.count, 10)
                    exp.fulfill()
                default:
                    break
                }
        }
        wait(for: [exp], timeout: 1)
    }


 }
