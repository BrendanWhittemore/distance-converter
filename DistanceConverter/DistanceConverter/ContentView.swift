//
//  ContentView.swift
//  DistanceConverter
//
//  Created by Brendan Whittemore on 3/19/25.
//

import SwiftUI

enum DistanceUnits {
    case miles, yards, feet, kilometers, meters
    
    func toString() -> String {
        switch self {
        case .miles:
            return "mi"
        case .yards:
            return "yd"
        case .feet:
            return "ft"
        case .kilometers:
            return "km"
        case .meters:
            return "m"
        }
    }
}

struct ContentView: View {
    @State private var inputDistance = 0.0
    @State private var inputUnit = DistanceUnits.miles
    @State private var outputUnit = DistanceUnits.kilometers
    
    let units: [DistanceUnits] = [.miles, .yards, .feet, .kilometers, .meters]
    
    var outputDistance: Double {
        let distanceInFeet: Double
        
        switch inputUnit {
        case .miles:
            distanceInFeet = inputDistance * 5280
        case .yards:
            distanceInFeet = inputDistance * 3
        case .feet:
            distanceInFeet = inputDistance
        case .kilometers:
            distanceInFeet = inputDistance * 3280.84
        case .meters:
            distanceInFeet = inputDistance * 3.28084
        }
        
        switch outputUnit {
        case .miles:
            return distanceInFeet / 5280
        case .yards:
            return distanceInFeet / 3
        case .feet:
            return distanceInFeet
        case .kilometers:
            return distanceInFeet / 3280.84
        case .meters:
            return distanceInFeet / 3.28084
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input distance") {
                    TextField("Distance", value: $inputDistance, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Select a unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.toString())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output distance") {
                    Text(outputDistance, format: .number)
                    
                    Picker("Select a unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.toString())
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Distance Converter")
        }
    }
}

#Preview {
    ContentView()
}
