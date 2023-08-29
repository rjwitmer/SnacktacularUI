//
//  StarsSelectionView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-28.
//

import SwiftUI

struct StarsSelectionView: View {
    @State var rating: Int  //TODO: Change this to @Binding after layout is tested
    // The following constants can be changed for future requirements
    let highestRating = 5
    let unselectedImage = Image(systemName: "star")
    let selectedImage = Image(systemName: "star.fill")
    let font: Font = .largeTitle
    let fillColor: Color = .red
    let emptyColor: Color = .gray
    
    var body: some View {
        HStack {
            ForEach(1...highestRating, id: \.self) {number in
                showStar(for: number)
                    .foregroundColor(number <= rating ? fillColor : emptyColor)
                    .onTapGesture {
                        rating = number
                    }
            }
            .font(font)
        }
    }
    
    func showStar( for number: Int) -> Image {
        if number > rating {
            return unselectedImage
        } else {
            return selectedImage
        }
    }
}

struct StarsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StarsSelectionView(rating: 4)
    }
}
