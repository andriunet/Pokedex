//
//  Constantes.swift
//  Pokedex
//
//  Created by Andres Marin on 28/10/20.
//

import Foundation

struct Pokedex {
    static let baseURL = "https://pokeapi.co/api/v2"
    static let baseURLImagen = "https://www.pkparaiso.com/imagenes/xy/sprites/animados/"
    static let baseURLImagenOfficial = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    static let baseURLImagenSprites = "https://www.pkparaiso.com/imagenes/xy/sprites/animados/"
    static let baseURLImagenSpritesEspalda = "https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/"

    
}

struct Endpoint {
    static let listaPokemones = "/pokemon/?limit=500"
}
