//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Devendra Kulkarni on 2024-08-09.
//

import SwiftUI

struct ContentView: View {
    @State private var temperatureType = "Celsius"
    @State private var conversionTempType = "Celsius"
    @State private var temperatureValue = 0.0
    @FocusState private var valueIsFocused: Bool
    
    let temperatureTypes = ["Celsius", "Kelvin", "Farenheit"]
    
    var calculatedTemperature : Double {
        var calculatedTemperature = temperatureValue
        if temperatureType == "Celsius" {
            if conversionTempType == "Celsius" {
                // Do nothing
            } else if conversionTempType == "Kelvin" {
                // Convert Celsius to Kelvin
                calculatedTemperature = calculatedTemperature + 273.15
            } else {
                // Convert Celsius to Farenheit
                calculatedTemperature = calculatedTemperature * (9 / 5) + 32
            }
        } else if temperatureType == "Farenheit" {
            if conversionTempType == "Celsius" {
                // Farenheit to Celsius
                calculatedTemperature = (calculatedTemperature - 32) * (5/9)
            } else if conversionTempType == "Kelvin" {
                // Farenheit to Kelvin
                calculatedTemperature = (calculatedTemperature - 32) * (5/9) + 273.15
            } else {
                // Do nothing
            }
        } else {
            if conversionTempType == "Celsius" {
                // Kelvin to Celsius
                calculatedTemperature = calculatedTemperature - 273.15
            } else if conversionTempType == "Kelvin" {
                // Do Nothing
            } else {
                // Kelvin to Farenheit
                calculatedTemperature = (calculatedTemperature - 273.15) * (9/5) + 32
            }
        }
        return calculatedTemperature
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature Type") {
                    Picker("Temperature Type", selection: $temperatureType) {
                        ForEach(temperatureTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    Text("Selected Temperature Unit: \(temperatureType)")
                }
                
                Section("Temperature Value") {
                    TextField("Value", value: $temperatureValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                }
                
                Section("Temperature to convert to") {
                    Picker("Temperature Type", selection: $conversionTempType) {
                        ForEach(temperatureTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    Text("Selected Conversion Unit: \(conversionTempType)")
                }
                
                Section("Converted Temperature") {
                    Text(calculatedTemperature, format: .number)
                }
            }
            .toolbar {
                if valueIsFocused {
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
