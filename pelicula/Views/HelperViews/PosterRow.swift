//
//  PosterRow.swift
//  pelicula
//
//  Created by Dscyre Scotti on 24/01/2021.
//

import SwiftUI
import LazyViewSwiftUI

struct PosterRow: View {
    let title: String
    let results: [Result]
    let endpoint: String
    let params: [String: Any]
    var type: RowType = .media
    var body: some View {
        if !results.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(title)
                        .font(.title3)
                        .bold()
                    Spacer()
                    NavigationLink(destination: LazyView(PosterGridView(endpoint: endpoint, params: params, type: type).navigationTitle(title))) {
                        SwiftUI.Image(systemName: "chevron.right")
                    }
                }.padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 13) {
                        ForEach(results, id: \.uuid) { result in
                            card(result: result).toDetailsView(result: result)
                        }
                    }
                    .padding(.horizontal, 13)
                    .padding(.top, 10)
                }
            }
        }
    }
    
    @ViewBuilder
    private func card(result: Result) -> some View {
        if result.type == .person {
            PosterImage(result: result, height: 110, alpha: 0.65)
        } else {
            PosterImage(result: result)
        }
    }
}
