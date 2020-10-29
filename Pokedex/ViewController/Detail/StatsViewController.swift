//
//  StatsViewController.swift
//  Pokedex
//
//  Created by Andres Marin on 29/10/20.
//

import UIKit
import LinearProgressView

class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewStats: UITableView!
    
    
    var detallePokemon: JsonDetallePokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableViewStats.delegate = self
        tableViewStats.dataSource = self
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableViewStats.isHidden = false
        self.tableViewStats.reloadData(efecto: .IzquierdaDerecha)
    }
    
    
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detalle = self.detallePokemon, let stats = detalle.stats {
            return stats.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell") as! StatsCell
          
        if let detalle = self.detallePokemon, let stats = detalle.stats {

            
            var nombreStat = stats[indexPath.row].stat?.name
            let stat = Float(stats[indexPath.row].base_stat ?? 0)
            
            cell.lblValorStats.text = "\(stats[indexPath.row].base_stat ?? 0)"
            
            switch stats[indexPath.row].stat?.name {
            case "hp":
                nombreStat = "HP"
                cell.imageStats.image = #imageLiteral(resourceName: "Hp")
            case "attack":
                nombreStat = "Ataque"
                cell.imageStats.image = #imageLiteral(resourceName: "Ataque")
            case "defense":
                nombreStat = "Defensa"
                cell.imageStats.image = #imageLiteral(resourceName: "Defensa")
            case "special-attack":
                nombreStat = "Ataque espec"
                cell.imageStats.image = #imageLiteral(resourceName: "AtaqueEspecial")
            case "special-defense":
                nombreStat = "Defensa espec"
                cell.imageStats.image = #imageLiteral(resourceName: "DefensaEspecial")
            case "speed":
                nombreStat = "Velocidad"
                cell.imageStats.image = #imageLiteral(resourceName: "Velocidad")
            default:
                nombreStat = stats[indexPath.row].stat?.name
            }
            
            cell.lblStats.text = nombreStat

            
            var colorStat = UIColor.blue
            
            switch stat {
            case 0..<50:
                colorStat = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            case 50..<100:
                colorStat = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            case 100..<150:
                colorStat = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            case 150..<200:
                colorStat = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            default:
                colorStat = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            }
                        
            let progressView = LinearProgressView()
            progressView.frame = CGRect(x: 0, y: 0, width: cell.progressBaseStat.frame.width, height: 10)
            progressView.maximumValue = 200
            progressView.barColor = UIColor.clear
            progressView.trackColor = colorStat
            progressView.setProgress(stat, animated: true)
            
            cell.progressBaseStat.addSubview(progressView)

        }
        
        return cell
    }
    
    
}
