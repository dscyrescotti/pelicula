//
//  Optional+.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import Foundation

extension Optional where Wrapped == String {
    var formatDate: Wrapped {
        guard let value = self else {
            return "N/A"
        }
        let stringToDate = DateFormatter()
        stringToDate.dateFormat = "yyyy-MM-dd"
        guard let date = stringToDate.date(from: value) else {
            return "N/A"
        }
        let dateToString = DateFormatter()
        dateToString.dateFormat = "d MMM, yyyy"
        return dateToString.string(from: date)
    }
}
