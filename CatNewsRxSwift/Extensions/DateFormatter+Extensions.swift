//
//  DateFormatter+Extensions.swift
//  CatNews
//
//  Created by Adam Young on 08/12/2020.
//

import Foundation

extension DateFormatter {

    static var fullDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }

}

extension RelativeDateTimeFormatter {

    static var named: RelativeDateTimeFormatter {
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.dateTimeStyle = .named
        dateFormatter.unitsStyle = .abbreviated
        return dateFormatter
    }

}
