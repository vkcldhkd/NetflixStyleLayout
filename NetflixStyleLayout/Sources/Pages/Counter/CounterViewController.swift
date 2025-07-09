import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import FlexLayout

final class CounterViewController: BaseViewController {

    private let countLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 36)
        $0.textAlignment = .center
    }
    private let increaseButton = UIButton(type: .system).then {
        $0.setTitle("Increase", for: .normal)
    }
    private let decreaseButton = UIButton(type: .system).then {
        $0.setTitle("Decrease", for: .normal)
    }

    // MARK: - Initializing
    init() {
        defer {
            // ✅ Repository와 UseCase를 구성하고 Reactor에 주입
            let repository = DefaultCounterRepository()
            let useCase = DefaultCounterUseCase(repository: repository)
            self.reactor = CounterReactor(useCase: useCase)
        }
        super.init()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func setupConstraints() {
        self.rootFlexContainer.flex.define { flex in
            flex.addItem(self.countLabel)
                .marginTop(20)
                .width(80%)
                .alignSelf(.center)

            flex.addItem(self.increaseButton)
                .marginTop(20)
                .alignSelf(.center)

            flex.addItem(self.decreaseButton)
                .marginTop(20)
                .alignSelf(.center)
        }
    }
}

private extension CounterViewController {
    // MARK: - setupUI
    func setupUI() {
        self.rootFlexContainer.addSubview(self.countLabel)
        self.rootFlexContainer.addSubview(self.increaseButton)
        self.rootFlexContainer.addSubview(self.decreaseButton)
    }
}

extension CounterViewController: ReactorKit.View {
    func bind(reactor: CounterReactor) {
        // MARK: - Action
        self.increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // MARK: - State
        reactor.state.map { $0.count }
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
