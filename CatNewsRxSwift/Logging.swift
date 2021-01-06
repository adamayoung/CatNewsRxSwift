//
//  Logging.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation
import os.log

extension OSLog {

    private static var subsystem = Bundle.main.bundleIdentifier!

    static let app = OSLog(subsystem: subsystem, category: "App")

}
