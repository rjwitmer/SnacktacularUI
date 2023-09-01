//
//  SpotReviewRowView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-09-01.
//

import SwiftUI

struct SpotReviewRowView: View {
    @State var review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.title)
                .font(.title2)
            HStack {
                StarsSelectionView(rating: $review.rating, interactive: false, font: .callout)
                Text(review.body)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
    }
}

struct SpotReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpotReviewRowView(review: Review(title: "Fantastic Food!", body: "I love this place so much. The only thing preventing 5 stars is the surley service", rating: 4))
    }
}
