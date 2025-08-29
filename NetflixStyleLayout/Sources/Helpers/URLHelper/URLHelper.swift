//
//  URLHelper.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 8/29/25.
//

import UIKit

struct URLHelper { }

// MARK: - Open
extension URLHelper {
    static func openInSafari(_ urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:]) { success in
            if success {
                print("사파리로 열기")
            } else {
                print("URL 에러")
            }
        }
    }
}

// MARK: - Create
extension URLHelper {
    static func createEncodedURL(url : String?) -> URL? {
        guard let url = url?.trimmed,
              url.count > 0,
              let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let returnURL = URL(string: encodedURL) else {
            print("url error!! \(url ?? "")")
            return nil
        }
        
        return returnURL
    }
    
    static func createPath(
        baseURL: String,
        queryItems: [URLQueryItem]?
    ) -> URL {
        var components = URLComponents(string: baseURL.trimmed)
        let totalQueryItems = (components?.queryItems ?? []) + (queryItems ?? [])
        components?.queryItems = totalQueryItems
        guard let url = components?.url else { return URL(string: baseURL)! }
        return url
    }
    
    static func createAbsolutePath(
        baseURL: String,
        queryItems: [URLQueryItem]?
    ) -> String {
        return URLHelper.createPath(
            baseURL: baseURL,
            queryItems: queryItems
        ).absoluteString
    }
}
