//
//  ChooseCity.swift
//  ExamplesListSWiftUI
//
//  Created by naeem alabboodi on 8/30/23.
//

import SwiftUI

struct ChooseCity: View {
    @Binding var selectedCity: String
    @Binding var isSheetPresented: Bool
    @ObservedObject var weatherViewModel: PittsburghWeatherViewModel
    var body: some View {
        VStack {
            TextField("Enter city", text: $selectedCity) {
                // This code will run when the user presses "Enter"
                weatherViewModel.city = selectedCity
                weatherViewModel.fetchSchools() // fetch data for the new city
                isSheetPresented = false
            }
                .onChange(of: selectedCity){
                    weatherViewModel.city = selectedCity
                    // Additionally, you might want to fetch the data for the new city here
                    weatherViewModel.fetchSchools()
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.cyan)
                        .opacity(0.3)
                )
                .opacity(0.9)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 2)
                }
                .foregroundColor(Color.black)
            
        }
        .padding()
    }
}

#Preview {
    ChooseCity(selectedCity: .constant("Paris"), isSheetPresented: .constant(true), weatherViewModel: (PittsburghWeatherViewModel()))
}
