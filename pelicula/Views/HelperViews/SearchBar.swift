//
//  SearchBar.swift
//  pelicula
//
//  Created by Dscyre Scotti on 29/01/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    @State private var text: String = ""
    @State private var isEditing = false
    
    init(query: Binding<String>) {
        self._query = query
        print("Init")
    }
 
    var body: some View {
        HStack(spacing: 0) {
            TextField("Search", text: $text, onCommit: {
                self.query = text
                self.isEditing = false
            })
            .autocapitalization(.none)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .keyboardType(.webSearch)
            .overlay(
                HStack {
                    SwiftUI.Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
             
                    if isEditing && text.isNotEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            SwiftUI.Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = self.query
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(query: .constant(""))
    }
}
