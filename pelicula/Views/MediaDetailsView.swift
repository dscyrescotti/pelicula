//
//  MediaDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI

struct MediaDetailsView: View {
    @StateObject var viewModel: MediaDetailsViewModel
    init(id: Int,  type: Results) {
        self._viewModel = StateObject(wrappedValue: MediaDetailsViewModel(id: id, type: type))
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Hell")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(id: 475557, type: .movie)
    }
}
