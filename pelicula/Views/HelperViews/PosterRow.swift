//
//  PosterRow.swift
//  pelicula
//
//  Created by Dscyre Scotti on 24/01/2021.
//

import SwiftUI

struct PosterRow: View {
    let results: [Result]
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Title")
                        .font(.title3)
                        .bold()
                }.padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 13) {
                        ForEach(results) { result in
                            PosterImage(result: result)
                        }
                    }
                    .padding(.horizontal, 13)
                    .padding(.top, 10)
                }
            }
            .background(Color.red)
        }
    }
}

struct PosterRow_Previews: PreviewProvider {
    static var previews: some View {
        PosterRow(results: [.init(id: 1, title: "The Wilds", subTitle: "(2020)", image: "https://www.themoviedb.org/t/p/w1280/gHBtyMdHbWoM3tpM8VZymer8HfF.jpg", type: .tv), .init(id: 2, title: "Birds", subTitle: "(2020)", image: "https://www.themoviedb.org/t/p/w1280/odXDkjR5DoumqCrGmTQ2n4So2Yc.jpg", type: .movie), .init(id: 3, title: "Wanda", subTitle: "(2021)", image: "https://www.themoviedb.org/t/p/w1280/glKDfE6btIRcVB5zrjspRIs4r52.jpg", type: .tv), .init(id: 4, title: "Fate", subTitle: "(2021)", image: "https://www.themoviedb.org/t/p/w1280/oHj6guMrLfQcBzo3uxwBJc8Y736.jpg", type: .tv), .init(id: 5, title: "Fate: The Winx Saga", subTitle: "(2021)", image: "https://www.themoviedb.org/t/p/w1280/oHj6guMrLfQcBzo3uxwBJc8Y736.jpg", type: .tv)])
    }
}
