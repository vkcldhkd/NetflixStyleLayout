//
//  TodayContentCell.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit
import FlexLayout
import PinLayout
import ReactorKit

final class TodayContentCell: BaseCollectionViewCell {
    // MARK: - Constants
    typealias Reactor = ContentCellReactor
    
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
        self.thumbnailImageView.pin.all()
    }
}

private extension TodayContentCell {
    // MARK: - setupUI
    func setupUI() {
        self.rootFlexContainer.addSubview(self.thumbnailImageView)
    }
    
    // MARK: - setupConstraints
//    func setupConstraints() {
//        self.rootFlexContainer.flex.define { flex in
//            flex.addItem(self.thumbnailImageView)
//                .grow(1)
//                .width(100%)
//                .height(100%)
//        }
//    }
}


extension TodayContentCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { $0.model.image?.medium }
            .map { URLHelper.createEncodedURL(url: $0) }
            .bind(to: self.thumbnailImageView.kf.rx.image())
            .disposed(by: self.disposeBag)
    }
}
