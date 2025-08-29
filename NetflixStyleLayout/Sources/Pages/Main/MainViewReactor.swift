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
        case load
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setMovieResponse(MovieResponse?)
    }
    
    struct State {
        var isLoading: Bool
        var response: MovieResponse?
        var sections: [NetflixSectionModel]
    }
    
    let initialState: State
    
    init() {
        defer { _ = self.state }
//        let sections = MainViewReactor.createTestSection()
        self.initialState = State(
            isLoading: false,
            sections: []
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        let startLoading = Observable<Mutation>.just(.setLoading(true))
        let endLoading = Observable<Mutation>.just(.setLoading(false))
        let setMovieResponse = TvmazeService.search().map { Mutation.setMovieResponse($0?.data) }
        return .concat([startLoading, setMovieResponse, endLoading])
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setLoading(isLoading):
            var newState = state
            newState.isLoading = isLoading
            return newState
            
        case let .setMovieResponse(response):
            var newState = state
            newState.response = response
            newState.sections = MainViewReactor.buildSections(from: response)
            return newState
        }
    }
}


private extension MainViewReactor {
    enum SliceSpec {
        static let recommend = 4
        static let today     = 5
        static let watching  = 5
        static let games     = 6
    }
    
    static func buildSections(from items: MovieResponse?) -> [NetflixSectionModel] {
        guard let items = items else { return [] }
        let recommendSliceItems = items.safeSlice(start: 0, count: SliceSpec.recommend)
        let todaySliceItems = items.safeSlice(start: recommendSliceItems.endIndex, count: SliceSpec.today)
        let watchingSliceItems = items.safeSlice(start: todaySliceItems.endIndex, count: SliceSpec.watching)
        let gameSliceItems = items.safeSlice(start: watchingSliceItems.endIndex, count: SliceSpec.games)

        let recommendItems: [NetflixSectionItem] = recommendSliceItems
            .map { .recommend(ContentCellReactor(model: $0)) }
        let todayItems:     [NetflixSectionItem] = todaySliceItems
            .map { .today(ContentCellReactor(model: $0)) }
        let watchingItems:  [NetflixSectionItem] = watchingSliceItems
//            .map { .watching(ContentCellReactor(model: $0)) }
            .map { .today(ContentCellReactor(model: $0)) }
        let gameItems:      [NetflixSectionItem] = gameSliceItems
            .map { .game(ContentCellReactor(model: $0)) }

        let recommendSection = NetflixSectionModel(section: .recommend, items: recommendItems)
        let todaySection     = NetflixSectionModel(section: .today,     items: todayItems)
        let watchingSection  = NetflixSectionModel(section: .watching,  items: watchingItems)
        let gamesSection     = NetflixSectionModel(section: .games,     items: gameItems)

        return [recommendSection, todaySection, watchingSection, gamesSection]
    }
    
//    static func createTestSection() -> [NetflixSectionModel] {
//        let recommendSection = NetflixSectionModel(section: .recommend, items: [
//            .recommend(RecommendBannerCellReactor()),
//            .recommend(RecommendBannerCellReactor()),
//            .recommend(RecommendBannerCellReactor()),
//            .recommend(RecommendBannerCellReactor())
//        ])
//        
//        let todaySection = NetflixSectionModel(section: .today, items: [
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//        ])
//        
//        let watching = NetflixSectionModel(section: .watching, items: [
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//            .today(TodayContentCellReactor()),
//        ])
//        
//        let games = NetflixSectionModel(section: .games, items: [
//            .game(GameCellReactor()),
//            .game(GameCellReactor()),
//            .game(GameCellReactor()),
//            .game(GameCellReactor()),
//            .game(GameCellReactor()),
//            .game(GameCellReactor()),
//        ])
//        
//        return [recommendSection, todaySection, watching, games]
//    }
}
