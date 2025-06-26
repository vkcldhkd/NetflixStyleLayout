//
//  MainViewReactor.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import ReactorKit
import RxSwift

final class MainViewReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        var sections: [NetflixSectionModel]
    }
    
    let initialState: State
    
    init() {
        defer { _ = self.state }
        let sections = MainViewReactor.createTestSection()
        self.initialState = State(sections: sections)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}


private extension MainViewReactor {
    static func createTestSection() -> [NetflixSectionModel] {
//    case recommend
//    case today
//    case watching
//    case games
        
        let recommendSection = NetflixSectionModel(section: .recommend, items: [
            .recommend(RecommendBannerCellReactor()),
            .recommend(RecommendBannerCellReactor()),
            .recommend(RecommendBannerCellReactor()),
            .recommend(RecommendBannerCellReactor())
        ])
        
        let todaySection = NetflixSectionModel(section: .today, items: [
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
        ])
        
        let watching = NetflixSectionModel(section: .watching, items: [
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
        ])
        
        let games = NetflixSectionModel(section: .games, items: [
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
            .today(TodayContentCellReactor()),
        ])
        
        return [recommendSection, todaySection, watching, games]
    }
}
