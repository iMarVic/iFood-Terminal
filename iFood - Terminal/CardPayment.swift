//
//  Payment.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Antonini & Igor Vicente 19/03/21.
//

class CardPayment {
    var name: String
    var formPayment: FormPayment
    var cardNumber: String
    var cardDate: String
    var cardCVV: String
    var shortDescription: String { "\(name) - \(cardNumber)" }
    
    init(formPayment: FormPayment) {
        
        print("Por favor, informe o número do seu cartão: ", terminator: "")
        let creditNumber = readLine() ?? "erro"
        
        print("\nPor favor, informe a data de validade (mm/aa): ", terminator: "")
        let creditDate = readLine() ?? "erro"
        
        print("\nPor favor, infome o código de segurança: ", terminator: "")
        let creditCVV = readLine() ?? "erro"
        
        print("\nDê um nome para esse cartão: ", terminator: "")
        let creditName = readLine() ?? "erro"
        
        self.name = creditName
        self.cardNumber = creditNumber
        self.cardDate = creditDate
        self.cardCVV = creditCVV
        self.formPayment = formPayment
        
    }
    
}
