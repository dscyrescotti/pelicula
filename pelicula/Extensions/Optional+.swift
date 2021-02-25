//
//  Optional+.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import Foundation

extension Optional where Wrapped == String {
    var formatDate: Wrapped {
        formatDate("N/A")
    }
    
    var year: Int {
        guard let value = self else {
            return Calendar.current.component(.year, from: Date())
        }
        let stringToDate = DateFormatter()
        stringToDate.dateFormat = "yyyy-MM-dd"
        guard let date = stringToDate.date(from: value) else {
            return Calendar.current.component(.year, from: Date())
        }
        return Calendar.current.component(.year, from: date)
    }
    
    func formatDate(_ rValue: String) -> Wrapped {
        guard let value = self else {
            return rValue
        }
        let stringToDate = DateFormatter()
        stringToDate.dateFormat = "yyyy-MM-dd"
        guard let date = stringToDate.date(from: value) else {
            return rValue
        }
        let dateToString = DateFormatter()
        dateToString.dateFormat = "d MMM, yyyy"
        return dateToString.string(from: date)
    }
}
