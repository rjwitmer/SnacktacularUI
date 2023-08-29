//
//  Place.swift
//  PlaceLookupDemo
//
//  Created by Bob Witmer on 2023-08-26.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID().uuidString
    private var mapItem: MKMapItem
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    var name: String {
        self.mapItem.name ?? ""
        
    }
    
    var address: String {
        let placemark = self.mapItem.placemark
        var cityAndState = ""
        var address = ""
        
        cityAndState = placemark.locality ?? ""     // City
        if let state = placemark.administrativeArea {
            // Show either State or City, State
            cityAndState = cityAndState.isEmpty ? state : "\(cityAndState), \(state)"
        }
        
        address = placemark.subThoroughfare ?? ""   // Street Address Number
        if let street = placemark.thoroughfare {
            // Show either Street or # and Street
            address = address.isEmpty ? street : "\(address) \(street)"
        }
        
        if address.trimmingCharacters(in: .whitespaces).isEmpty && !cityAndState.isEmpty { // No address, then City and State with no space
            address = cityAndState
        } else {
            // No cityAndState, then just Address otherwise address, cityAndState
            address = cityAndState.isEmpty ? address : "\(address), \(cityAndState)"
        }
        
        return address
    }
    
    var latitude: CLLocationDegrees {
        self.mapItem.placemark.coordinate.latitude
    }
    
    var longtitude: CLLocationDegrees {
        self.mapItem.placemark.coordinate.longitude
    }
}
