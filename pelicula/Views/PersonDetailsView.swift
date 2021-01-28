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
                            Text(details.name)
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                                .frame(width: reader.size.width)
                            Group {
                                birthdate(details)
                                biography(details)
                            }.padding(.horizontal)
                            posterRow(results: details.combinedCredits.cast, title: "Movies and TVs", endpoint: "\(viewModel.type)/\(viewModel.id)/combined_credits")
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }.navigationBarTitleDisplayMode(.inline)
        
        
        
    }
    
    func avatar(_ fname: String) -> some View {
        VStack {
            Rectangle()
                .frame(height: 140)
            Image(url: "https://image.tmdb.org/t/p/w500/" + fname, width: 150, height: 170)
                .offset(y: -100)
                .padding(.bottom, -100)
        }
    }
    
    @ViewBuilder
    func biography(_ details: PersonDetails) -> some View {
        if details.biography.isNotEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Biography")
                    .font(.title3)
                    .bold()
                Text(details.biography)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    
    @ViewBuilder
    func birthdate(_ details: PersonDetails) -> some View {
        if details.birthday != nil {
            Text("Born on \(details.birthday.formatDate)")
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
