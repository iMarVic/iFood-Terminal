//
//  main.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Antonini & Igor Vicente on 16/03/21.
//

import Foundation

var clientSession: Client
let dataBase = DataBase()

while true {
    print("\n#################################")
    print("###    Bem vinde ao 'iFood'   ###")
    print("#################################\n")
    
    print("### 1 - Login")
    print("### 2 - Cadastre-se")
    
    print("\nInforme a opção desejada: ", terminator: "")
    
    if let opInit = Int(readLine() ?? "erro") {
        if opInit == 1 {
            clientSession = login(dataBase: dataBase)
            home(dataBase: dataBase)
        } else if opInit == 2 {
            dataBase.createClient()
        }
    } else {
        print("\n### Opção inválida! Tente Novamente")
    }

}
