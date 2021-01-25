//
//  HomeViewModel.swift
//  pelicula
//
//  Created by Dscyre Scotti on 25/01/2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var rows = [Row]()
    
    private let endpoints = ["movie/popular": "Popular Movies", "movie/top_rated": "Top Rated Movies", "movie/upcoming": "Upcoming", "movie/now_playing": "Now Playing", "tv/airing_today": "Airing Today", "tv/on_the_air": "On the Air", "tv/popular": "Popular TVs", "tv/top_rated": "Top Rated TVs"].shuffled()
    
    func fetchLists() {
        for (endpoint, title) in endpoints {
            APIService.get(endpoint: endpoint, parameters: [:]) { [unowned self] (list: ResultList) in
                self.rows.append(.init(title: title, list: list))
            }
        }
    }
    
    init() {
        self.fetchLists()
    }
    
    struct Row: Identifiable {
        let id = UUID()
        let title: String
        let list: ResultList
    }
}
