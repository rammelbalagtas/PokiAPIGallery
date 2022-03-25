//
//  ViewController.swift
//  PokiAPIGallery
//
//  Created by Cambrian on 2022-03-21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokeimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PokeAPIHelper.fetchAllImages { images in
            self.pokeimage.image = images.first!
        }
    }


}

