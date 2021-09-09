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
        
        //pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let cordenadas = self.locationManeger.location?.coordinate {
                let notation = MKPointAnnotation()
                notation.coordinate = cordenadas
                
                let latAleatoria = (Double(arc4random_uniform(500)) - 250) / 100000.0
                let longAleatoria = (Double(arc4random_uniform(500)) - 250) / 100000.0
                
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

}

