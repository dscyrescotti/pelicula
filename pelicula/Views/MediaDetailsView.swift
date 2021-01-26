//
//  MediaDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI

struct MediaDetailsView: View {
    @StateObject var viewModel = MediaDetailsViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Hell")
            }
        }.onAppear {
            viewModel.loadDetails()
        }
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView()
    }
}
