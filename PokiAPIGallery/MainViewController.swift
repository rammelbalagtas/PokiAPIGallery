//
//  ViewController.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let pokemons = [Pokemon]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pokeimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign view controller as delegate for the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        PokeAPIHelper.fetchAllImages { images in
            self.pokeimage.image = images.first!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }


}

