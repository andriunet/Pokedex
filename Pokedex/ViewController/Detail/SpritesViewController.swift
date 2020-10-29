//
//  SpritesViewController.swift
//  Pokedex
//
//  Created by Andres Marin on 29/10/20.
//

import UIKit
import JellyGif

class SpritesViewController: UIViewController {
    
    @IBOutlet weak var imagenFrontal: JellyGifImageView!
    @IBOutlet weak var imagenEspalda: JellyGifImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var nombrePokemon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nombre = nombrePokemon!.replacingOccurrences(of: "-", with: "_")

        let URLImagenFrontal = Pokedex.baseURLImagenSprites + "\(nombre).gif"
        let urlFontal = URL(string: URLImagenFrontal)!
        imagenFrontal.startGif(with: .localPath(urlFontal))


        let URLImagenEspalda = Pokedex.baseURLImagenSpritesEspalda + "\(nombre).gif"
        let urlEsplada = URL(string: URLImagenEspalda)!
        imagenEspalda.startGif(with: .localPath(urlEsplada))
        
    }

}

