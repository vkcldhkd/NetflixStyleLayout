import Foundation
import RxSwift

protocol CounterRepository {
    func loadCount() -> Int
    func saveCount(_ count: Int) -> Observable<Int>
}

final class DefaultCounterRepository: CounterRepository {
    private let key = "count"

    func loadCount() -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }

    func saveCount(_ count: Int) -> Observable<Int> {
        UserDefaults.standard.set(count, forKey: key)
        return Observable.just(count)
    }
}
