//
//  FormPayment.swift
//  #2 Nano Challange
//
//  Authors: Guilherme Antonini & Igor Vicente on 19/03/21.
//

import Foundation

enum FormPayment: String, CaseIterable {
   case creditCard = "Cartão de Crédito"
   case debitCard = "Cartão de Débito"
   case money = "Dinheiro"
   case applePay = "Apple Pay"
   case Pix
   case PayPal
}
