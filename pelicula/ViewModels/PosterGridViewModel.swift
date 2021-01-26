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
    @Published var isEnd = false
    @Published var results = [Result]()
    
    func fetchResults() {
        if !isFetching {
//            print("[Grid]: Fetching data for page \(page)")
            isFetching.toggle()
            params["page"] = page
            APIService.get(endpoint: endpoint, parameters: params) { [weak self] (list: ResultList) in
                self?.isEnd = list.page >= list.totalPages
                self?.results.append(contentsOf: list.results)
                self?.page += 1
            }
            isFetching.toggle()
        }
    }
    
    func next(result: Result) {
        if results.count >= 4, result == results[results.count - 3] {
            fetchResults()
        }
    }
}
