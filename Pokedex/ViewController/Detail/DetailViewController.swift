//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Andres Marin on 28/10/20.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var imagenView: LoadingImageView!
    
    var nombrePokemon: String?
    var urlDetalle: String?
    
    var detallePokemon: JsonDetallePokemon?
    
    var tabBar: UITabBarController?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = viewColor.frame
        shapeLayer.position = viewColor.center
        shapeLayer.path = UIBezierPath(roundedRect: viewColor.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 100, height: 100)).cgPath
        viewColor.layer.mask = shapeLayer
                
        lblNombre.text = nombrePokemon
        
        if let url = urlDetalle {
            cargarDetallePokemon(urlDetalle: url)
        }
        
    }
    
    
    // MARK: - Funciones
    
    private func cargarDetallePokemon(urlDetalle: String) {
        
        AF.request(urlDetalle, method: .get, encoding: JSONEncoding.default).responseString { response in

            switch response.result {
               case .success(let value) :
                                
                if let json = JsonDetallePokemon.deserialize(from: value) {
                    
                    self.detallePokemon = json
                    
                    self.performSegue(withIdentifier: "EmbedDetallesSegue", sender: nil)
                    
                    if let detalle = self.detallePokemon {
                        
                        let URLImagen = Pokedex.baseURLImagenOfficial + "\(detalle.id!).png"
                        
                        //Buscamos la imagen en la cache sino se descargara
                        if let image = self.appDelegate.imageCache.object(forKey: URLImagen as AnyObject) as? UIImage {
                            self.imagenView.imageView.image = image
                        } else {
                            _ = self.imagenView.downloadImage(URL(string: URLImagen)!, placeholder: nil)
                        }
                        
                    }
                    
                }
                
               case .failure(let error) :
                   let error = error as Error
                   print(error.localizedDescription)
               }
        }
        
    }
    
    
    // MARK: - Prepare
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if self.detallePokemon == nil {
            return false
        } else {
            return true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "EmbedDetallesSegue" {
            
            if let viewControllerNavigation = segue.destination as? UITabBarController {
                
                tabBar = viewControllerNavigation
                        
                if let statsViewController = viewControllerNavigation.children[0] as? StatsViewController {
                    statsViewController.detallePokemon = self.detallePokemon
                }
                
                if let spritesViewController = viewControllerNavigation.children[1] as? SpritesViewController {
                    spritesViewController.nombrePokemon = self.nombrePokemon
                }
                
                
            }
            
        }
        
    }
    
}

