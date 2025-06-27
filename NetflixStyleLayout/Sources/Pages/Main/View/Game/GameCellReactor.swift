//
//  GameCellReactor.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/27/25.
//

import ReactorKit
import RxSwift

final class GameCellReactor: Reactor {
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
