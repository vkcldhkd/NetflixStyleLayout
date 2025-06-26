//
//  RootBuilder.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import RIBs

protocol RootDependency: MainDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    // MARK: - Properties
    private let rootViewController: RootViewController
    
    // MARK: - Initializing
    init(
        dependency: RootDependency,
        rootViewController: RootViewController
    ) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        let MainBuilder = MainBuilder(dependency: component.dependency)
        
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            MainBuilder: MainBuilder
        )
    }
}
