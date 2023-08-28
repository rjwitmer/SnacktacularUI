//
//  Spot.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-24.
//

import Foundation
import FirebaseFirestoreSwift

struct Spot: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
    var latitude = 0.0
    var longtitude = 0.0
    
    var dictionary: [String: Any] {
        return ["name": name, "address": address, "latitude": latitude, "longtitude": longtitude]
    }
}
