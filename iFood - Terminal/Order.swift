//
//  Order.swift
//  #2 Nano Challange
//
//  Created by Guilherme Valent Antonini & Igor Vicenteon 18/03/21.
//
 
import Foundation

class Order {
    
    var client: Client
    var restaurant: Restaurant
    var products: [(Product, Int)]
    var date: Date
    var observation: String?
    var formPayment: FormPayment
    var card: CardPayment?
    var delivery: Localization
        
    init(client: Client, restaurant: Restaurant, products: [(Product, Int)], formPayment: FormPayment, localization: Localization, cardPayment: CardPayment? = nil, observarion: String? = nil) {
        self.client = client
        self.restaurant = restaurant
        self.products = products
        self.date = Date()
        self.formPayment = formPayment
        delivery = localization
        
        if let card = cardPayment{
            self.card = card
        }
        
        if let observation = observarion {
            self.observation = observation
        }
        
    }
    
    func totalCost() -> Double{
        var sumCosts = 0.0
        for (product, qtd) in products {
            sumCosts += product.price * Double(qtd)
        }
        return sumCosts
    }
    
    func printOrder() {
        print("### Data do Pedido: \(dateFormatter(date))")
        print("###\n### Restaurante: \(restaurant.name)\n###")
        print( products.count == 1 ? "### Produto:" : "### Produtos:")
        
        for (product,qtd) in products {
            print("###\t  \(qtd)x \(product.name)(\(numberFormatter(product.price))) :\t \(numberFormatter(product.price*Double(qtd)))")
        }
        
        print("###\n### Valor total: \(numberFormatter(totalCost()))")
        print("###\n### Método de pagamento: \(formPayment.rawValue)")
        print(formPayment == .creditCard || formPayment == .debitCard ? "### Cartão: \(card!.name) - \(card!.cardNumber)\n###" : "###")
        print("### Endereço: \(delivery.descripiton)")
        print("################################################")
    }
    
}
