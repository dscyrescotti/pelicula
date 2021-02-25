//
//  PersonDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import SwiftUI
import Kingfisher
import ImageViewer

struct PersonDetailsView: View {
    @StateObject private var viewModel: PersonDetailsViewModel
    @State private var url: String? = nil
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
                            ImageRow(images: details.images.profiles, url: $url)
                            posterRow(results: details.combinedCredits.cast, title: "Movies and TVs", endpoint: "\(viewModel.type)/\(viewModel.id)/combined_credits")
                        }
                    }
                }
                .overlay(
                    ImageSheet(url: $url)
                )
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
        NavigationView {
            PersonDetailsView(id: 550843, type: .person)
                .navigationTitle("Person")
        }
    }
}

struct ImageRow: View {
    let images: [Profile]
    @Binding var url: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Images")
                .font(.title3)
                .bold()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(images) { profile in
                        let url = "https://image.tmdb.org/t/p/w500/" + profile.filePath
                        KFImage(URL(string: url))
                            .cacheOriginalImage()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 220)
                            .onTapGesture {
                                self.url = url
                            }
                    }
                }
            }
        }
    }
}

struct ImageSheet: View {
    @Binding var url: String?
    var body: some View {
        if let strURL = url {
            ZStack {
                Color.black.overlay(KFImage(URL(string: strURL))
                                        .cacheOriginalImage()
                                        .resizable()
                                        .aspectRatio(contentMode: .fit))
                    .edgesIgnoringSafeArea(.all)
                Button(action: {
                    self.url = nil
                }) {
                    SwiftUI.Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 37))
                        .foregroundColor(.white)
                        .opacity(0.55)
                }
                .padding(5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .navigationBarHidden(self.url != nil)
        }
    }
}
