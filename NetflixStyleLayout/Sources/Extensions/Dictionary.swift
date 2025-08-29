//
//  Dictionary.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 8/29/25.
//

import Foundation

extension Dictionary {
    func toData(options: JSONSerialization.WritingOptions = []) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch {
            print("Dictionary toData Error: \(error)")
            return nil
        }
    }
}
