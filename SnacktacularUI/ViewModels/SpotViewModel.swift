//
//  SpotViewModel.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-24.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

@MainActor

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
                let documentRef = try await db.collection(collectionName).addDocument(data: spot.dictionary)
                self.spot = spot
                self.spot.id = documentRef.documentID
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new spot in '\(collectionName)' --> \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func saveImage(spot: Spot, photo: Photo, image: UIImage) async -> Bool {
        guard let spotID = spot.id else {
            print("😡 ERROR: spot.id == nil")
            return false
        }
        
        let photoName = UUID().uuidString   // This will be the name of the image file
        let storage = Storage.storage()     // Create a Firebase Cloud Storage instance
        let storageRef = storage.reference().child("\(spotID)/\(photoName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("😡 ERROR: Could not resize/compress image")
            return false
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"  // Setting metadata allows you to see console image in the web browser. This setting works for both png and jpg.
        
        var imageURLString = ""     // We'll set this after the image is successfully saved
        
        do {
            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
            print("📸 Image Saved!")
            do {
                let imageURL = try await storageRef.downloadURL()
                imageURLString = "\(imageURL)"  // We'll save this to Cloud Firestore as part of document in 'photos' collection, below
            } catch {
                print("😡 ERROR: Capturing downloadURL() in imageURL --> \(error.localizedDescription)")
                return false
            }

        } catch {
            print("😡 ERROR: uploading image to Firebase Cloud Storage --> \(error.localizedDescription)")
            return false
        }
        
        // Now save to the 'photos' collection of the spot document 'spotID'
        let db = Firestore.firestore()
        let collectionString = "spots/\(spotID)/photos"
        
        do {
            var newPhoto = photo
            newPhoto.imageURLString = imageURLString
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("😎 Data updated successfully")
            return true
        } catch {
            print("😡 ERROR: Could not update data in '\(collectionString).document(\(photoName))' --> \(error.localizedDescription)")
            return false
        }
    }
    
}
