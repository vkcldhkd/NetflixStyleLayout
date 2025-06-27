//
//  MainViewController+CollectionView.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit
import RxSwift

extension MainViewController {
    // MARK: - BindCollectionView
    func bindCollectionView(reactor: Reactor) {
        // MARK: - Initializing
        self.adapter = UICollectionViewAdapter<NetflixSectionModel>(
            collectionView: self.collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case let .recommend(cellReactor):
                    let cell = collectionView.dequeue(Reusable.recommendCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                    
                case let .today(cellReactor):
                    let cell = collectionView.dequeue(Reusable.todayCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                    
                case let .game(cellReactor):
                    let cell = collectionView.dequeue(Reusable.gameCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                    
                default: return UICollectionViewCell()
                }
            },
            headerViewProvider: { collectionView, indexPath, section in
                let view = collectionView.dequeue(Reusable.headerView, kind: .header, for: indexPath)
                print("section: \(indexPath.section) // title: \(section.section.title)")
                view.setTitle(section.section.title)
                return view
            }
        )
        
        // MARK: - Action
        self.adapter?.itemSelected { [weak self] item in
            self?.listener?.didTapRecommend()
//            switch item {
//            case let .recommend(cellReactor):
//                print("recommend item: \(item)")
//                
//            case let .today(cellReactor):
//                print("today item: \(item)")
//            default: return
//            }
        }
        
        // MARK: - State
        self.adapter?.bind(
            state: reactor.state,
            sectionMapper: { $0.sections }
        )
    }
}
