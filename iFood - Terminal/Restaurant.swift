//
//  Restaurant.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Valent Antonini & Igor Vicente on 16/03/21.
//


class Restaurant {
    
    var name: String
    var CNPJ: String
    var localization: Localization
    var user: String
    var password: String
    var categories: [Category] = []
    var menu: [Product] = []
    var rates: [Int] = []
    var rateAVG: Double {computeAvgRate()}
    
    init(name: String, CNPJ: String, localization: Localization, user: String, password: String) {
        self.name = name
        self.CNPJ = CNPJ
        self.localization = localization
        self.user = user
        self.password = password
    }
    
    func addCategories(category: Category) {
        categories.append(category)
    }
    
    func addProduct(_ product: Product) {
        menu.append(product)
        if !categories.contains(product.category) {
            categories.append(product.category)
        }
    }
    
    func addRate(rate: Int) {
        rates.append(rate)
    }
    
    func computeAvgRate() -> Double {
        var contRates = 0
        
        for rate in rates {
            contRates += rate
        }
        
        return Double(contRates)/Double(rates.count)
    }
    
}
