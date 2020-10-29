//
//  JsonPokemones.swift
//  Pokedex
//
//  Created by Andres Marin on 28/10/20.
//

import Foundation
import HandyJSON

class JsonPokemones: HandyJSON {
    var count: Int?
    var next: String?
    var results: [JsonListPokemones]?
    
    required init() {}
}

class JsonListPokemones: HandyJSON {
    var name: String?
    var url: String?
    
    required init() {}
}
