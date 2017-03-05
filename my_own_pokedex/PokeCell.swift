//
//  PokeCell.swift
//  my_own_pokedex
//
//  Created by Khaled Rahman Ayon on 09/08/16.
//  Copyright © 2016 iosApp. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
