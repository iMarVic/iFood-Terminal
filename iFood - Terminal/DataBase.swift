//
//  DataBase.swift
//  #2 Nano Challange
//
//  Created by Guilherme Valent Antonini & Igor Vicente on 18/03/21.
//
import Foundation

class DataBase {
    var clients: [Client] = []
    var restaurants: [Restaurant] = []
    var orders: [Order] = []
    
    private let portoAlegre: Localization = Localization(country: "Brasil", state: "RS", city: "Porto Alegre", street: "Av Ipirnanga", number: 4980, complement: "apt 11")
    private let campoGrande: Localization = Localization(country: "Brasil", state: "MS", city: "Campo Grande", street: "", number: 15, complement: "")
    
    init(){
        existingClients()
        existingRestaurants()
    }
    
    func existingClients() {
        addClient(Client(name: "Carlos", CPF: "000.000.000-01", email: "carlos@icloud.com", password: "1234", localization: campoGrande))
        addClient(Client(name: "Jeniffer", CPF: "123.456.789-02", email: "jeniffer@icloud.com", password: "5678", localization: portoAlegre))
        addClient(Client(name: "Cristina", CPF: "000.000.000-03", email: "cristina@icloud.com", password: "4321", localization: campoGrande))
        addClient(Client(name: "Gustavo", CPF: "000.000.000-04", email: "gustavo@icloud.com", password: "8765", localization: portoAlegre))
        addClient(Client(name: "Maicon", CPF: "000.000.000-05", email: "maicon@icloud.com", password: "1221", localization: portoAlegre))
    }
    
    func existingRestaurants() {
        
        let restaurant1 = Restaurant(name: "Dog do Zé", CNPJ: "00.000.000/000-01", localization: portoAlegre, user: "ze", password: "1234")
        restaurant1.addCategories(category: .Brasileira)
        restaurant1.addCategories(category: .CozinhaRapida)
        
        restaurant1.addProduct(Product(name: "Dog simples", price: 9.00, category: .HotDog, description: ""))
        restaurant1.addProduct(Product(name: "Coca Cola lata", price: 3.50, category: .Bebidas, description: ""))
        restaurant1.addProduct(Product(name: "Casquinha de sorvete", price: 4.00, category: .Sorvetes, description: ""))
        
        let restaurant2 = Restaurant(name: "Décima Pizzas - Universitário", CNPJ: "00.000.000/000-06", localization: portoAlegre, user: "espetinho", password: "5746")
        let restaurant3 = Restaurant(name: "Lancheria e Pizzaria", CNPJ: "00.000.000/000-05", localization: portoAlegre, user: "lanche", password: "5746")
        restaurant3.addCategories(category: .Pizza)
        
        restaurant2.addProduct(Product(name: "Pizza Calabresa", price: 32.00, category: .Pizza, description: "Calabresa, molho vermelho e cebola"))
        restaurant2.addProduct(Product(name: "Pizza Muçarela", price: 35.00, category: .Pizza, description: "Queijo muzarela e creme branco"))
        restaurant2.addProduct(Product(name: "Pizza Frango com Catupiry", price: 40.00, category: .Pizza, description: "Frango desfiado, catupiry e queijo muzarela"))
        
        restaurants.append(restaurant1)
        restaurants.append(restaurant2)
        restaurants.append(Restaurant(name: "La Fruta Açaí - Bento", CNPJ: "00.000.000/000-02", localization: portoAlegre, user: "acai", password: "4332"))
        restaurants.append(Restaurant(name: "Sapore Sublime", CNPJ: "00.000.000/000-03", localization: portoAlegre, user: "rody", password: "5678"))
        restaurants.append(Restaurant(name: "Croasonho - Bento", CNPJ: "00.000.000/000-04", localization: portoAlegre, user: "sonia", password: "1010"))
        restaurants.append(restaurant3)
    }
    
    func createClient() {
        print("Nome: ", terminator: "")
        var input = readLine() ?? ""
        let name = input
        
        print("CPF: ", terminator: "")
        input = readLine() ?? ""
        let CPF = input
        
        print("E-mail: ", terminator: "")
        input = readLine() ?? ""
        let email = input
        
        print("Senha: ", terminator: "")
        input = readLine() ?? ""
        let password = input
        
        let newClient = Client(name: name, CPF: CPF, email: email, password: password)
        
        var _ = newClient.addLocalization()
        
        clients.append(newClient)
        
        print("\n### Cadastro concluído com sucesso!\n")
    }
    
    func addClient( _ client: Client) {
        clients.append(client)
    }
    
    func addRestaurant(restaurant: Restaurant) {
        restaurants.append(restaurant)
    }
    
    func addOrder(_ order: Order) {
        orders.append(order)
    }
    
    func listRestaurants( _ category: Category? = nil){
        var opRestaurants: [Restaurant] = []

        if let local = selectLocalization() {
            var cont = 1;
                    
            print("\n#################################")
            print("##         RESTAURANTES        ##")
            print("#################################")
            
            for restaurant in restaurants {
                if restaurant.localization.country == local.country &&
                    restaurant.localization.state  == local.state &&
                    restaurant.localization.city   == local.city {
                    
                    if let opCategory = category {
                        if restaurant.categories.contains(opCategory) {
                            opRestaurants.append(restaurant)
                            print("## \(cont) - \(restaurant.name)")
                            cont+=1
                        }
                    } else {
                        opRestaurants.append(restaurant)
                        print("## \(cont) - \(restaurant.name)")
                        cont+=1
                    }
                }
            }
        }
        
        if opRestaurants.count > 0 {
            print("#################################\n")
            print("\nSelecione um dos restaurantes acima, ou digite 0 para retornar ao inicio: ", terminator: "")
            while true {
                let op = readLine() ?? "erro"
                
                if op == "0"{
                    break
                } else {
                    if let opInt = Int(op) {
                        if opInt <= opRestaurants.count {
                            listMenu(restaurant: opRestaurants[opInt-1])
                            break
                        }
                    }
                    print("## Opção inválida ## \n")
                    sleep(2)
                    print("Tente novamente: ", terminator: "")
                }
            }
            
        } else {
            print("\n## Nenhum restaurante encontrado em sua região ou na categoria selecionada\n")
            print("########################## \n")
        }
        
    }
    
    func listMenu(restaurant: Restaurant) {
        if restaurant.menu.count > 0 {
            var selectProducts: [(Product, Int)] = []
            var finishShop = false
            while !finishShop {
                print("\n#################################################")
                print("###                  PRODUTOS                 ###")
                print("#################################################")
                
                var cont = 1
                for product in restaurant.menu {
                    print("### \(cont) - \(product.name) : \(numberFormatter(product.price) ) (\(product.category.rawValue))")
                    print("### \t\t \(product.description)")
                    cont += 1
                }
                
                print("#################################################\n")
                print("\nSelecione um dos produtos acima, ou digite 0 para retornar ao inicio: ", terminator: "")
                let op = readLine() ?? "erro"
                
                if op == "0" {
                    break
                } else {
                    if let opInt = Int(op) {
                        if opInt <= restaurant.menu.count {
                            print("\nQuantidade: ", terminator: "")
                            let qtd = readLine() ?? "erro"
                            
                            if let qtdInt = Int(qtd) {
                                selectProducts.append((restaurant.menu[opInt-1], qtdInt))
                                print("\n#################################################")
                                print("### \(qtdInt)x \(restaurant.menu[opInt-1].name)(\(numberFormatter(restaurant.menu[opInt-1].price))) = \(numberFormatter(restaurant.menu[opInt-1].price * Double(qtdInt)))")
                                print("#################################################\n")

                                print("a - Adicionar ao pedido e continuar comprando")
                                print("b - Adicionar ao pedido e finalizar compra")
                                print("c - Cancelar pedido\n")
                                
                                print("Informe a opção desejada: ", terminator: "")

                                while true {
                                    let opProduct = readLine() ?? "erro"
                                    
                                    if opProduct == "a" {
                                        print("\n### Produto adicionando! \n\n### Continue comprando...")
                                        sleep(2)
                                        break
                                    } else if opProduct == "b" {
                                        print("\n### Produto adicionando! \n\n### Vamos conferir seu pedido:")
                                        sleep(2)
                                        finishShop = true
                                        break
                                    } else if opProduct == "c" {
                                        print("\n### Cancelando pedido...")
                                        sleep(2)
                                        break
                                    } else {
                                        print("\nOpção Inválida! Tente novamente: ", terminator: "")
                                    }
                                }
                                
                                if finishShop {
                                    var sumCost = 0.0
                                    print("\n################################################")
                                    print("###                  PEDIDO                  ###")
                                    print("################################################")
                                    
                                    for (product,qtd) in selectProducts {
                                        print("###  \(qtd)x \(product.name)(\(numberFormatter(product.price))\t:\t \(numberFormatter(product.price*Double(qtd)))")
                                        sumCost += product.price*Double(qtd)
                                    }
                                    print("################################################")
                                    print("###                TOTAL:  \(numberFormatter(sumCost))")
                                    print("################################################\n")
                                    
                                    print("a - Continuar comprando")
                                    print("b - Finalizar pedido")
                                    print("c - Cancelar pedido\n")
                                    
                                    print("Informe a opção desejada: ", terminator: "")
                                    
                                    while true {
                                        let opConfim = readLine() ?? "erro"
                                        
                                        if opConfim == "a" {
                                            print("\n### Okay, continue comprando...")
                                            sleep(2)
                                            finishShop = false
                                            break
                                        } else if opConfim == "b" {
                                            
                                            var formPayment: FormPayment = .money// generic Value
                                            var cardPayment: CardPayment?// inicialização generica
                                            var selectedFormPayment = false
                                            
                                            while !selectedFormPayment {
                                                
                                                clientSession.myPayments();

                                                print("\n### Informe a opção de pagamento desejada ou digite '+' para adicionar um novo metodo de pagamento: ", terminator: "")
                                                
                                                let opFormPayment = readLine() ?? "erro"
                                                
                                                if let intOpFormPayment = Int(opFormPayment) {
                                                    if intOpFormPayment > 0 && intOpFormPayment <= clientSession.payments.count {
                                                        
                                                        formPayment = clientSession.payments[intOpFormPayment-1]
                                                        
                                                        if formPayment == .creditCard || formPayment == .debitCard {
                                                            var alterPayment = false

                                                            while !alterPayment {
                                                                
                                                                var contCard = 1
                                                                var myCards: [CardPayment] = []
                                                                
                                                                for card in clientSession.cardPayments {
                                                                    if card.formPayment == formPayment {
                                                                        print("\(contCard) - \(card.name) : \(card.cardNumber)")
                                                                        contCard+=1
                                                                        myCards.append(card)
                                                                    }
                                                                }
                                                                
                                                                if myCards.count > 0 {
                                                                    print("\n### Informe o \(formPayment.rawValue) desejado, ou digite '+' para adicionar um novo e 0 para voltar ao menu anterior: ", terminator: "")
                                                                    
                                                                    let opCard = readLine() ?? "erro"
                                                                    
                                                                    if let opIntCard = Int(opCard) {
                                                                        if opIntCard <= myCards.count {
                                                                            cardPayment = myCards[opIntCard-1]
                                                                            selectedFormPayment = true
                                                                            break
                                                                        } else {
                                                                            print("\n### Opção Inválida! Tente novamente: ", terminator: "")
                                                                        }
                                                                    } else if opCard == "*" {
                                                                        alterPayment = true
                                                                        break
                                                                    } else if opCard == "+" {
                                                                        clientSession.addCard(formPayment)
                                                                    } else {
                                                                        print("\n### Opção Inválida! Tente novamente: ", terminator: "")
                                                                    }
                                                                    
                                                                } else {
                                                                    
                                                                    while true {
                                                                        print("### Nenhum \(formPayment) encontrado! ")
                                                                        print("Digite '+' para adicionar um novo \(formPayment) ou digite 0 para voltar ao menu anterior: ", terminator: "")
                                                                        
                                                                        let opPayment = readLine() ?? "erro"
                                                                        
                                                                        if opPayment == "+" {
                                                                            clientSession.addCard(formPayment)
                                                                            break
                                                                        } else if opPayment == "0" {
                                                                            alterPayment = true
                                                                            break
                                                                        } else {
                                                                            print("\n### Opção Inválida! Tente novamente: ", terminator: "")
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        } else {
                                                            selectedFormPayment = true
                                                        }
                                                    } else{
                                                        print("\n### Opção inválida, tente novamente: ", terminator: "")
                                                    }
                                                } else if opFormPayment == "+" {
                                                    clientSession.addFormPayment()
                                                } else {
                                                    print("\n### Opção inválida, tente novamente: ", terminator: "")
                                                }
                                            }
                                            
                                            var cancelOrder = false
                                            var delivery: Localization? = nil
                                            
                                            if let deliveryLocalization = selectLocalization() {
                                                delivery = deliveryLocalization
                                            } else {
                                                cancelOrder = true
                                            }
                                            
                                            
                                            if cancelOrder {
                                                print("\n### Cancelando pedido...")
                                                sleep(2)
                                                break
                                            } else {
                                                addOrder(Order(client: clientSession, restaurant: restaurant, products: selectProducts, formPayment: formPayment, localization: delivery!, cardPayment: cardPayment))
                                            }
                                            
                                            print("\n### Pedido finalizado com sucesso!")
                                            sleep(2)
                                            listOrders()
                                            break
                                        } else if opConfim == "c" {
                                            print("\n### Cancelando pedido...")
                                            sleep(2)
                                            break
                                        } else {
                                            print("\n### Opção Inválida! Tente novamente: ", terminator: "")
                                        }
                                    }
                                }
                            }
                        } else {
                            print("## Opção inválida ## \n")
                            sleep(2)
                            print("Tente novamente: ", terminator: "")
                        }
                    } else {
                        print("## Opção inválida ## \n")
                        sleep(2)
                        print("Tente novamente: ", terminator: "")
                    }
                    
                }
            }
        } else {
            print("\n### Infelizmente não há produtos no cardapio do restaurante \(restaurant.name)\n")
        }

    }
    
    func printAllCategories() {
        var contCategories = 1

        print("\n#################################")
        print("###         CATEGORIAS        ###")
        print("#################################")
        
        for category in Category.allCases {
            print("### \(contCategories) : \(category.rawValue)")
            contCategories+=1
        }
                        
        print("#################################\n")
    }
    
    func listCategories() {
        
        while true {
            
            printAllCategories()
            
            print("\nSelecione uma das categorias acima, ou digite 0 para retornar ao inicio: ", terminator: "")
            let op = readLine() ?? "erro"
            
            if op == "0" {
                break
            } else {
                if let opInt = Int(op) {
                    if opInt <= Category.allCases.count {
                        listRestaurants(Category.allCases[opInt-1])
                        break
                    } else {
                        print("## Opção inválida ## \n")
                        sleep(2)
                        print("Tente novamente: ", terminator: "")
                    }
                } else {
                    print("## Opção inválida ## \n")
                    sleep(2)
                    print("Tente novamente: ", terminator: "")
                }
            }
        }
    }
    
    func listOrders() {
        var myOrders: [Order] = []
        
        print("\n################################################")
        print("###                  PEDIDOS                 ###")
        print("################################################")
        
        for order in orders {
            if order.client.CPF == clientSession.CPF {
                myOrders.insert(order, at: 0)
            }
        }
        
        if myOrders.count > 0 {
            for order in myOrders {
                order.printOrder()
            }
        } else {
            print("###     Você ainda não fez nenhum pedido     ###")
            print("################################################\n\n")
        }
        print()
        sleep(3)
    }
    
    func profile() {
        var inProfile = true
        
        while inProfile {
            print("\n#################################")
            print("###           PERFIL          ###")
            print("#################################\n")
            print("### Olá \(clientSession.name)\n")
            print("#################################")
            print("### 1 - Formas de pagamento   ###")
            print("### 2 - Endereços             ###")
            print("### 3 - Meus dados            ###")
            print("#################################")
            print("\nInforme a opção desejada, ou digite 0 pra voltar ao menu inicial: ", terminator: "")
            
            let opProfile = readLine() ?? "erro"
    
            switch opProfile {
            case "0":
                inProfile = false
            case "1":
                var inPayments = true
                while inPayments {
                    clientSession.myPayments()
                    print("Caso queira alterar ou deletar algum dos métodos de pagamento acima informe seu número correspondente")
                    print("Para adicionar uma nova forma de pagamento digite '+', ou digite 0 pra retornar ao menu anterior: ", terminator: "")
                    
                    let opPayment = readLine() ?? "erro"
                    
                    if let opIntPayment = Int(opPayment) {
                        if opIntPayment == 0 {
                            inPayments = false
                        } else if opIntPayment <= clientSession.payments.count {
                            
                            let formPayment = clientSession.payments[opIntPayment-1]
                            
                            if formPayment == .creditCard || formPayment == .debitCard{
                                
                                while true {
                                    
                                    let cards = clientSession.myCards(formPayment: formPayment)
                                    
                                    print("Digite '+' para adicionar um novo \(formPayment.rawValue) ou o indice de um cartão para remover-lo")
                                    print("Para retornar ao menu anterior digite 0: ", terminator: "")
                                    
                                    let opCard = readLine() ?? "erro"
                                    
                                    if let opIntCard = Int(opCard) {
                                        if opIntCard == 0 {
                                            break
                                        } else if opIntCard <= cards.count {
                                            clientSession.removeCard(cards[opIntCard-1])
                                        } else {
                                            print("\n### Opção inválida! Tente novamente\n")
                                        }
                                    } else if opCard == "+" {
                                        clientSession.addCard(formPayment)
                                    } else {
                                        print("\n### Opção inválida! Tente novamente\n")
                                    }
                                    
                                }
                            } else {
                                while true{
                                    print("\nPara deletar essa forma de pagamento digite '-', ou digite 0 pra retornar ao menu anterior: ", terminator: "")
                                    let opDeletePayment = readLine() ?? "erro"
                                    if opDeletePayment == "-" {
                                        print("\n### \(clientSession.payments[opIntPayment-1].rawValue) foi deletado da sua conta!\n")
                                        clientSession.payments.remove(at: opIntPayment-1)
                                        break
                                    } else if opDeletePayment == "0" {
                                        break
                                    } else {
                                        print("\n### Opção inválida! Tente novamente\n")
                                    }
                                }
                            }
                        } else {
                            print("\n### Opção inválida! Tente novamente\n")
                        }
                    } else if opPayment == "+" {
                        clientSession.addFormPayment()
                    } else {
                        print("\n### Opção inválida! Tente novamente\n")
                    }
                }
            case "2":
                var inMyLocalizations = true
                while inMyLocalizations {
                    clientSession.myLocalizations()
                    print("Caso queira alterar ou deletar algum dos endereços acima informe seu número correspondente")
                    print("Para adicionar um novo endereço digite '+', ou digite 0 pra retornar ao menu anterior: ", terminator: "")
                    
                    let opLocalization = readLine() ?? "erro"
                    
                    if let opIntLocalization = Int(opLocalization) {
                        if opIntLocalization == 0 {
                            inMyLocalizations = false
                        } else if opIntLocalization <= clientSession.localization.count {
                            var updatingLocalization = true
                            while updatingLocalization {
                                print("\n### \(clientSession.localization[opIntLocalization-1].descripiton)")
                                print("\n1 - Alterar")
                                print("2 - Deletar")
                                print("3 - Cancelar\n")
                                print("O que deseja fazer? ", terminator: "")
                                
                                if let opAlterLocalization = Int(readLine() ?? "erro") {
                                    switch opAlterLocalization {
                                    case 1:
                                        clientSession.localization[opIntLocalization-1].update()
                                        updatingLocalization = false
                                    case 2:
                                        clientSession.localization.remove(at: opIntLocalization-1)
                                        print("\n### Endereço removido com sucesso!")
                                        updatingLocalization = false
                                    case 3:
                                        updatingLocalization = false
                                    default:
                                        print("\n### Opção inválida! Tente novamente\n")
                                    }
                                } else {
                                    print("\n### Opção inválida! Tente novamente\n")
                                }
                            }
                            
                        } else {
                            print("\n### Opção inválida! Tente novamente\n")
                        }
                    } else if opLocalization == "+" {
                        let newLocalization = clientSession.addLocalization()
                        print("\n### Novo endereço adicionado com sucesso!!\n \(newLocalization.descripiton)")
                    } else {
                        print("### Opção inválida! Tente novamente\n")
                    }
                }
            case "3":
                var inMyData = true
                while inMyData {
                    clientSession.myDatas()
                    print("Caso queira alterar algum dos dados acima informe seu número correspondente, ou digite 0 pra retornar ao menu anterior: ", terminator: "")
                    let opData = readLine() ?? "erro"
            
                    switch opData {
                    case "0":
                        inMyData = false
                    case "1":
                        clientSession.updateName()
                    case "2":
                        clientSession.updateCPF()
                    case "3":
                        clientSession.updateEmail()
                    case "4":
                        clientSession.updateSenha()
                    default:
                        print("### Opção inválida! Tente novamente\n")
                    }
                }
            default:
                print("### Opção inválida! Tente novamente\n")
            }
        }
    }
    
    func selectLocalization() -> Localization? {

        while true {
            if clientSession.localization.count > 0 {
                clientSession.myLocalizations()
                
                print("\nSelecione o endereço de entrega ou x para cancelar pedido")
                print("Para adicionar um novo endereço digite '+' : ", terminator: "")
                
                let opDelivery = readLine() ?? "erro"
                
                if let opIntDelivery = Int(opDelivery) {
                    if opIntDelivery > 0 && opIntDelivery <= clientSession.localization.count {
                        return clientSession.localization[opIntDelivery-1]
                    } else {
                        print("\n### Opção inválida! Tente novamente")
                    }
                } else if opDelivery == "x" {
                    break
                } else if opDelivery == "+" {
                    var _ = clientSession.addLocalization()
                } else {
                    print("\n### Opção inválida! Tente novamente")
                }
            } else {
                while true {
                    print("\nNão há endereço de entrega cadastrado no seu perfil...")
                    print("\n### 1 - Adicionar endereço")
                    print("### 2 - Cancelar pedido")
                    
                    print("O que deseja fazer? ", terminator: "")
                    
                    if let opDelivery = Int(readLine() ?? "erro") {
                        if opDelivery == 1 {
                            var _ = clientSession.addLocalization()
                            break
                        } else if opDelivery == 2 {
                            break
                        } else {
                            print("\n### Opção inválida! Tente novamente")
                        }
                    } else {
                        print("\n### Opção inválida! Tente novamente")
                    }
                }
                
            }
            
        }
        return nil
    }
    
}
