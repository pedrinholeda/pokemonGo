//
//  PokemonNotation.swift
//  Pokemon Go
//
//  Created by Pedro Léda on 09/09/21.
//

import UIKit
import MapKit

class PokemonNotation: NSObject, MKAnnotation {
    
    // MARK: Properties
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    // MARK: Outlets
    
    // MARK: Initialization
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
    // MARK: Overrides
    
    // MARK: Actions
    
    // MARK: Methods

}
