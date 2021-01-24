//
//  Image.swift
//  pelicula
//
//  Created by Dscyre Scotti on 24/01/2021.
//

import SwiftUI
import Kingfisher

struct Image: View {
    
    let url: String
    let width: CGFloat
    let height: CGFloat
    let shadow: CGFloat
    let radius: CGFloat
    
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                ZStack {
                    Color.red
                    ProgressView()
                }
            }
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height, alignment: .center)
            .clipped()
            .cornerRadius(radius)
            .shadow(radius: shadow)
    }
    
    init(url: String, width: CGFloat = 90, height: CGFloat = 160, shadow: CGFloat = 2, radius: CGFloat = 10) {
        self.url = url
        self.width = width
        self.height = height
        self.shadow = shadow
        self.radius = radius
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        Image(url: "https://images.unsplash.com/photo-1610902417620-dcae662b997d?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")
            .previewLayout(.sizeThatFits)
    }
}
