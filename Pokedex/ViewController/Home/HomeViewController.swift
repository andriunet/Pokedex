//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Andres Marin on 28/10/20.
//

import UIKit
import Alamofire

class HomeViewController: UITableViewController, UISearchBarDelegate {
        
    var Pokemones : [JsonListPokemones]?
    var FiltroPokemones : [JsonListPokemones]?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarPokemones()
    }

    // MARK: - Funciones
    
    private func cargarPokemones() {
        
        AF.request(Pokedex.baseURL + Endpoint.listaPokemones, method: .get, encoding: JSONEncoding.default).responseString { response in

            switch response.result {
               case .success(let value) :
                                
                if let json = JsonPokemones.deserialize(from: value) {
                    
                    self.Pokemones = json.results
                    self.FiltroPokemones = json.results
                    
                    self.tableView.reloadData(efecto: .Roll)
                }
                
               case .failure(let error) :
                   let error = error as Error
                   print(error.localizedDescription)
               }
        }
        
    }
    
    
    //MARK: - TableView
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pokemon = self.FiltroPokemones {
            return pokemon.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as! PokemonCell
          
        if let pokemon = self.FiltroPokemones {

            cell.lblNombre.text = pokemon[indexPath.row].name
            
            let idPokemon = pokemon[indexPath.row].url!.components(separatedBy: "/").filter({!$0.isEmpty})
            let URLImagen = Pokedex.baseURLImagenOfficial + "\(idPokemon[idPokemon.endIndex - 1]).png"
            
            //let URLImagen = Pokedex.baseURLImagen + "\(pokemon[indexPath.row].name!.replacingOccurrences(of: "-", with: "_")).gif"

            //Buscamos la imagen en la cache sino se descargara
            if let image = self.appDelegate.imageCache.object(forKey: URLImagen as AnyObject) as? UIImage {
                cell.imagenPokemon.imageView.image = image
            } else {
                _ = cell.imagenPokemon.downloadImage(URL(string: URLImagen)!, placeholder: nil)
            }

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "detalleSegue", sender: indexPath)
        
    }
    
    
    //MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Si no hay filtracion ponemos el filtro con los datos de todos
        if searchBar.text! == "" {
            FiltroPokemones = Pokemones!
        } else {
            // Hacemos la filtracion
            FiltroPokemones = Pokemones!.filter { $0.name!.range(of: searchBar.text!, options: [.diacriticInsensitive, .caseInsensitive]) != nil}
        }
        
        self.tableView.reloadData()

    }
    
    // MARK: - Prepare
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "detalleSegue" {
            
            let detalleViewController = segue.destination as! DetailViewController
            
            //Enviamos la transaccion seleccionada
            if let index = sender as? IndexPath {
                
                if let pokemones = self.FiltroPokemones {
                                    
                    detalleViewController.nombrePokemon = pokemones[index.row].name
                    detalleViewController.urlDetalle = pokemones[index.row].url
                             
                }
                
            }
            
        }
            
    }
    
}

