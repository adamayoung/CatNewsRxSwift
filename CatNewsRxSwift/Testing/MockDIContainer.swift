//
//  MockDIContainer.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

final class MockDIContainer: DIContainer {

    override func resolve() -> NewsStore {
        MockNewsStore()
    }

}
