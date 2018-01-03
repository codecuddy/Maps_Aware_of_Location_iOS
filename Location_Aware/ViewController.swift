//
//  ViewController.swift
//  Location_Aware
//
//  Created by Charlie Cuddy on 12/31/17.
//  Copyright © 2017 Charlie Cuddy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let userLocation: CLLocation = locations[0]

        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    //subThoroughfare --> the number address
                    var subThoroughfare = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        subThoroughfare = placemark.subThoroughfare!
                        
                    }
                    
                    //thoroughfare --> the street name
                    var thoroughfare = ""
                    
                    if placemark.thoroughfare != nil {
                        
                        thoroughfare = placemark.thoroughfare!
                    }
                    
                    // locality --> the city
                    var locality = ""
                    
                    if placemark.locality != nil {
                        
                        locality = placemark.locality!
                    }

                    // subLocality --> the 'neighborhood' ??
                    var subLocality = ""
                    
                    if placemark.subLocality != nil {
                        
                        subLocality = placemark.subLocality!
                    }
                    
                    // subAdministritiveArea --> the county
                    var subAdministritiveArea = ""
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        subAdministritiveArea = placemark.subAdministrativeArea!
                    }
                    
                    // administritiveArea --> the state
                    var administritiveArea = ""
                    
                    if placemark.administrativeArea != nil {
                        
                        administritiveArea = placemark.administrativeArea!
                    }
                    
                    // postalCode --> the area code
                    var postalCode = ""
                    
                    if placemark.postalCode != nil {
                        
                        postalCode = placemark.postalCode!
                    }

                    // country --> the country
                    var country = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                    }
                    
                    print(subThoroughfare + " " + thoroughfare + " (Neighborhood: \(subLocality))" + "\n" + locality + " (County: \(subAdministritiveArea))" + "\n" + administritiveArea + " " + postalCode + "\n" + country)
                }
                
            }
            
        }
    }
    
}

