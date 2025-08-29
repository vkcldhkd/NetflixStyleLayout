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
import ReusableKit

protocol MainPresentableListener: AnyObject {
    func didTapRecommend()
}

final class MainViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = MainViewReactor
    struct Reusable {
        static let recommendCell = ReusableCell<RecommendBannerCell>()
        static let todayCell = ReusableCell<TodayContentCell>()
        static let gameCell = ReusableCell<GameCell>()
        static let headerView = ReusableView<NetflixSectionHeaderView>()
        static let footerView = ReusableView<LoadingFooterView>()
    }
    
    // MARK: Properties
    weak var listener: MainPresentableListener?
    var adapter: UICollectionViewAdapter<NetflixSectionModel>?
    
    // MARK: UI
    let layout: UICollectionViewCompositionalLayout = NetflixStyleLayout.createLayout()
    lazy var collectionView: BaseCollectionView = BaseCollectionView(
        frame: .zero,
        collectionViewLayout: self.layout
    ).then {
        $0.register(Reusable.recommendCell)
        $0.register(Reusable.todayCell)
        $0.register(Reusable.gameCell)
        $0.register(Reusable.headerView, kind: .header)
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: Initializing
    
    init() {
        defer { self.reactor = Reactor() }
        super.init()
        self.setupUI()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TvmazeService.search()
            .subscribe(onNext: {
                print("response: \($0)")
            })
            .disposed(by: self.disposeBag)
    }
    
    override func setupConstraints() {
        self.rootFlexContainer.flex.define { flex in
            flex.addItem(self.collectionView)
                .grow(1)
        }
    }
}

private extension MainViewController {
    func setupUI() {
        self.rootFlexContainer.addSubview(self.collectionView)
    }
}

extension MainViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        // MARK: - State
        self.bindCollectionView(reactor: reactor)
    }
}

extension MainViewController: MainPresentable, MainViewControllable{
    
}
