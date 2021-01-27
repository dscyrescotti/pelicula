//
//  PosterRow.swift
//  pelicula
//
//  Created by Dscyre Scotti on 24/01/2021.
//

import SwiftUI

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
                    NavigationLink(destination: PosterGridView(endpoint: endpoint, params: params, type: type).navigationTitle(title)) {
                        SwiftUI.Image(systemName: "chevron.right")
                    }
                }.padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 13) {
                        ForEach(results) { result in
                            NavigationLink(destination: destination(result: result)) {
                                card(result: result)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 13)
                    .padding(.top, 10)
                }
            }
        }
    }
    
    @ViewBuilder
    func card(result: Result) -> some View {
        if result.type == .crew {
            PosterImage(result: result, height: 110, alpha: 0.65)
        } else {
            PosterImage(result: result)
        }
    }
    
    @ViewBuilder
    func destination(result: Result) -> some View {
        if result.type == .movie || result.type == .tv {
            MediaDetailsView(id: result.id, type: result.type)
                .navigationTitle(result.title)
        } else {
            Text("Oop!")
        }
    }
}

