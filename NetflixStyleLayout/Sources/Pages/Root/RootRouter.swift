//
//  RootRouter.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import RIBs

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func replaceScreen(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    // MARK: - Properties
    private let mainBuilder: MainBuildable
    private var mainRouter: MainRouting?
    
    // MARK: - Initializing
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        MainBuilder: MainBuildable
    ) {
        self.mainBuilder = MainBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RootRouter: RootRouting {
    func attachMain() {
        guard self.mainRouter == nil else { return }
        let router = self.mainBuilder.build(withListener: interactor)
        self.attachChild(router)
        self.mainRouter = router
        self.viewController.replaceScreen(viewController: router.viewControllable)
    }
}

internal class SecretManager {
    func run() {
        print("Running")
    }
}
