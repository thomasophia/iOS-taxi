//
//  TaxiStand.swift
//  TaxiWien
//
//  Created by Sophia Thoma on 11.05.22.
//

import Foundation
import MapKit
import Contacts

class TaxiStand: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let numberTaxiStands: Int?
    
    
    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first,
            let propertiesData = feature.properties,
            
                let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
                
        else {
            return nil
        }
        coordinate = point.coordinate
        title = properties["ADRESSE"] as? String
        numberTaxiStands = properties["STELLPLATZANZAHL"] as? Int
        subtitle = "Taxistand Nr. " + String(properties["OBJECTID"] as! Int) + " / Stellplätze: " + String(properties["STELLPLATZANZAHL"] as? Int ?? 1)
        
        super.init()
    }
    
    var mapItem: MKMapItem? {
        guard let location = title else {
            return nil
        }
        let adressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: adressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    
    
    var markerColor: UIColor {
        switch numberTaxiStands {
        case 1:
            return UIColor(named: "LightBlue1")!
        case 2:
            return UIColor(named: "LightBlue2")!
        case 3:
            return UIColor(named: "LightBlue3")!
        case 4:
            return UIColor(named: "LightBlue4")!
        case 5:
            return UIColor(named: "burlywood1")!
        case 6:
            return UIColor(named: "burlywood2")!
        case 7:
            return UIColor(named: "burlywood3")!
        case 8:
            return UIColor(named: "burlywood4")!
        case 9:
            return UIColor(named: "tan1")!
        case 10:
            return UIColor(named: "tan2")!
        case 11:
            return UIColor(named: "tan3")!
        case 12:
            return UIColor(named: "tan4")!
        case 13:
            return UIColor(named: "olive1")!
        case 14:
            return UIColor(named: "olive2")!
        case 15:
            return UIColor(named: "olive3")!
        default:
            return .white
        }
    }
    
    
}
