//
//  Login.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Antonini & Igor Vicente on 17/03/21.
//
import Foundation

func login(dataBase: DataBase) -> Client {
 
    while true {
        
        print("\n#################################")
        print("##             LOGIN           ##")
        print("#################################\n")
        
        print("E-mail: ", terminator: "")
        let email: String? = readLine() ?? ""
        
        print("Senha : ", terminator: "")
        let password: String? = readLine() ?? ""
        
        let finded = false
        
        for client in dataBase.clients {
            if client.email == email && client.password == password {
                print("\n\n### Olá, \(client.name) !")
                return client
            }
        }
        
        if !finded {
            print("\nCredenciais inválidas!\n")
            sleep(3)
            print("Vamos tentar novamente...\n")
            sleep(2)
        }
        
    }
        
}
