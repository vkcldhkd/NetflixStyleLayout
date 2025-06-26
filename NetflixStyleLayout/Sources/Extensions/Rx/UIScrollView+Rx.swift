//
//  UIScrollView+Rx.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIScrollView {
    var isReachedBottom: ControlEvent<Void> {
        let source = self.contentOffset
            .filter { [weak base = self.base] offset in
                guard let base = base else { return false }
                return base.isReachedBottom(withTolerance: base.frame.height / 2)
            }
            .map { _ in Void() }
        return ControlEvent(events: source)
    }
}
