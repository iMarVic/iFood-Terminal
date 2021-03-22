//
//  Client.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Valent Antonini & Igor Vicente on 16/03/21.
//

class Client {
    var name: String
    var CPF: String
    var email: String
    var password: String
    var localization: [Localization] = []
    var payments: [FormPayment] = [.money]
    var cardPayments: [CardPayment] = []

    init(name: String, CPF: String, email: String, password: String, localization: Localization? = nil) {
        self.name = name
        self.CPF = CPF
        self.email = email
        self.password = password
        if let localization = localization {
            self.localization.append(localization)

        }
    }
    
    func addFormPayment(){
        
        var formPaymentSelected: FormPayment = .money // generic value

        while true {
            
            var contFormPayment = 1
            print("\n#################################")
            for formPayment in FormPayment.allCases {
                print("### \(contFormPayment) - \(formPayment.rawValue)")
                contFormPayment+=1
            }
            print("#################################\n")
            
            print("Informe o método de pagamento que deseja adicionar: ", terminator: "")
            
            let opFormPayment = readLine() ?? "erro"
            
            if let opIntFormPayment = Int(opFormPayment){
                if opIntFormPayment > 0 && opIntFormPayment <= FormPayment.allCases.count {
                    formPaymentSelected = FormPayment.allCases[opIntFormPayment-1]
                    break
                }
            } else {
                print("\n### Opção Inválida! Tente novamente: ", terminator: "")
            }
        }
        
        if formPaymentSelected == .creditCard || formPaymentSelected == .debitCard {
            addCard(formPaymentSelected)
        } else {
            if !payments.contains(formPaymentSelected) {
                payments.append(formPaymentSelected)
                print("\n### Métodos de pagamento adicionado com sucesso!")
            } else {
                print("\n### Método de pagamento já existente")
            }
        }
    }
    
    
    func addCard( _ formPayment: FormPayment? = nil) {
        
        if let formPayment = formPayment {
            let card: CardPayment = CardPayment(formPayment: formPayment)
            cardPayments.append(card)
            
            if !payments.contains(formPayment) {
                payments.append(formPayment)
            }
        } else {
            while true {
                print("\n#################################")
                print("#### 1 - Cartão de Crédito")
                print("#### 2 - Cartão de Débito\n")
                print("#################################\n")

                print("Qual o tipo do cartão?", terminator: "")
                let opCard = readLine() ?? "erro"
                
                if let intOpCard = Int(opCard) {
                    if intOpCard == 1 {
                        addCard(.creditCard)
                        break
                    } else if intOpCard == 2 {
                        addCard(.debitCard)
                        break
                    } else {
                        print("\n### Opção inválida. Tente novamente")
                    }
                } else {
                    print("\n### Opção inválida. Tente novamente")
                }
            }
        }
    }
    
    func addLocalization() -> Localization {
        print("\n### Adicionando endereço: ")
        print("País: ", terminator: "")
        var input = readLine() ?? ""
        let country = input
        
        print("Estado: ", terminator: "")
        input = readLine() ?? ""
        let state = input
        
        print("Cidade: ", terminator: "")
        input = readLine() ?? ""
        let city = input
        
        print("Logradouro: ", terminator: "")
        input = readLine() ?? ""
        let street = input
        
        print("Número: ", terminator: "")
        input = readLine() ?? ""
        let number = Int(input) ?? 0
        
        print("Complemento: ", terminator: "")
        input = readLine() ?? ""
        let complement = input == "" ? nil ?? nil : input
        
        let newLocalization = Localization(country: country, state: state, city: city, street: street, number: number, complement: complement)
        localization.append(newLocalization)
        return newLocalization
    }
    
    func myDatas() {
        print("\n#################################")
        print("###         MEUS DADOS        ###")
        print("#################################")
        print("### 1 - Nome: \(name)")
        print("### 2 - CPF: \(CPF)")
        print("### 3 - E-mail: \(email)")
        print("### 4 - Senha: *********")
        print("#################################\n")
    }
    
    func myLocalizations() {
        var contLocalization = 1
        print("\n#########################################################")
        print("###                  MEUS ENDEREÇOS                   ###")
        print("#########################################################")
        for localization in localization {
            print("### \(contLocalization) - \(localization.descripiton)")
            contLocalization += 1
        }
        print("#########################################################\n")
        if contLocalization == 1 {
            print("###          NENHUM ENDEREÇO CADASTRADO               ###")
            print("#########################################################\n")
        }
    }
    
    func myPayments() {
        print("\n#################################")
        print("###    FORMAS DE PAGAMENTO    ###")
        print("#################################")
        
        var contPayment = 1
        
        for formPayment in payments {
            print("### \(contPayment) - \(formPayment.rawValue)")
            contPayment+=1
        }
        print("#################################\n")
    }
    
    func myCards(formPayment: FormPayment) -> [CardPayment]{
        var contCard = 1
        var cardsPayment : [CardPayment] = []
        print("#################################")
        for card in cardPayments {
            if card.formPayment == formPayment {
                print("### \(contCard) - \(card.shortDescription)")
                contCard += 1
                cardsPayment.append(card)
            }
        }
        if cardsPayment.count == 0 {
            print("### Nenhum \(formPayment.rawValue) cadastrado")
        }
        print("#################################\n")
        return cardsPayment
    }
    
    func removeCard( _ card: CardPayment) {
        var indexCard = 0
        var indexFormPayment = 0
        var contFormPayments = 0
        for cardsClient in cardPayments {
            if cardsClient.formPayment == card.formPayment {
                contFormPayments+=1
            }
            if cardsClient.cardNumber == card.cardNumber {
                cardPayments.remove(at: indexCard)
                print("\n### Cartão removido do perfil\n")
            }
            indexCard += 1
        }
        
        if contFormPayments == 1 {
            for pay in payments {
                if pay == card.formPayment {
                    payments.remove(at: indexFormPayment)
                }
                indexFormPayment+=1
            }
        }
    }
    
    func updateName() {
        print("\n### Nome atual: \(name)")
        print("Informe o novo nome: ", terminator: "")
        let newName = readLine() ?? name
        name = newName
        print("\n### Alteração realizada com sucesso \(name)")
    }
    
    func updateCPF() {
        print("\n### CPF atual: \(CPF)")
        print("Informe o novo CPF: ", terminator: "")
        let newCPF = readLine() ?? CPF
        CPF = newCPF
        print("\n### Alteração realizada com sucesso: \(CPF)")
    }
    
    func updateEmail() {
        print("\n### E-mail atual: \(email)")
        print("Informe o novo E-mail: ", terminator: "")
        let newEmail = readLine() ?? email
        email = newEmail
        print("\n### Acesse seu e-mail: \(email), para confirmar alteração")
    }
    
    func updateSenha() {
        print("\n### Acesse o link que enviaremos ao seu e-mail (\(email)) para concluir a alteração de senha...")
    }
}
