//
//  BaseView.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import UIKit
import RxSwift
import RxCocoa
import FlexLayout

class BaseView: UIView {
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    // MARK: - UI
    let rootFlexContainer = UIView()
    
    deinit {
        print("DEINIT : \(self.className)")
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout()
    }
}

private extension BaseView {
    // MARK: - setupUI
    func setupUI() {
        self.addSubview(self.rootFlexContainer)
    }
}
