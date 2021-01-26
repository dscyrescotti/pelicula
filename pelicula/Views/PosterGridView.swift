//
//  PosterGridView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI

struct PosterGridView: View {
    @StateObject var viewModel: PosterGridViewModel
    init(endpoint: String, params: [String: Any]) {
        self._viewModel = StateObject<PosterGridViewModel>(wrappedValue: .init(endpoint: endpoint, params: params))
    }
    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical, showsIndicators: true) {
                Section(footer: footer()) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 3), spacing: 10) {
                        ForEach(viewModel.results) { result in
                            PosterImage(result: result, width: reader.size.width / 3.5)
                                .onAppear {
                                    viewModel.next(result: result)
                                }
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
}

struct PosterGridView_Previews: PreviewProvider {
    static var previews: some View {
        PosterGridView(endpoint: "movie/popular", params: [:])
    }
}
