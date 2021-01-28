//
//  HomeViewModel.swift
//  pelicula
//
//  Created by Dscyre Scotti on 25/01/2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var rows = [Row]()
    
    private let endpoints: [Endpoint] = [.init(name: "movie/popular", title: "Popular Movies"), .init(name: "movie/top_rated", title: "Top Rated Movies"), .init(name: "movie/upcoming", title: "Upcoming"), .init(name: "movie/now_playing", title: "Now Playing"), .init(name: "tv/airing_today", title: "Airing Today"), .init(name: "tv/on_the_air", title: "On the Air"), .init(name: "tv/popular", title: "Popular TVs"), .init(name: "tv/top_rated", title: "Top Rated TVs"), .init(name: "trending/all/week", title: "Trending")].shuffled()
    
    func fetchLists() {
        for endpoint in endpoints {
            APIService.get(endpoint: endpoint.name, parameters: endpoint.parameters) { [weak self] (list: ResultList) in
                self?.rows.append(.init(title: endpoint.title, list: list, endpoint: endpoint.name, parameters: endpoint.parameters))
            }
        }
    }
    
    init() {
        self.fetchLists()
    }
    
    private struct Endpoint {
        let name: String
        let title: String
        let parameters: [String: Any] = [:]
    }
    
    struct Row: Identifiable {
        let id = UUID()
        let title: String
        let list: ResultList
        let endpoint: String
        let parameters: [String: Any]
    }
}
