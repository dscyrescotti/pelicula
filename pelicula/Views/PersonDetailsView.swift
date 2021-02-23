//
//  PersonDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import SwiftUI
import Kingfisher

struct PersonDetailsView: View {
    @StateObject private var viewModel: PersonDetailsViewModel
    init(id: Int, type: Results) {
        self._viewModel = StateObject(wrappedValue: PersonDetailsViewModel(id: id, type: type))
    }
    var body: some View {
        Group {
            if let details = viewModel.details {
                GeometryReader { reader in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 15) {
                            avatar(details.profilePath ?? "")
                            title(details)
                            Group {
                                VStack(alignment: .leading) {
                                    age(details)
                                    born(details)
                                }
                                biography(details)
                            }.padding(.horizontal)
                            ImageRow(images: details.images.profiles)
                            posterRow(results: details.combinedCredits.cast, title: "Movies and TVs", endpoint: "\(viewModel.type)/\(viewModel.id)/combined_credits")
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }.navigationBarTitleDisplayMode(.inline)
        
        
        
    }
    
    @ViewBuilder
    func age(_ details: PersonDetails) -> some View {
        if let age = details.age {
            Text("\(age) years old (\(details.birthday.formatDate) - \(details.deathday.formatDate("now")))")
                .font(.title3)
                .fontWeight(.regular)
        }
    }
    
    @ViewBuilder
    func avatar(_ fname: String) -> some View {
        let url = "https://image.tmdb.org/t/p/w500/" + fname
        VStack {
            KFImage(URL(string: url))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .blur(radius: 10)
                .clipped()
                .frame(maxWidth: .infinity)
            Image(url: url, width: 150, height: 170)
                .offset(y: -100)
                .padding(.bottom, -100)
        }
    }
    
    func title(_ details: PersonDetails) -> some View {
        VStack {
            Text(details.name)
                .font(.title)
                .bold()
            Text(details.knownForDepartment)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func biography(_ details: PersonDetails) -> some View {
        if details.biography.isNotEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Biography")
                    .font(.title3)
                    .bold()
                CollapseTextView(text: details.biography, maxLine: 10)
            }
        }
    }
    
    
    @ViewBuilder
    func born(_ details: PersonDetails) -> some View {
        if let place = details.placeOfBirth {
            Text("Born in \(place)")
                .font(.title3)
                .fontWeight(.regular)
        }
    }
    
    @ViewBuilder
    func posterRow(results: [Result], title: String, endpoint: String, rowType: RowType = .credit) -> some View {
        PosterRow(title: title, results: results, endpoint: endpoint, params: [:], type: rowType)
    }
}

struct CastDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(id: 550843, type: .person)
    }
}

struct ImageRow: View {
    let images: [Profile]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(images) { profile in
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500/" + profile.filePath))
                        .cacheOriginalImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 220)
                }
            }
        }
    }
}
