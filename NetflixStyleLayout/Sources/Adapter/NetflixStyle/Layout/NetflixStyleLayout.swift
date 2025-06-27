//
//  NetflixStyleLayout.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit

struct NetflixStyleLayout { }

extension NetflixStyleLayout {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
               guard let sectionType = NetflixStyleSection(rawValue: sectionIndex) else { return nil }
               
               switch sectionType {
               case .recommend:
                   // Full width, full screen ratio
                   let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .fractionalHeight(1.0))
                   let item = NSCollectionLayoutItem(layoutSize: itemSize)

                   let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .absolute(500))
                   let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                   let section = NSCollectionLayoutSection(group: group)
                   section.orthogonalScrollingBehavior = .continuous
                   section.orthogonalScrollingBehavior = .groupPaging
                   return section

               case .today, .watching, .games:
                   let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(140),
                                                         heightDimension: .estimated(200))
                   let item = NSCollectionLayoutItem(layoutSize: itemSize)

                   let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(140),
                                                          heightDimension: .estimated(200))
                   let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                  subitems: [item])

                   let section = NSCollectionLayoutSection(group: group)
                   section.orthogonalScrollingBehavior = .continuous
                   section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                   section.interGroupSpacing = 8
                   
                   // 헤더 사이즈 정의
                   let headerSize = NSCollectionLayoutSize(
                       widthDimension: .fractionalWidth(1.0),
                       heightDimension: .absolute(44) // 높이는 원하는 만큼
                   )

                   let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                       layoutSize: headerSize,
                       elementKind: UICollectionView.elementKindSectionHeader,
                       alignment: .top
                   )

                   sectionHeader.pinToVisibleBounds = false
                   sectionHeader.zIndex = 2
                   section.boundarySupplementaryItems = [sectionHeader]
                   return section
               }
           }
    }
}
