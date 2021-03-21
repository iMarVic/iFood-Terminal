//
//  Localization.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Valent Antonini & Igor Vicente on 16/03/21.
//

class Localization{
    var country: String
    var state: String
    var city: String
    var street: String
    var number: Int
    var complement: String?
    var descripiton: String { "\(street), \(number) - \(city) (\(state)), \(country)" }
    
    init(country: String, state: String, city: String, street: String, number: Int, complement: String? = nil) {
        self.country = country
        self.state = state
        self.city = city
        self.street = street
        self.number = number
        self.complement = complement
    }
    
    func update() {
        print("Alterando endereço, caso não queira alterar algum dado basta deixar em branco e teclar enter")
        
        print("## País: \(country)")
        print("Novo: ", terminator: "")
        var input = readLine() ?? country
        country = input == "" ? country : input
        
        print("\n## Estado: \(state)")
        print("Novo: ", terminator: "")
        input = readLine() ?? state
        state = input == "" ? state : input
        
        print("\n## Cidade: \(city)")
        print("Novo: ", terminator: "")
        input = readLine() ?? city
        city = input == "" ? city : input
        
        print("\n## Logradouro: \(street)")
        print("Novo: ", terminator: "")
        input = readLine() ?? street
        street = input == "" ? street : input
        
        print("\n## Logradouro: \(number)")
        print("Novo: ", terminator: "")
        let inputNumber = readLine() ?? String(number)
        number = (inputNumber == "" ? number : Int(inputNumber)) ?? number
        
        print("\n## Complemento: \(complement ?? "<Não contém>")")
        print("Novo: ", terminator: "")
        input = readLine() ?? complement ?? ""
        complement = input == "" ? complement ?? "" : input
        
    }
    
}
