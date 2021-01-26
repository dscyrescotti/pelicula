//
//  PosterGridViewModel.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import Foundation

class PosterGridViewModel: ObservableObject {
    private let endpoint: String
    private var params: [String: Any]
    
    init(endpoint: String, params: [String: Any]) {
        self.endpoint = endpoint
        self.params = params
        self.fetchResults()
    }
    
    var page = 1
    var isFetching = false
    @Published var results = [Result]()
    
    func fetchResults() {
        if !isFetching {
            isFetching.toggle()
            params["page"] = page
            APIService.get(endpoint: endpoint, parameters: params) { [weak self] (list: ResultList) in
                self?.results.append(contentsOf: list.results)
            }
            isFetching.toggle()
        }
    }
}
