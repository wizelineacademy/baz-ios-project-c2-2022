//
//  MovieEndpoint.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 27/10/22.
//

import Foundation

enum MovieEndpoint: String, CaseIterable {
    case Trending = "Trending Movies"
    case NowPlaying = "Now Playing Movies"
    case Popular = "Popular Movies"
    case TopRated = "Top Rated Movies"
    case Upcoming = "Upcoming Movies"
}
