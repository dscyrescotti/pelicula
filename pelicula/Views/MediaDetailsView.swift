//
//  MediaDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import SwiftUI
import Kingfisher

struct MediaDetailsView: View {
    @StateObject private var viewModel: MediaDetailsViewModel
    init(id: Int,  type: Results) {
        self._viewModel = StateObject(wrappedValue: MediaDetailsViewModel(id: id, type: type))
    }
    var body: some View {
        Group {
            if let details = viewModel.media?.details {
                GeometryReader { reader in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 15) {
                            backdrop(details.backdrop ?? "", width: reader.size.width)
                            Group {
                                poster(details)
                                tagline(details)
                                overview(details)
                            }
                            .padding(.horizontal)
                            posterRow(results: details.credits.results, title: "Top Bill Casts", endpoint: "\(viewModel.type)/\(details.id)/credits", rowType: .cast)
                            trailerRow(videos: details.videos)
                            if let seasons = details.seasons, seasons.count > 0 {
                                seasonRow(seasons: seasons.reversed())
                            }
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
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(id: 66732, type: .tv)
    }
}

// MARK: - Only tv
extension MediaDetailsView {
    @ViewBuilder
    private func seasonCard(season: Season, width: CGFloat? = nil, height: CGFloat) -> some View {
        GeometryReader { proxy in
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500/" + (season.posterPath ?? "")))
                .placeholder {
                    SwiftUI.Image("placeholder-backdrop")
                        .resizable()
                        .scaledToFill()
                }
                .cacheOriginalImage()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .top)
                .overlay(
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5), .black]), startPoint: .top, endPoint: .bottom)
                        VStack(alignment: .leading) {
                            Text("\(season.name)")
                                .font(.title)
                                .bold()
                            HStack {
                                Text("\(season.episodeCount) Episode\(season.episodeCount > 1 ? "s" : "")")
                                Text("|")
                                Text(String(season.airDate.year))
                            }
                            .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                )
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 2)
        }
        .frame(width: width, height: height)
    }
    
    @ViewBuilder
    private func seasonRow(seasons: [Season]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                Text("Seasons")
                    .font(.title3)
                    .bold()
                if let last = seasons.first {
                    seasonCard(season: last, height: 220)
                }
            }
            .padding(.horizontal)
            if seasons.count > 1 {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 13) {
                        ForEach(1..<seasons.count) { index in
                            seasonCard(season: seasons[index], width: 270, height: 180)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 180)
                .padding(.top, 3)
            }
        }
        
    }
}

// MARK: - Both movie and tv
extension MediaDetailsView {
    @ViewBuilder
    private func posterRow(results: [Result], title: String, endpoint: String, rowType: RowType = .media) -> some View {
        PosterRow(title: title, results: results, endpoint: endpoint, params: [:], type: rowType)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private func backdrop(_ fname: String, width: CGFloat) -> some View {
        KFImage(URL(string: "https://image.tmdb.org/t/p/w500/" + fname))
            .placeholder {
                SwiftUI.Image("placeholder-backdrop")
                    .resizable()
                    .scaledToFill()
            }
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: 250, alignment: .center)
            .clipped()
    }
    
    @ViewBuilder
    private func poster(_ details: DetailsWrapper) -> some View {
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
    private func tagline(_ details: DetailsWrapper) -> some View {
        if details.tagline.isNotEmpty {
            Text(details.tagline)
                .font(.headline)
                .italic()
                .fontWeight(.light)
        }
    }
    
    @ViewBuilder
    private func overview(_ details: DetailsWrapper) -> some View {
        if details.overview.isNotEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Overview")
                    .font(.title3)
                    .bold()
                CollapseTextView(text: details.overview, maxLine: 10)
            }
        }
    }
    
    @ViewBuilder
    private func trailerRow(videos: [Video]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Trailers")
                .font(.title3)
                .bold()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 13) {
                    ForEach(videos, id: \.id) { video in
                        WebView(url: "https://www.youtube.com/embed/\(video.key)")
                            .frame(width: 320, height: 200)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
