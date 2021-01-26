//
//  MediaDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI
import Kingfisher

struct MediaDetailsView: View {
    @StateObject var viewModel: MediaDetailsViewModel
    init(id: Int,  type: Results) {
        self._viewModel = StateObject(wrappedValue: MediaDetailsViewModel(id: id, type: type))
    }
    var body: some View {
        Group {
            if let details = viewModel.media?.details {
                GeometryReader { reader in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            backdrop(details.backdrop ?? "", width: reader.size.width)
                            poster(details)
                            
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func backdrop(_ fname: String, width: CGFloat) -> some View {
        KFImage(URL(string: "https://image.tmdb.org/t/p/w500/" + fname))
            .placeholder {
                ZStack {
                    Color.red
                    ProgressView()
                }
            }
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: 250, alignment: .center)
            .clipped()
    }
    
    @ViewBuilder
    func poster(_ details: DetailsWrapper) -> some View {
        HStack(alignment: .top, spacing: 15) {
            Image(url: "https://image.tmdb.org/t/p/w500/" + (details.poster ?? ""), width: 110, height: 170)
            VStack(alignment: .leading) {
                Text(details.title)
                    .font(.title)
                    .bold()
                    .lineLimit(3)
                Text(details.date)
                    .font(.headline)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(id: 475557, type: .movie)
    }
}
