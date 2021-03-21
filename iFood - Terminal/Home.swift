//
//  Home.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Antonini & Igor Vicente on 18/03/21.
//

func home(dataBase: DataBase) {
    
    var logado = true
    
    while logado {
        print("\n#################################")
        print("##           INICIO            ##")
        print("#################################")
        print("##  1 - Restaurantes           ##")
        print("##                             ##")
        print("##  2 - Categorias             ##")
        print("##                             ##")
        print("##  3 - Pedidos                ##")
        print("##                             ##")
        print("##  4 - Perfil                 ##")
        print("##                             ##")
        print("##  5 - Sair                   ##")
        print("#################################\n")

        print("\nSelecione uma das opções acima: ", terminator: "")
        
        switch readLine() ?? "" {
        case "1":
            dataBase.listRestaurants()
        case "2":
            dataBase.listCategories()
        case "3":
            dataBase.listOrders()
        case "4":
            dataBase.profile()
        case "5":
            print("\n### Saindo...")
            logado = false
        default :
            print("\n### Opção Inválida! Tente Novamente...\n")
        }
    }
    
    
    
}
