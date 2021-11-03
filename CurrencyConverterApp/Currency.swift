//
//  Currency.swift
//  CurrencyConverterApp
//
//  Created by Ferdi DEMİRCİ on 3.11.2021.
//

import Foundation

struct Currency {
    var code:String = ""
    var value:Double = 0
    var image:String {
        return code + ".png"
    }
}
