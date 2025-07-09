import Foundation
import ReactorKit
import RxSwift

final class CounterReactor: Reactor {
    enum Action {
        case increase
        case decrease
    }

    enum Mutation {
        case setCount(Int)
    }

    struct State {
        var count: Int
    }

    let initialState: State
    private let useCase: CounterUseCase

    init(useCase: CounterUseCase) {
        self.useCase = useCase
        self.initialState = State(count: 0)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            let increaseCount = self.useCase.increase().map { Mutation.setCount($0) }
            return .concat([increaseCount])
            
        case .decrease:
            let decreaseCount = self.useCase.decrease().map { Mutation.setCount($0) }
            return .concat([decreaseCount])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setCount(count):
            var newState = state
            newState.count = count
            return newState
        }
    }
}
