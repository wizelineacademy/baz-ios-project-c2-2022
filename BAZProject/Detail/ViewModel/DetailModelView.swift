//
//  DetailModelView.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 25/10/22.
//

import Foundation

class DetailModelView {
    
    var dataArray: Movie?
    
    /// La funcion getImage retorna la informacion de una imagen
    /// - Parameter urlImage: String con la url de la imagen a descargar
    /// - Returns: La infotmacion de la imagen descargada de tipo Data
    func getImage(urlImage: String) -> Data {
        let urlIm = "https://image.tmdb.org/t/p/w500\(urlImage)"
        guard let urlData = URL(string: urlIm),
              let data = try? Data(contentsOf: urlData) else { return Data() }
        return data
    }
}
