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
    }
    
    // MARK: Actions
    
    // MARK: Methods
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

