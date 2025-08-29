//
//  Array.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 8/30/25.
//

import Foundation
extension Array {
    /// start와 count를 클램핑해서 안전하게 슬라이스 반환 (공간 공유: ArraySlice)
    func safeSlice(start: Int, count: Int) -> ArraySlice<Element> {
        guard count > 0 else { return [] }
        let s = Swift.max(0, start)
        guard s < self.count else { return [] }
        let e = Swift.min(self.count, s + count)
        return self[s..<e]
    }

    /// 필요하면 바로 [Element]로 받고 싶을 때
    func safeArray(start: Int, count: Int) -> [Element] {
        Array(self.safeSlice(start: start, count: count))
    }

    /// (옵션) Range 기반 버전
    func safeSlice(_ range: Range<Int>) -> ArraySlice<Element> {
        let s = Swift.max(0, range.lowerBound)
        let e = Swift.min(self.count, range.upperBound)
        return (s < e) ? self[s..<e] : []
    }

    /// (옵션) 단일 인덱스 안전 접근
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
