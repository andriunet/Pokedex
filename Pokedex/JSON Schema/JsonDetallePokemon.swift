//
//  JsonDetallePokemon.swift
//  Pokedex
//
//  Created by Andres Marin on 28/10/20.
//

import Foundation
import HandyJSON

class JsonDetallePokemon: HandyJSON {
    
    var id: Int?
    var name: String?
    var weight: String?
    var height: String?
    var order: Int?
    var base_experience: Int?
    var sprites: JsonPokemonSprites?
    var stats: [JsonPokemonStats]?
    
    required init() {}
}


// MARK: - Stats

class JsonPokemonStats: HandyJSON {
    var base_stat: Int?
    var effort: Int?
    var stat: JsonPokemonStat?
    
    required init() {}
}

class JsonPokemonStat: HandyJSON {
    var name: String?
    var url: String?
    
    required init() {}
}


// MARK: - Sprites

class JsonPokemonSprites: HandyJSON {
    var back_default: String?
    var back_shiny: String?
    var front_default: String?
    var front_shiny: String?
    var back_female: String?
    var back_shiny_female: String?
    var front_female: String?
    var front_shiny_female: String?
    
    var other: JsonSpritesOther?
    
    required init() {}
}

class JsonSpritesOther: HandyJSON {
    var dream_world: JsonSpritesDreamWorld?
    required init() {}
}

class JsonSpritesDreamWorld: HandyJSON {
    var front_default: String?
    var front_female: String?
    
    required init() {}
}



