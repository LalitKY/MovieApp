//
//  NowPlayingMovieModal.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation

/// This load data fpr Now playing movie modal
struct NowPlayingMovieModal: Codable {
    var page: Int?
    var results: [MovieDetailModal]?
    var total_pages: Int?
    var total_results: Int?
}

struct MovieDetailModal: Codable {
    var id: Int?
    var original_title: String?
    var overview: String?
    var poster_path: String?
}
