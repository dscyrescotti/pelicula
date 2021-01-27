//
//  PosterGridView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI

struct PosterGridView: View {
    @StateObject var viewModel: PosterGridViewModel
    init(endpoint: String, params: [String: Any], type: RowType) {
        self._viewModel = StateObject<PosterGridViewModel>(wrappedValue: .init(endpoint: endpoint, params: params, type: type))
    }
    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical, showsIndicators: true) {
                Section(footer: footer()) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 3), spacing: 10) {
                        ForEach(viewModel.results) { result in
                            NavigationLink(destination: destination(result: result)) {
                                card(result: result, width: reader.size.width)
                                    .onAppear {
                                        viewModel.next(result: result)
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func footer() -> some View {
        if viewModel.isEnd {
            Text("End")
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func card(result: Result, width: CGFloat) -> some View {
        if viewModel.type == .cast {
            PosterImage(result: result, width: width / 3.5, height: 110, alpha: 0.65)
        } else {
            PosterImage(result: result, width: width / 3.5)
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

struct PosterGridView_Previews: PreviewProvider {
    static var previews: some View {
        PosterGridView(endpoint: "movie/popular", params: [:], type: .media)
    }
}
