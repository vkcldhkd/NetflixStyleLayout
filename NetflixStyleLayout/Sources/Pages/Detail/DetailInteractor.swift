//
//  DetailInteractor.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/27/25.
//

import RIBs
import RxSwift

protocol DetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailPresentable: Presentable {
    var listener: DetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didRequestCloseDetail()
}

final class DetailInteractor: PresentableInteractor<DetailPresentable>, DetailInteractable {

    weak var router: DetailRouting?
    weak var listener: DetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension DetailInteractor: DetailPresentableListener {
    func didRequestCloseDetail() {
        self.listener?.didRequestCloseDetail()
    }
//    func detachGameDetail() {
//        guard let router  = self.router else { return }
//
//        self.viewControllable.uiviewController.dismiss(animated: true)
//        detachChild(router) // RIB 트리에서 분리
//        gameDetailRouting = nil // 참조 해제
//    }
}
