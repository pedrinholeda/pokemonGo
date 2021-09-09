//
//  CoreDataPokemon.swift
//  Pokemon Go
//
//  Created by Pedro Léda on 09/09/21.
//

import UIKit
import CoreData

class CoreDataPokemon {
    // MARK: Properties
    
    // MARK: Outlets
    
    // MARK: Initialization
    
    // MARK: Overrides
    
    // MARK: Actions
    
    // MARK: Methods
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func addAllPokemons() {
        let context = self.getContext()
        
        self.createPokemon(nome: "Mew", nomeImage: "mew", capturado: false)
        self.createPokemon(nome: "Meowth", nomeImage: "meowth", capturado: false)
        self.createPokemon(nome: "Pikachu", nomeImage: "pikachu-2", capturado: true)
        self.createPokemon(nome: "Squirtle", nomeImage: "squirtle", capturado: false)
        self.createPokemon(nome: "Charmander", nomeImage: "charmander", capturado: false)
        self.createPokemon(nome: "Bullbasaur", nomeImage: "Bullbasaur", capturado: false)
        self.createPokemon(nome: "Bellsprout", nomeImage: "bellsprout", capturado: false)
        self.createPokemon(nome: "Psyduck", nomeImage: "psyduck", capturado: false)
        self.createPokemon(nome: "Rattata", nomeImage: "rattata", capturado: false)
        self.createPokemon(nome: "Snorlax", nomeImage: "snorlax", capturado: false)
        self.createPokemon(nome: "Zubat", nomeImage: "zubat", capturado: false)
        
        do{
            try context.save()
        }catch{}
    }
    
    func createPokemon(nome: String, nomeImage: String, capturado: Bool) {
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImage
        pokemon.capturado = capturado
    }
    
    func recoverAllPokemons() -> [Pokemon] {
        let context = self.getContext()
        
        do{
            let pokemons =  try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.addAllPokemons()
                return self.recoverAllPokemons()
            }
            return pokemons
        } catch {}
        return[]
    }
}

