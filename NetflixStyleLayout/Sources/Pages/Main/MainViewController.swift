//
//  MainViewController.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit

import ReactorKit
import RxSwift
import RIBs

protocol MainPresentableListener: AnyObject {
}

final class MainViewController: BaseViewController {
    
    // MARK: Properties
    weak var listener: MainPresentableListener?
    
    // MARK: UI
    lazy var collectionView: BaseCollectionView = BaseCollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: Initializing
    
    init() {
//        defer { self.reactor = reactor }
        super.init()
        self.setupUI()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupConstraints() {
        self.rootFlexContainer.flex.define { flex in
            flex.addItem(self.collectionView).grow(1)
        }
    }
}

private extension MainViewController {
    func setupUI() {
        self.rootFlexContainer.addSubview(self.collectionView)
    }
}

extension MainViewController: MainPresentable, MainViewControllable{
    
}
