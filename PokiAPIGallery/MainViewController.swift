//
//  ViewController.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var pokeImagesList = [UIImage]()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign view controller as delegate for the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        
        PokeAPIHelper.fetchAllImages { images in
            self.pokeImagesList = images
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokeImagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemon", for: indexPath) as? PokemonCollectionViewCell
        else{fatalError()}
        cell.pokeImage.image = pokeImagesList[indexPath.row]
        return cell
    }


}

