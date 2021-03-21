//
//  Product.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Valent Antonini & Igor Vicente on 16/03/21.
//

class Product {
    var name: String
    var price: Double
    var category: Category
    var description: String
    
    init(name: String, price: Double, category: Category, description: String) {
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }
}
