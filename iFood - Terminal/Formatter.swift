//
//  Formatter.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Antonini & Igor Vicente on 19/03/21.
//

import Foundation

func dateFormatter(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "pt_BR")
    
    let dateFormatted: String = dateFormatter.string(from: date)
    
    return dateFormatted
}

func numberFormatter(_ number: Double) -> String {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.numberStyle = .currency
    
    let numberFormatted: String = numberFormatter.string(from: NSNumber(value: number)) ?? "error"

    return numberFormatted
}
