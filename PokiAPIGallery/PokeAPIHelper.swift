//
//  PokeAPIHelper.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import Foundation
import UIKit

class PokeAPIHelper {
    static private let baseURL = "https://pokeapi.co/api/v2/pokemon?limit=151"
    
    static private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static private func fetchURLs(callback: @escaping ([URL])->Void){
        guard let url = URL(string: baseURL)
        else {return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let data = data {
                let decoder = JSONDecoder()
                do{
                    let pokemons = try decoder.decode(Pokemons.self, from: data)
                    var urls = [URL]()
                    
                    
                    for pokemon in pokemons.results{
                        urls.append(URL(string: pokemon.url)!)
                    }
                    callback(urls)
                    
                } catch let err {
                    print(err)
                }
            } else if let error = error {
                print(error)
            }
        }
        task.resume()
    }
    
    static func fetchPokeImageURL(callback: @escaping ([URL])->Void){
        var imageURLs = [URL]()
        let group = DispatchGroup()
        fetchURLs { urls in
            for url in urls {
                let request = URLRequest(url: url)
                group.enter()
                let task = session.dataTask(with: request) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        do{
                            let pokemon = try decoder.decode(PokeImage.self, from: data)
                            imageURLs.append(URL(string: pokemon.sprites.front_default)!)
                        } catch let err {
                            print(err)
                        }
                    }
                    group.leave()
                }
                task.resume()
            }
            group.notify(queue: .main){
                print(imageURLs)
                callback(imageURLs)
            }
        }
    }
    
    static func fetchPokeImage(pokeImage: URL, callback: @escaping (UIImage)->Void){
        let request = URLRequest(url: pokeImage)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                callback(UIImage(data: data)!)
            }
        }
        task.resume()
    }
    
    static func fetchAllImages(callback: @escaping ([UIImage])->Void){
        fetchPokeImageURL{ urls in
            let group = DispatchGroup()
            var images = [UIImage]()
            for url in urls {
                group.enter()
                fetchPokeImage(pokeImage: url) { image in
                    images.append(image)
                    group.leave()
                }
            }
            group.notify(queue: .main){
                callback(images)
            }
        }

    }
}
