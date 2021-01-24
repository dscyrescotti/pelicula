//
//  PosterImage.swift
//  pelicula
//
//  Created by Dscyre Scotti on 24/01/2021.
//

import SwiftUI

struct PosterImage: View {
    let result: Result
    let width: CGFloat = 100
    let height: CGFloat = 160
    var body: some View {
        VStack(alignment: .leading) {
            Image(url: result.image, width: width, height: height, shadow: 5)
            VStack(alignment: .leading) {
                Text(result.title)
                    .font(.headline)
                    .lineLimit(2)
                if let subTitle = result.subTitle {
                    Text(subTitle)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
            .frame(minHeight: height * 0.4, alignment: .top)
        }
        .frame(width: width)
        
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(result: .init(id: 1, title: "The Wilds", subTitle: "(2020)", image: "https://www.themoviedb.org/t/p/w1280/gHBtyMdHbWoM3tpM8VZymer8HfF.jpg", type: .tv))
    }
}
