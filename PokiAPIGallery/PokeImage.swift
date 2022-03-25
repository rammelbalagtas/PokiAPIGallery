//
//  PokeImage.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import Foundation

struct Pokemons: Codable{
    var results: [Pokemon]
}

struct Pokemon: Codable{
    var url: String
}

struct PokeImage: Codable{
    var sprites: Sprite!
}

struct Sprite: Codable{
    var front_default: String
}
