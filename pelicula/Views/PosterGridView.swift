//
//  PosterGridView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI

struct PosterGridView: View {
    @StateObject private var viewModel: PosterGridViewModel
    let displayMode: Bool
    init(endpoint: String, params: [String: Any], type: RowType, include displayMode: Bool = true) {
        self._viewModel = StateObject<PosterGridViewModel>(wrappedValue: .init(endpoint: endpoint, params: params, type: type))
        self.displayMode = displayMode
    }
    var body: some View {
        if displayMode {
            gridView.navigationBarTitleDisplayMode(.inline)
        } else {
            gridView
        }
    }
    
    var gridView: some View {
        GeometryReader { reader in
            ScrollView(.vertical, showsIndicators: true) {
                Section(footer: footer()) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 3), spacing: 10) {
                        ForEach(viewModel.results) { result in
                            card(result: result, width: reader.size.width)
                                .onAppear {
                                    viewModel.next(result: result)
                                }
                                .toDetailsView(result: result)
                        }
                    }
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
            }
        }
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
}

struct PosterGridView_Previews: PreviewProvider {
    static var previews: some View {
        PosterGridView(endpoint: "movie/popular", params: [:], type: .media)
    }
}
