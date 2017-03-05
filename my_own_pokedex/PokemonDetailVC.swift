//
//  PokemonDetailVC.swift
//  my_own_pokedex
//
//  Created by Khaled Rahman Ayon on 10/08/16.
//  Copyright © 2016 iosApp. All rights reserved.
//

import UIKit
//import Alamofire

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defencelbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var pokeIdLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var baseAttackLbl: UILabel!
    @IBOutlet var nextEvolutionLbl: UILabel!
    @IBOutlet var currentEvoImg: UIImageView!
    @IBOutlet var nextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var img = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name
        mainImg.image = img
        currentEvoImg.image = img
        
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defencelbl.text = pokemon.defence
        heightLbl.text = pokemon.height
        pokeIdLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attackPwr
        
        if pokemon.nextevolutionId == "" {
            nextEvolutionLbl.text = "No Evolution!!"
            nextEvoImg.hidden = true
        }else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: "\(pokemon.nextevolutionId)")
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
//            nextEvolutionLbl.text = str + " \(pokemon.nextEvolutionLvl)"
            
            if pokemon.nextEvolutionLvl == "" {
                str += " -LVl \(pokemon.nextEvolutionLvl)"
            }
        }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
