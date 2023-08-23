//
//  ListView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-23.
//

import SwiftUI
import Firebase

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            Text("List items will go here")
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Log Out") {
                    do {
                        try Auth.auth().signOut()
                        print("😎 Log out successful!")
                        dismiss()
                    } catch {
                        print("😡 ERROR DURING LOG OUT --> \(error.localizedDescription)")
                        dismiss()
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //TODO: add item code here
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
        }
    }
}
