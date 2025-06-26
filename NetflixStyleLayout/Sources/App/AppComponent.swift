//
//  AppComponent.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/24/25.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
    
    // MARK: - Initializing
    init() {
        super.init(dependency: EmptyComponent())
    }
}
