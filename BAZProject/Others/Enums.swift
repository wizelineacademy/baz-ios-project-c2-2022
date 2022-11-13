//
//  Enums.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 03/11/22.
//

enum CategoryFilterMovie: Int {
    case trending = 0
    case nowPlaying = 1
    case polular = 2
    case topRated = 3
    case upcoming = 4
    
    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .polular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    var codeUrl: String {
        switch self {
        case .trending:
            return ""
        case .nowPlaying:
            return "now_playing"
        case .polular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
}

enum APIError: Error {
    case urlError
    case decodeError
    case arrayEmpty
    
    var titleError: String {
        switch self {
        case .urlError:
            return "Algo salio mal"
        case .decodeError:
            return "¡Ups!"
        case .arrayEmpty:
            return "Sin datos"
        }
    }
    
    var descriptionError: String {
        switch self {
        case .urlError:
            return "Error en la URL, favor de verificar"
        case .decodeError:
            return "Error al guardar la información"
        case .arrayEmpty:
            return "No hay peliculas para mostrar"
        }
    }
}
