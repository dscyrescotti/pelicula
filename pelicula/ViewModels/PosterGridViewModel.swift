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
    let type: RowType
    
    init(endpoint: String, params: [String: Any], type: RowType) {
        self.endpoint = endpoint
        self.params = params
        self.type = type
        self.fetchResults()
    }
    
    var page = 1
    var isFetching = false
    @Published var isEnd = false
    @Published var results = [Result]()
    
    func fetchResults() {
        if !isFetching {
            isFetching.toggle()
            if type == .media {
                params["page"] = page
                APIService.get(endpoint: endpoint, parameters: params) { [weak self] (list: ResultList) in
                    self?.isEnd = list.page >= list.totalPages
                    self?.results.append(contentsOf: list.results)
                    self?.page += 1
                }
            } else if type == .cast {
                APIService.get(endpoint: endpoint, parameters: params) { [weak self] (credits: MediaCredit) in
                    self?.isEnd = true
                    self?.results = credits.results
                }
            } else if type == .credit {
                APIService.get(endpoint: endpoint, parameters: params) { [weak self] (combined: CombinedCredit) in
                    self?.isEnd = true
                    self?.results = combined.cast
                }
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

enum RowType {
    case media, cast, credit
}
