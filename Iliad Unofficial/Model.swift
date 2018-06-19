//
//  Model.swift
//  Iliad Unofficial
//
//  Created by Michele Gravina on 12/06/18.
//  Copyright © 2018 Michele Gravina. All rights reserved.
//

import Foundation

let urlHomeIliad = URL(string: "https://www.iliad.it/account/")!

var loginIdent = String()
var loginPwd = String()

var htmlData = NSString()

var nomeCognome = String()
var idUtente = Int()
var numeroCellulare = String()
var nomeOfferta = String()
var credito = String()
var italia = consumi()
var estero = consumi()

struct consumi {
    var chiamate = String()
    var consumiVoce = String()
    var dati = String()
    var consumoDati = String()
    var sms = Int()
    var smsExtra = String()
    var mms = Int()
    var consumiMms = String()
    var consumoTotale = String()
    var creditoResiduo = String()
}

