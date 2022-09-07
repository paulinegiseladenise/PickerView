//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by Pauline Broängen on 2022-09-05.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    //() = instanserar, nu är det en tom array.
    // man kan skriva detta [Int]() istället för nummer och dollartecken.
    var temperatureIntervals = (-100...100).map{$0}
    
    //vi skapar en ny converter som är en converter. den kallar på klassen Converter i swiftfilen.
    var converter = Converter()
    
    var lastValue = "lastValue"
    
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    
    @IBOutlet weak var lblResult: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //loop för varje index -100...100 läggs index
        // for index in -100...100 {
        //   temperatureIntervals.append(index)
        //}
        
        //vilken rad ska den selecta? vi ville ha 0 så då valde vi hundra. mitt i spannet liksom.
        myPickerView.selectRow(getInitialValue(), inComponent: 0, animated: false)
        
        
        //vi borde ha döpt pickerViewn till något annat än bara pickerView då den lätt förvirrar annars.... fast det går att ändra på namnet på variabeln genom att högerklicka och refactor, då ändras variabelns namn överallt....
        pickerView(myPickerView, didSelectRow: getInitialValue(), inComponent: 0)
        
    }
    
    
    
    
    //dessa två nedanstående funktioner kom till av att vi lade till UIPickerViewDataSource och jag klippte ut dom och lade dom efter viewDidLoad för den funktionen vill man enligt best practise ofta har först.
    
    
    //man måste ge funktionen någonstans att hämta sin data ifrån: UIPickerViewDataSource för annars är fältet bara tomt.
    //den första pickerviewn säger att den ska visa en pickerview/rullista och inte fler, dvs return 1. visar en komponent.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //den här pickerview visar hur mnånga rader det ska vara, i detta fallet 200 på grund av variabeln som vi skapat, dvs temperatureIntervals.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temperatureIntervals.count
    }
    
    //den här pickerviewfunktionen anger vad varje rad ska heta. den kollar varje rad för rad vad varje rad heter. temperatureIntervals berättar för funktionen vad det ska vara på varje rad.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(temperatureIntervals[row])℃"
    }
    
    //denna funktionen vet vilket värde i pickerviewn/rullistan som valt.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let fahrenheit = converter.toFahrenheit(fromCelsius: temperatureIntervals[row])
        
        saveToDefault(row: row)
        
        lblResult.text = "\(String(fahrenheit))℉"
    
    }
    
    
    
    //nästa funktion som vi skapar blir att appen alltid startar på det värdet som vi hade senast.
    
    
    func getInitialValue() -> Int {
        
        //let savedRow = UserDefaults.standard.integer(forKey: lastValue)
        
        //nedanstående kan vara nil eftersom att den är any. det måste finnas frågeteckenn för att man ska kunna nilchecka.
        let savedRow = UserDefaults.standard.object(forKey: lastValue) as? Int
        
        if let row = savedRow {
            return row
        } else {
            return 100
        }
    }
    
    func saveToDefault(row: Int) {
        let defaults = UserDefaults.standard
       
        defaults.set(row, forKey: lastValue)
        
        defaults.synchronize()
    }
}

