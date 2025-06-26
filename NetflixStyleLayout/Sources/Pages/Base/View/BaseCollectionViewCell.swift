//
//  BaseCollectionViewCell.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    let rootFlexContainer = UIView()
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: - Rx
    var disposeBag = DisposeBag()
    
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
        self.setupUI()
    }
    
    deinit {
        print("DEINIT: \(self.className)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}


private extension BaseCollectionViewCell {
    // MARK: - setupUI
    func setupUI() {
        self.contentView.addSubview(self.rootFlexContainer)
    }
}
