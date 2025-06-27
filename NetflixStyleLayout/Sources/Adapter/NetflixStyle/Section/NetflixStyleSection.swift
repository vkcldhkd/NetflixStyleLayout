//
//  NetflixStyleSection.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import RxDataSources

enum NetflixStyleSection: Int, CaseIterable {
    case recommend
    case today
    case watching
    case games
}
extension NetflixStyleSection {
    var title: String {
        switch self {
        case .recommend: return "추천 콘텐츠"
        case .today: return "회원님을 위해 엄선한 오늘의 콘텐츠"
        case .watching: return "회원 님이 시청 중인 콘텐츠"
        case .games: return "모바일 게임"
        }
    }
}


enum NetflixSectionItem {
//    case watching(WatchingProgressReactor)
//    case game(GameIconReactor)
    
    case recommend(RecommendBannerCellReactor)
    case today(TodayContentCellReactor)
    case watching
    case game(GameCellReactor)
}

struct NetflixSectionModel {
    let section: NetflixStyleSection
    var items: [NetflixSectionItem]
}

extension NetflixSectionModel: SectionModelType {
    typealias Item = NetflixSectionItem

    var identity: NetflixStyleSection {
        return section
    }
    
    init(original: NetflixSectionModel, items: [NetflixSectionItem]) {
        self = original
        self.items = items
    }
}
