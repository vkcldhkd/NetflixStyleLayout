//
//  ContentCellReactor.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import ReactorKit
import RxSwift

final class ContentCellReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        var model: MovieItemElement
    }
    
    let initialState: State
    
    init(model: MovieItemElement) {
        defer { _ = self.state }
        self.initialState = State(model: model)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
