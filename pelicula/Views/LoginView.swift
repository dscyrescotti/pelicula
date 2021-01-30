//
//  LoginView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 29/01/2021.
//

import SwiftUI
import SwiftUIX

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        VStack {
            Spacer()
            Text("🎬")
                .font(.system(size: 70))
            Text("pelicula")
                    .bold()
                    .font(.system(size: 50))
            Spacer()
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.headline)
                    .fontWeight(.medium)
                TextField("username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(8)
                    .padding(.horizontal, 3)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.headline)
                    .fontWeight(.medium)
                SecureField("password", text: $viewModel.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(8)
                    .padding(.horizontal, 3)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
            }
            .padding(.horizontal)
            if let error = viewModel.error {
                Label(error.message, systemImage: "exclamationmark.triangle.fill")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.red)
            }
            Spacer()
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                viewModel.login()
            }) {
                Group {
                    if viewModel.isLogging {
                        ProgressView()
                    } else {
                        Text("Login")
                            .font(.headline)
                    }
                }
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(viewModel.validate() && !viewModel.isLogging ? Color.green : Color.green.opacity(0.5))
                .cornerRadius(8)
                .padding(.horizontal)
            }
            .disabled(!viewModel.validate() && viewModel.isLogging)
        }
        .padding(.bottom, 10)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
