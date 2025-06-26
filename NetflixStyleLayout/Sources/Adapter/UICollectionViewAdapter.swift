//
//  UICollectionViewAdapter.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit
import RxSwift
import RxDataSources
import ReusableKit


final class UICollectionViewAdapter<Section: SectionModelType>: NSObject, UICollectionViewDelegateFlowLayout {
    // MARK: - Constants
    typealias SectionItem = Section.Item
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<Section>
    typealias CellProvider = (UICollectionView, IndexPath, SectionItem) -> UICollectionViewCell
    typealias SizeProvider = (UICollectionView, UICollectionViewLayout, IndexPath, SectionItem) -> CGSize
    
    
    // MARK: - Properties
    private let collectionView: UICollectionView
    lazy var dataSource: DataSource = {
        return DataSource(
            configureCell: { [weak self] _, collectionView, indexPath, item in
                guard let self = self else { return UICollectionViewCell() }
                return self.cellProvider(collectionView, indexPath, item)
            },
            configureSupplementaryView: { [weak self] _, collectionView, kind, indexPath in
                switch kind {
                case UICollectionView.elementKindSectionFooter:
                    guard let self = self else { return UICollectionReusableView() }
                    guard let footerView = self.footerView else { return UICollectionReusableView() }
                    return collectionView.dequeue(footerView, kind: kind, for: indexPath)
                default:
                    return UICollectionReusableView()
                }
            }
        )
    }()

    // MARK: - Rx
    private let disposeBag = DisposeBag()

    // MARK: - Provider
    private let cellProvider: CellProvider
    private var sizeProvider: SizeProvider?
    
    // MARK: - Footer
    private var isFooterVisible: Bool = false
    private let footerView: ReusableView<LoadingFooterView>?
    // MARK: - Rx 외부 바인딩
    var reachedBottom: Observable<Void> {
        return self.collectionView.rx.isReachedBottom.asObservable()
    }
    
    // MARK: - Initializing
    init(
        collectionView: UICollectionView,
        cellProvider: @escaping CellProvider,
        sizeProvider: SizeProvider? = nil,
        footerView: ReusableView<LoadingFooterView>? = nil
//        supplementaryViewProvider: SupplementaryViewProvider? = nil
    ) {
        self.collectionView = collectionView
        self.cellProvider = cellProvider
        self.sizeProvider = sizeProvider
        self.footerView = footerView
//        self.supplementaryViewProvider = supplementaryViewProvider
        super.init()
        

    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let sizeProvider = sizeProvider else { return .zero }

        do {
            let model = try dataSource.model(at: indexPath)
            guard let item = model as? Section.Item else {
                return .zero
            }
            return sizeProvider(collectionView, collectionViewLayout, indexPath, item)
        } catch {
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard self.footerView != nil else { return .zero }
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
}

extension UICollectionViewAdapter {
    // MARK: - Footer 표시 제어
    func setFooterVisible(_ visible: Bool) {
//        guard self.isFooterVisible != visible else { return }
//        self.isFooterVisible = visible
////        self.collectionView.reloadSections(IndexSet(integer: self.collectionView.numberOfSections - 1))
//        self.collectionView.performBatchUpdates(nil)
    }
}

extension UICollectionViewAdapter {
    func bind<State>(
        state: Observable<State>,
        sectionMapper: @escaping (State) -> [Section]
    ) {
        if let footerView = self.footerView {
            self.collectionView.register(footerView, kind: UICollectionView.elementKindSectionFooter)
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.footerReferenceSize = CGSize(width: 1, height: 1)
            }
        }
        
        self.collectionView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        state
            .map(sectionMapper)
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }

    func itemSelected(handler: @escaping (SectionItem) -> Void) {
        self.collectionView.rx.modelSelected(SectionItem.self)
            .bind(onNext: handler)
            .disposed(by: self.disposeBag)
    }
}
