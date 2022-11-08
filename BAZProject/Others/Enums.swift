//
//  Enums.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 03/11/22.
//

enum CategoryFilterMovie: Int {
    case nowPlaying = 0
    case polular = 1
    case topRated = 2
    case upcoming = 3
    
    var title: String {
        switch self {
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
