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
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .font(.title3)
                    .bold()
                Spacer()
                NavigationLink(destination: PosterGridView(endpoint: endpoint, params: params).navigationTitle(title)) {
                    SwiftUI.Image(systemName: "chevron.right")
                }
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 13) {
                    ForEach(results) { result in
                        NavigationLink(destination: destination(result: result)) {
                            PosterImage(result: result)
                        }
                    }
                }
                .padding(.horizontal, 13)
                .padding(.top, 12)
            }
        }.padding(.vertical, 5)
    }
    
    @ViewBuilder
    func destination(result: Result) -> some View {
        if result.type == .movie || result.type == .tv {
            MediaDetailsView()
        } else {
            Text("Oop!")
        }
    }
}

