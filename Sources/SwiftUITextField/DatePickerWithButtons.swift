//
//  File.swift
//  
//
//  Created by sparkout on 13/5/24.
//

import SwiftUI

struct DatePickerWithButtons: View {
    @State private var selectedDate: Date = Date()
    @Binding var dateText: String
    let dateFormat: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button {
                        UIApplication.topViewController()?.dismiss(animated: true)
                    } label: {
                        Text("Cancel")
                    }
                    
                    Spacer()
                    
                    Button {
                        dateText = selectedDate.toString(dateFormat: dateFormat)
                        UIApplication.topViewController()?.dismiss(animated: true)
                    } label: {
                        Text("Done".uppercased())
                            .bold()
                    }
                    
                }
                .padding(.horizontal)
                Divider()
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            .padding()
            .background(Color.white.cornerRadius(20))
            .padding()
            .onAppear {
                if !dateText.isEmpty, !dateFormat.isEmpty {
                    selectedDate = dateText.convertDate(format: dateFormat) ?? Date()
                }
            }
        }
    }
}
