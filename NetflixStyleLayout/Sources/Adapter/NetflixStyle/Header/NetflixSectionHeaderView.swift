//
//  NetflixSectionHeaderView.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit

final class NetflixSectionHeaderView: UICollectionReusableView {
    // MARK: - UI
    private let titleLabel = UILabel()
    private let container = UIView()

    // MARK: - Initializing
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
        self.container.pin.all()
        self.container.flex.layout()
    }


}

extension NetflixSectionHeaderView {
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
}


private extension NetflixSectionHeaderView {
    // MARK: - setupUI
    func setupUI() {
        self.titleLabel.font = .boldSystemFont(ofSize: 18)
//        self.titleLabel.textColor = .white
        self.container.addSubview(self.titleLabel)
        
        self.addSubview(self.container)
        
    }
    
    // MARK: - setupConstraints
    func setupConstraints() {
        self.container.flex
            .define { flex in
                flex.addItem(self.titleLabel)
                    .margin(4)
                    .grow(1)
        }
    }
}
