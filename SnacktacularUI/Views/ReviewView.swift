//
//  ReviewView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-28.
//

import SwiftUI

struct ReviewView: View {
    @State var spot: Spot
    @State var review: Review
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Text(spot.name)
                    .font(.title)
                    .bold()
                    .lineLimit(1)
                Text(spot.address)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Text("Click to Rate:")
                .font(.title2)
                .bold()
            HStack {
                StarsSelectionView(rating: review.rating)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("Review Title:")
                    .bold()
                
                TextField("title", text: $review.title)
                    .textFieldStyle(.roundedBorder)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }
                Text("Review:")
                    .bold()
                
                TextField("review", text: $review.body, axis: .vertical)
                    .padding(.horizontal, 6)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }
            }
            .padding(.horizontal)
            .font(.title2)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    //TODO: Add Save function
                    dismiss()
                }
            }
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReviewView(spot: Spot(name: "Shake Shack", address: "49 Boyleston St. Chestnut Hill, MA 02467"), review: Review())
        }
    }
}
