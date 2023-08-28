//
//  SpotDetailView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-24.
//

import SwiftUI

struct SpotDetailView: View {
    @EnvironmentObject var spotVM: SpotViewModel
    @State var spot: Spot
    @State private var showPlaceLookupSheet = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Group {
                TextField("Name", text: $spot.name)
                    .font(.title)
                TextField("Address", text: $spot.address)
                    .font(.title2)
            }
            .disabled(spot.id == nil ? false : true)
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: spot.id == nil ? 2 : 0)
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(spot.id == nil)
        .toolbar {
            if spot.id == nil {     // New spot, so show Cancel/Save buttons
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await spotVM.saveSpot(spot: spot)
                            if success {
                                dismiss()
                            } else {
                                print("😡 ERROR: Saving spot!")
                            }
                        }
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        showPlaceLookupSheet.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                    }

                }
            }
        }
        .sheet(isPresented: $showPlaceLookupSheet) {
            PlaceLookupView(spot: $spot)
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SpotDetailView(spot: Spot())
                .environmentObject(SpotViewModel())
        }
    }
}
