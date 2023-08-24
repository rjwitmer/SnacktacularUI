//
//  SpotViewModel.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-24.
//

import Foundation
import FirebaseFirestore

class SpotViewModel: ObservableObject {
    @Published var spot = Spot()
    let collectionName = "spots"
    
    func saveSpot(spot: Spot) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = spot.id {   // spot already exists, so save
            do {
                try await db.collection(collectionName).document(id).setData(spot.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in '\(collectionName)' --> \(error.localizedDescription)")
                return false
            }
        } else {    // There is no id so this must be a new spot to add
            do {
                try await db.collection(collectionName).addDocument(data: spot.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new spot in '\(collectionName)' --> \(error.localizedDescription)")
                return false
            }
        }
    }
}
