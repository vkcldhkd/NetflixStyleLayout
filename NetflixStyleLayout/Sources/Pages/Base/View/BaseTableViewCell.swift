//
//  BaseTableViewCell.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    // MARK: - UI
    let rootFlexContainer = UIView()
    
    // MARK: - Rx
    var disposeBag = DisposeBag()
    
    // MARK: - Initializing
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.layout()
    }
}

private extension BaseTableViewCell {
    // MARK: - setupUI
    func setupUI() {
        self.selectionStyle = .none
        self.separatorInset = .zero
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        self.contentView.addSubview(self.rootFlexContainer)
    }
}
