//
//  LoginView.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    enum Field {
        case email, password
    }
    
    @FocusState private var focusField: Field?
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var buttonsDisabled = true
    @State private var alertMessage = ""

    
    var body: some View {
        NavigationStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding()
            Group {
                TextField("eMail Address", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit { // Move from email field to password field
                        focusField = .password
                    }
                    .onChange(of: email) { _ in
                        enableButtons()
                    }
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil    // Dismiss the keyboard
                    }
                    .onChange(of: password) { _ in
                        enableButtons()
                    }

            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                Button("Sign Up") {
                    register()
                }
                Spacer()
                Button("Log In") {
                    login()
                }
                Spacer()
            }
            .disabled(buttonsDisabled)
            .buttonStyle(.borderedProminent)
            .tint(Color("SnackColor"))
            .font(.title2)
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
        
    }
    
    func enableButtons() {
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        if emailIsGood && passwordIsGood {
            buttonsDisabled = false
        } else {
            buttonsDisabled = true
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {  // login error occured
                alertMessage = "SIGN UP ERROR: \(error.localizedDescription)"
                showingAlert = true
                print("😡\(alertMessage)")
            } else {
                print("😎 Registration success!")
                //TODO: Load ListView
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { Result, error in
            if let error = error {  // login error occured
                alertMessage = "LOG IN ERROR: \(error.localizedDescription)"
                showingAlert = true
                print("😡\(alertMessage)")
            } else {
                print("😎 Successful Login!")
                //TODO: Load ListView
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
