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
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
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
        
        self.latitudeLabel.text = String(userLocation.coordinate.latitude)

        self.longitudeLabel.text = String(userLocation.coordinate.longitude)
        
        self.courseLabel.text = String(userLocation.course)
        
        self.speedLabel.text = String(userLocation.speed)
        
        self.altitudeLabel.text = String(userLocation.altitude)

        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                print(error)
            } else {
                if let placemark = placemarks?[0] {
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.locality != nil {
                        
                        address += placemark.locality! + "\n"
                    }
                    
                    if placemark.administrativeArea != nil {
                        
                        address += placemark.administrativeArea! + "\n"
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country! + "\n"
                    }
                    
                    self.addressLabel.text = address
                }
            }
            
/*       -----------------------------------------------
             ***** Center Map on the Current Location *****
         -----------------------------------------------
*/
            let latitude: CLLocationDegrees = userLocation.coordinate.latitude
            
            let longitude: CLLocationDegrees = userLocation.coordinate.longitude
            
            let latDelta: CLLocationDegrees = 0.05
            
            let longDelta: CLLocationDegrees = 0.05
            
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            // let span: MKCoordinateSpanMake(latDelta, longDelta)  --> shortcut don't need to specify type
            
            let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
            
            self.map.setRegion(region, animated: true)
        }
        
        
        
        
/*       ------------------------------------------------------------------
         ***** 1st look at CLGeocoder + definitions of each .property *****
         ------------------------------------------------------------------
         
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
*/
    }
    
}

