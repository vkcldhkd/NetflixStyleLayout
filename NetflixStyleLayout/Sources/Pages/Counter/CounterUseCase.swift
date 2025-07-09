import Foundation
import RxSwift

protocol CounterUseCase {
    func increase() -> Observable<Int>
    func decrease() -> Observable<Int>
    func currentCount() -> Observable<Int>
}

final class DefaultCounterUseCase: CounterUseCase {
    private let repository: CounterRepository

    init(repository: CounterRepository) {
        self.repository = repository
    }

    func increase() -> Observable<Int> {
        return repository.saveCount(repository.loadCount() + 1)
    }

    func decrease() -> Observable<Int> {
        return repository.saveCount(repository.loadCount() - 1)
    }

    func currentCount() -> Observable<Int> {
        return Observable.just(repository.loadCount())
    }
}
