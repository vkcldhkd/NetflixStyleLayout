//
//  TvmazeService.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 8/29/25.
//

import Foundation
import RxSwift

struct TvmazeService {
    private static let baseURL = "https://api.tvmaze.com/shows"
//    https://api.tvmaze.com/shows?page=0
}

extension TvmazeService {
    static func search(page: Int = 0) -> Observable<NetworkResponse<MovieResponse>?> {
        
        let baseURL = TvmazeService.baseURL
        let queryItems: [URLQueryItem]? = TvmazeService.createURLItems(page: page)
        
        let path: String = URLHelper.createAbsolutePath(
            baseURL: baseURL,
            queryItems: queryItems
        )
        
        return NetworkManager.requestDecodable(type: MovieResponse.self, method: .get, url: path)
            .map { NetworkResponse(path: path, item: $0) }
    }
}

private extension TvmazeService {
    static func createURLItems(
        page: Int
    ) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
}
