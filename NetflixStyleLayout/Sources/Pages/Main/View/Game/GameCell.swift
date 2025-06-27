//
//  GameCell.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/27/25.
//

import UIKit
import FlexLayout
import ReactorKit


final class GameCell: BaseCollectionViewCell {
    // MARK: - Constants
    typealias Reactor = GameCellReactor
    
    // MARK: - UI
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = .gray
    }

    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }
}

private extension GameCell {
    // MARK: - setupUI
    func setupUI() {
        self.rootFlexContainer.addSubview(self.iconImageView)
        self.rootFlexContainer.addSubview(self.titleLabel)
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.rootFlexContainer.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(self.iconImageView)
                .width(100%)
                .aspectRatio(1)
            
            flex.addItem(self.titleLabel)
                .marginTop(4)
                .width(100%)
                .height(20)
                .grow(1)
        }
    }
}

extension GameCell: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
    }
}
