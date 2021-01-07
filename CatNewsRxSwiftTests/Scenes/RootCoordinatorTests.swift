//
//  RootCoordinatorTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 06/01/2021.
//

@testable import CatNewsRxSwift
import XCTest

class RootCoordinatorTests: XCTestCase {

    var rootCoordinator: RootCoordinator!
    var navigationController: UINavigationController!
    var diContainer: DIContainer!

    override func setUpWithError() throws {
        navigationController = UINavigationController()
        diContainer = MockDIContainer()
        rootCoordinator = RootCoordinator(navigationController: navigationController, diContainer: diContainer)
    }

    override func tearDownWithError() throws {
        navigationController = nil
        diContainer = nil
        rootCoordinator = nil
    }

    func testStartAddsStoryListViewControllerToNavigationController() {
        XCTAssertTrue(navigationController.viewControllers.isEmpty)

        rootCoordinator.start()

        XCTAssertTrue(navigationController.viewControllers.last is StoryListViewController)
    }

}
