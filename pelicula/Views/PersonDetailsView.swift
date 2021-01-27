//
//  PersonDetailsView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import SwiftUI
import Kingfisher

struct PersonDetailsView: View {
    @StateObject var viewModel: PersonDetailsViewModel
    init(id: Int, type: Results) {
        self._viewModel = StateObject(wrappedValue: PersonDetailsViewModel(id: id, type: type))
    }
    var body: some View {
        Group {
            if let details = viewModel.details {
                GeometryReader { reader in
                    ScrollView {
                        avatar(details.profilePath ?? "")
                        Text(details.name)
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
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
}

struct CastDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(id: 550843, type: .person)
    }
}
