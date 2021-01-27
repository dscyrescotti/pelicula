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
                        LazyVStack(alignment: .leading, spacing: 15) {
                            backdrop(details.backdrop ?? "", width: reader.size.width)
                            Group {
                                poster(details)
                                tagline(details)
                                overview(details)
                            }
                            .padding(.horizontal)
                            posterRow(results: details.credits.results, title: "Top Bill Casts", endpoint: "\(viewModel.type)/\(details.id)/credits", rowType: .cast)
                            posterRow(results: details.similar.results, title: "Similar", endpoint: "\(viewModel.type)/\(details.id)/similar")
                            posterRow(results: details.recommendations.results, title: "Recommendations", endpoint: "\(viewModel.type)/\(details.id)/recommendations")
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func posterRow(results: [Result], title: String, endpoint: String, rowType: RowType = .media) -> some View {
        PosterRow(title: title, results: results, endpoint: endpoint, params: [:], type: rowType)
    }
    
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
            Image(url: "https://image.tmdb.org/t/p/w500/" + (details.poster ?? ""), width: 120, height: 190)
            VStack(alignment: .leading, spacing: 5) {
                Text(details.title)
                    .font(.title)
                    .bold()
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
                Text(details.date)
                    .font(.headline)
                if let status = details.status {
                    Text(status)
                        .font(.subheadline)
                        .fontWeight(.light)
                }
            }
            .frame(height: 190, alignment: .top)
        }
    }
    
    @ViewBuilder
    func tagline(_ details: DetailsWrapper) -> some View {
        if details.tagline.isNotEmpty {
            Text(details.tagline)
                .font(.headline)
                .italic()
                .fontWeight(.light)
        }
    }
    
    @ViewBuilder
    func overview(_ details: DetailsWrapper) -> some View {
        if details.overview.isNotEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Overview")
                    .font(.title3)
                    .bold()
                Text(details.overview)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(id: 475557, type: .movie)
    }
}
