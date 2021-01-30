//
//  LoginView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 29/01/2021.
//

import SwiftUI
import SwiftUIX

struct LoginView: View {
    @State private var credientials = Credientials()
    var body: some View {
        VStack {
            Spacer()
            Text("🎬")
                .font(.system(size: 70))
            Text("pelicula")
                    .bold()
                    .font(.system(size: 60))
            Spacer()
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.headline)
                    .fontWeight(.medium)
                TextField("username", text: $credientials.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(8)
                    .padding(.horizontal, 3)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
            }
            .padding(.horizontal)
                .padding(.bottom, 5)
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.headline)
                    .fontWeight(.medium)
                SecureField("password", text: $credientials.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(8)
                    .padding(.horizontal, 3)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
            }
            .padding(.horizontal)
            Spacer()
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                UserService.sharedInstance.login(username: credientials.username, password: credientials.password)
            }) {
                Text("Login")
                    .font(.headline)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(credientials.validate() ? Color.green : Color.green.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(!credientials.validate())
        }
        .padding(.bottom, 10)
    }
    
    private struct Credientials {
        var username: String = ""
        var password: String = ""
        
        func validate() -> Bool {
            username.isNotEmpty && password.isNotEmpty
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
