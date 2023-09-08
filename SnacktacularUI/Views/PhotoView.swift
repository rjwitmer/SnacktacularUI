//
//  PhotoView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-09-08.
//

import SwiftUI

struct PhotoView: View {
    @EnvironmentObject var spotVM: SpotViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var photo = Photo()
    var uiImage: UIImage
    var spot: Spot
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                TextField("Description", text: $photo.description)
                    .textFieldStyle(.roundedBorder)
                
                Text("by: \(photo.reviewer) on: \(photo.postedOn.formatted(date: .numeric, time: .omitted))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        Task {
                            let success = await spotVM.saveImage(spot: spot, photo: photo, image: uiImage)
                            if success {
                                dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(uiImage: UIImage(named: "pizza2") ?? UIImage(), spot: Spot())
            .environmentObject(SpotViewModel())
    }
}
