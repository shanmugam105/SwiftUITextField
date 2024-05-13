//
//  ContentView.swift
//  STextField-SwiftUI-Example
//
//  Created by sparkout on 13/5/24.
//

import SwiftUI
import SwiftUITextField

struct ContentView: View {
    @State var username: String = ""
    @State var genderSelected: String = ""
    let genders: [String] = ["Male", "Female"]
    
    var body: some View {
        VStack(spacing: 12) {
            SwiftUITextField(placeholder: "Username", text: $username)
            SwiftUITextField(placeholder: "Gender", text: $genderSelected, dropDownOptions: genders)
            SwiftUITextField(placeholder: "DOB", text: $username, dateFormatter: "MMM d, yyyy")
        }
        .padding()
    }
}

