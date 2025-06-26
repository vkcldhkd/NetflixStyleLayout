//
//  TodayContentCellReactor.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import ReactorKit
import RxSwift

final class TodayContentCellReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    let initialState: State
    
    init() {
        defer { _ = self.state }
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
