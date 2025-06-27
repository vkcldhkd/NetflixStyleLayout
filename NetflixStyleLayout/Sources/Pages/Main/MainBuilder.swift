//
//  MainBuilder.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/26/25.
//

import RIBs

protocol MainDependency: Dependency, DetailDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        
        let detailBuilder = DetailBuilder(dependency: component.dependency)
        
        return MainRouter(
            interactor: interactor,
            viewController: viewController,
            detailBuilder: detailBuilder
        )
    }
}
