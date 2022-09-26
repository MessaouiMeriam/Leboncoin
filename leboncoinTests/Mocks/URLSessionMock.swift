//
//  URLSessionMock.swift
//  leboncoinTests
//
//  Created by Messaoui Meriam on 26/09/2022.
//

import Foundation

class URLSessionMock: URLSessionProtocol {

    private(set) var currentURL: URL!
    private(set) var currentTask: MockDataTask!

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        currentURL = request.url
        let adsData = try? File.read(filename: "AdsListMock")
        completionHandler(adsData, nil, nil)
        currentTask = MockDataTask()
        return currentTask
    }
}

class MockDataTask: URLSessionDataTaskProtocol {
    private(set) var didResume = false
    func resume() {
        didResume = true
    }
}

import Foundation

public class File {

    enum FileError: Error {
        case invalidPath
    }

    public static func read(filename: String, ofType: String = "json") throws -> Data {
        guard !filename.isEmpty,
            let path = Bundle(for: self).path(forResource: filename, ofType: ofType) else {
                throw FileError.invalidPath
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            return data
        } catch {
            throw error
        }
    }
}
