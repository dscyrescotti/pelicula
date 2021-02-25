//
//  CollapseTextView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/02/2021.
//

import SwiftUI

struct CollapseTextView: View {
    @State private var isShowing: Bool = false
    let text: String
    let maxLine: Int
    var body: some View {
        Text(text)
            .lineLimit(isShowing ? nil : maxLine)
            .fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                self.isShowing.toggle()
            }
    }
}

