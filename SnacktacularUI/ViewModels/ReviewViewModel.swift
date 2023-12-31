//
//  ReviewViewModel.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-29.
//

import Foundation
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    @Published var review = Review()
    let collectionName = "spots"
    let subCollectionName = "reviews"

    
    func saveReview(spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        guard let spotID = spot.id else {
            print("😡 ERROR: spot.id = nil")
            return false
        }
        
        let collectionString = "\(collectionName)/\(spotID)/\(subCollectionName)"
        
        if let id = review.id {   // review already exists, so save
            do {
                try await db.collection(collectionString).document(id).setData(review.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in '\(collectionString)' --> \(error.localizedDescription)")
                return false
            }
        } else {    // There is no id so this must be a new review to add
            do {
                try await db.collection(collectionString).addDocument(data: review.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new review in '\(collectionString)' --> \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteReview(spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        guard let spotID = spot.id, let reviewID = review.id else {
            print("😡 ERROR: spot.id = \(spot.id ?? "nil") review.id = \(review.id ?? "nil"). This should not have happened.")
            return false
        }
        
        do {
            let _ = try await db.collection(collectionName).document(spotID).collection(subCollectionName).document(reviewID).delete()
            print("🗑️ Review document successfully deleted!")
            return true
        } catch {
            print("😡 ERROR: Could not delete review document --> \(error.localizedDescription)")
            return false
        }
    }
    
}
