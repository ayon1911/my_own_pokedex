//
//  Pokemon.swift
//  my_own_pokedex
//
//  Created by Khaled Rahman Ayon on 09/08/16.
//  Copyright © 2016 iosApp. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {

    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attackPwr: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    var description: String{
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defence: String{
        if _defence == nil {
            _defence = ""
        }
        return _defence
    }
    
    var height: String{
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attackPwr: String{
        if _attackPwr == nil {
            _attackPwr = ""
        }
        return _attackPwr
    }
    
    var nextevolutionId: String{
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionLvl: String{
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int){
    
        self._name = name
        self._pokedexID = pokedexID
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails (completed: DownloadCompleted) {
    
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attackPwr = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defence = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attackPwr)
                print(self._defence)
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                        
                }
                    else {
                        self._type = ""
                    }
                
                
                    print(self._type)
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                        if let url = descArr[0] ["resource_uri"]{
                            let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                                Alamofire.request(.GET, nsurl).responseJSON { response in
                                    let descResult = response.result
                                    if let descDict = descResult.value as? Dictionary<String,AnyObject> {
                                        
                                        if let description = descDict["description"] as? String{
                                            self._description = description
                                            print(self._description)
                                        }
                                    }
                                    
                                    completed()
                            }
                        }
                        
                    }else {
                        self._description = ""
    
                    }
                
                    if let evoloution = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evoloution.count > 0 {
                    
                        if let to = evoloution[0]["to"] as? String {
                            if to.rangeOfString("mega") == nil {
                                if let uri = evoloution[0]["resource_uri"] as? String {
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvolutionId = num
                                    self._nextEvolutionTxt = to
                                    
                                    if let lvl = evoloution[0]["level"] as? Int {
                                        self._nextEvolutionLvl = "\(lvl)"
                                    }
                                    
                                    print(self._nextEvolutionId)
                                    print(self._nextEvolutionTxt)
                                    print(self._nextEvolutionLvl)
                                    
                                }
                            }
                        }
                    }
                
                }
            
            }
        }
    }

