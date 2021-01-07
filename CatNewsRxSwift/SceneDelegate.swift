//
//  SceneDelegate.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var diContainer: DIContainer = {
        let arguments = ProcessInfo.processInfo.arguments
        let isUITest = arguments.contains("UI_TEST")
        if isUITest {
            return MockDIContainer()
        }

        return DIContainer()
    }()

    private var rootCoordinator: RootCoordinating?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let rootCoordinator: RootCoordinating = diContainer.resolve(navigationController: navigationController)

        window.rootViewController = navigationController
        rootCoordinator.start()
        window.makeKeyAndVisible()

        self.window = window
        self.rootCoordinator = rootCoordinator
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
