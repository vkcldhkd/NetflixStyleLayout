//
//  MainRouter.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import UIKit
import RIBs

protocol MainInteractable: Interactable, DetailListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable> {
    private let detailBuilder: DetailBuildable
    private var detailRouter: DetailRouting?
    
    // MARK: - Initializing
    init(
        interactor: MainInteractor,
        viewController: MainViewControllable,
        detailBuilder: DetailBuildable
    ) {
        self.detailBuilder = detailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension MainRouter: MainRouting {
    func routeToDetail() {
        guard self.detailRouter == nil else { return }
        let router = self.detailBuilder.build(
            withListener: interactor
        )
        self.detailRouter = router
        self.attachChild(router)
        let detailViewController = router.viewControllable.uiviewController
        detailViewController.presentationController?.delegate = detailViewController as? UIAdaptivePresentationControllerDelegate
        
        self.viewController.uiviewController.present(
            detailViewController,
            animated: true
        )
    }
    
    func detachDetail() {
        guard let detail = self.detailRouter else { return }
        self.detachChild(detail)
        self.detailRouter = nil
    }
}
