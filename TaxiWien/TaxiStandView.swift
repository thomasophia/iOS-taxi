//
//  TaxiStandView.swift
//  TaxiWien
//
//  Created by Sophia Thoma on 12.05.22.
//

import Foundation
import MapKit

class TaxiStandMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let taxiStand = newValue as? TaxiStand else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = taxiStand.markerColor
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = taxiStand.title
            detailLabel.text = taxiStand.subtitle
            
        }
    }
}
