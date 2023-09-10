//
//  SpotDetailPhotosScrollView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-09-09.
//

import SwiftUI

struct SpotDetailPhotosScrollView: View {
    
    @State private var showPhotoViewerView = false
    @State private var uiImage = UIImage()
    @State private var selectedPhoto = Photo()
    var photos: [Photo]
    var spot: Spot
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack (spacing: 4) {
                ForEach(photos) { photo in
                    let imageURL = URL(string: photo.imageURLString) ?? URL(string: "")
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()    // Note: order is important
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()  // Clip if the image isn't square
                            .onTapGesture {
                                let renderer = ImageRenderer(content: image)
                                selectedPhoto = photo
                                uiImage = renderer.uiImage ?? UIImage()
                                showPhotoViewerView.toggle()
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }

                }
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 4)
        .sheet(isPresented: $showPhotoViewerView) {
            PhotoView(photo: $selectedPhoto, uiImage: uiImage, spot: spot)        }
    }
}

struct SpotDetailPhotosScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SpotDetailPhotosScrollView(photos: [Photo(imageURLString: "https://firebasestorage.googleapis.com:443/v0/b/snacktacularui-bac70.appspot.com/o/JItqsMG0xUDAMB1DeGYk%2F065F8E16-9CFF-4572-A1E7-C7CA721D38DE.jpeg?alt=media&token=cbb8e478-42ea-439e-a9e3-387884a00c12")], spot: Spot(id: "JItqsMG0xUDAMB1DeGYk"))
    }
}
