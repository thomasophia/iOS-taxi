//
//  ViewController.swift
//  TaxiWien
//
//  Created by Sophia Thoma on 11.05.22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var taxiStands: [TaxiStand] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        let initialLocation = CLLocation(latitude: 48.208174, longitude: 16.373819)
        mapView.centerToLocation(initialLocation)
        let viennaCenter = CLLocation(latitude: 48.208174, longitude: 16.373819)
        let region = MKCoordinateRegion(
            center: viennaCenter.coordinate,
            latitudinalMeters: 400,
            longitudinalMeters: 400)
        
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 150000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        mapView.delegate = self
        mapView.register(TaxiStandMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        mapView.addAnnotations(taxiStands)
    }
    
    
    @IBAction func switchSatellite(_ sender: UISwitch) {
        if sender.isOn {
            self.mapView.mapType = .satellite
        } else {
            self.mapView.mapType = .standard
        }
    }
    
    
    private func loadInitialData(){
        guard
            let fileName = Bundle.main.url(forResource: "TAXIOGD", withExtension: "json"),
            let taxiStandData = try? Data(contentsOf: fileName)
        else {
            return
        }
        
        do {
            
            let features = try MKGeoJSONDecoder()
                .decode(taxiStandData)
                .compactMap{ $0 as? MKGeoJSONFeature}
            
            let validWorks = features.compactMap(TaxiStand.init)
            
            taxiStands.append(contentsOf: validWorks)
        } catch {
            
            print("Error")
        }
    }
    
}


private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion (
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let taxiStand = view.annotation as? TaxiStand else {
            return
        }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        taxiStand.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}


