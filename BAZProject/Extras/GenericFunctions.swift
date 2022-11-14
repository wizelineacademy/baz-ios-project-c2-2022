//
//  PublicFunction.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 14/11/22.
//

import UIKit

final class GenericFunctions {
    /// La funcion getImage retorna la informacion de una imagen
    /// - Parameter urlImage: String con la url de la imagen a descargar
    /// - Returns: La infotmacion de la imagen descargada de tipo Data
    static func getImage(urlImage: String) -> Data {
        let urlIm = "https://image.tmdb.org/t/p/w500\(urlImage)"
        guard let urlData = URL(string: urlIm),
              let data = try? Data(contentsOf: urlData) else { return Data() }
        return data
    }
    /// La funcion sendAlert envia una alrte con un titulo en especifico y con un mensaje que se mandan en sus parametros
    /// - Parameter title: Titulo que se le asigna en la alerta
    /// - Parameter message: Mensaje que se le asigna en la alerta
    /// - Returns: La alerta con los datos mandados en las parametros
    static func sendAlert(_ title: String,_ message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}


