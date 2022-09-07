//
//  Converter.swift
//  TemperatureConverter
//
//  Created by Pauline Broängen on 2022-09-07.
//

import Foundation

class Converter {
    
    
    //vi skapade en funktion i en ny swiftfil som heter toFahrenheit som tar emot en parameter fromCelsius som är av typen int och hela funktionen returnerar en int
    func toFahrenheit(fromCelsius: Int) -> Int {
        
        let fahrenheit = (1.8 * Double(fromCelsius)) + 32.0
        
        //nedanför.... det är en fahrenheit är en double men i avrundar det till en int
        return Int(round(fahrenheit))
    }
}
