//
//  ViewController.swift
//  Pokemon Go
//
//  Created by Pedro Léda on 08/09/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: Properties
    var locationManeger = CLLocationManager()
    var count = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    // MARK: Outlets
    @IBOutlet weak var map: MKMapView!
    
    // MARK: Initialization
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        locationManeger.delegate = self
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()
        
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recoverAllPokemons()
        
        //pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let cordenadas = self.locationManeger.location?.coordinate {
                
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform(totalPokemons)
                
                let pokemon = self.pokemons[Int(indicePokemonAleatorio)]
                
                let notation = PokemonNotation(coordenadas: cordenadas,pokemon: pokemon)
                
                let latAleatoria = (Double(arc4random_uniform(400)) - 250) / 100000.0
                let longAleatoria = (Double(arc4random_uniform(400)) - 250) / 100000.0
                
                notation.coordinate.latitude += latAleatoria
                notation.coordinate.longitude += longAleatoria
                
                self.map.addAnnotation(notation)
            }
        }
    }
    
    // MARK: Actions
    @IBAction func centerPlayer(_ sender: Any) {
        self.center()
    }
    
    @IBAction func openPokedex(_ sender: Any) {
    }
    
    
    // MARK: Methods
    
    func center() {
        if let coordinate = locationManeger.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 200,
                                            longitudinalMeters: 200)
            map.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.center()
        if count < 3 {
            count += 1
        }else{
            locationManeger.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            let alertController = UIAlertController(title: "Permissão de Autorização",
                                                    message: "Para que você possa caçar pokemons, precisamos da sua localização",
                                                    preferredStyle: .alert)
            let configurationsAction = UIAlertAction(title: "Abrir configurações", style: .default, handler: {
                (configurationAlert) in
                if let configuration = NSURL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(configuration as URL)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(configurationsAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let notationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
      
        
        notationView.image = UIImage(named: "pikachu-2")
        
        if annotation is MKUserLocation {
            notationView.image = UIImage(named: "player")
        }else{
            let pokemon = (annotation as! PokemonNotation).pokemon
            notationView.image = UIImage(named: pokemon.nomeImagem!)
        }
        
        var frame = notationView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        notationView.frame = frame
        
        return notationView
    }
}

