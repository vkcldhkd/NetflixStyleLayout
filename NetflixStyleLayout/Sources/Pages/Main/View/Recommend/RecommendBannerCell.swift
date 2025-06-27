//
//  RecommendBannerCell.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit
import FlexLayout
import PinLayout
import ReactorKit

final class RecommendBannerCell: BaseCollectionViewCell {
    // MARK: - Constants
    typealias Reactor = RecommendBannerCellReactor
    
    // MARK: - UI
    private let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }

    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
//        self.setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.thumbnailImageView.pin
            .top(4).bottom(4)
            .left(16).right(16)
    }
}

private extension RecommendBannerCell {
    // MARK: - setupUI
    func setupUI() {
        self.rootFlexContainer.addSubview(self.thumbnailImageView)
    }
    
//    // MARK: - setupConstraints
//    func setupConstraints() {
//        self.rootFlexContainer.flex.define { flex in
//            flex.addItem(self.thumbnailImageView)
//                .grow(1)
//                .width(100%)
//                .height(100%)
//        }
//    }
}

extension RecommendBannerCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
    }
}
