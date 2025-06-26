//
//  LoadingFooterView.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit

final class LoadingFooterView: UICollectionReusableView {
    static let reuseID = "LoadingFooterView"

    // MARK: - UI
    private let rootFlexContainer = UIView()
    private let indicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout()
    }
}

// MARK: - Setup
private extension LoadingFooterView {
    // MARK: - setupUI
    func setupUI() {
        self.rootFlexContainer.addSubview(self.indicatorView)
        self.addSubview(self.rootFlexContainer)
        self.start()
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.rootFlexContainer.flex
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.indicatorView)
                    .width(24)
                    .height(24)
            }
    }
}


// MARK: - Action
extension LoadingFooterView {
    func start() {
        self.indicatorView.startAnimating()
    }

    func stop() {
        self.indicatorView.stopAnimating()
    }
}
