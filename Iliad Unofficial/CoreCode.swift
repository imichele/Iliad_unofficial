//
//  CoreCode.swift
//  Iliad Unofficial
//
//  Created by Michele Gravina on 11/06/18.
//  Copyright © 2018 Michele Gravina. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionHandler = (Int) -> Void

func doLogin(completionHandler: @escaping CompletionHandler) {
    
    var dataResult: Int = 0 // For completionHandler
    
    var urlHomeRequest = URLRequest(url: urlHomeIliad)
    urlHomeRequest.httpMethod = "POST"
    
    let postString = "login-ident=" + loginIdent + "&login-pwd=" + loginPwd
    
    urlHomeRequest.httpBody = postString.data(using: .utf8)
    
    Alamofire.request(urlHomeRequest)
        
        .response { (response) in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                htmlData = utf8Text as NSString
                
                // Checking if login or password are incorrect
                if htmlData.contains("ID utente o password") {
                    //                let loginCorrect = getDataFromHTML(pattern: "(?:ID utente o password )(.*)(?:.)", html: htmlData)
                    //                if loginCorrect[0] != "notFound" {
                    // Incorrect login or password
                    DispatchQueue.main.async {
                        dataResult = 0
                        print("    Incorrect login or password.")
                        completionHandler(dataResult)
                    }
                } else {
                    
                    let nomeCognomeTemp = getDataFromHTML(pattern: "(?:<div class=\"bold\">)(.*)(?:</div>)", html: htmlData)
                    nomeCognome = nomeCognomeTemp[0]
                    
                    let idUtenteTemp = getDataFromHTML(pattern: "(?:ID utente: )(.*)(?:</div>)", html: htmlData)
                    idUtente = Int(idUtenteTemp[0])!
                    
                    let numeroCellulareTemp = getDataFromHTML(pattern: "(?:Numero: )(.*)(?:\n *<a href=)", html: htmlData)
                    numeroCellulare = numeroCellulareTemp[0]
                    
                    let nomeOffertaTemp = getDataFromHTML(pattern: "(?:<div class=\"page p-conso\">\n *<h2>\n *<span class=\"bold\">)(.*)(?:</span>)", html: htmlData)
                    nomeOfferta = nomeOffertaTemp[0]
                    
                    let creditoTemp = getDataFromHTML(pattern: "(?:Credito : <b class=\"red\">)(.*)(?:€</b>)", html: htmlData)
                    credito = creditoTemp[0]
                    
                    let chiamateTemp = getDataFromHTML(pattern: "(?:Chiamate: <span class=\"red\">)(.*)(?:</span><br>)", html: htmlData)
                    italia.chiamate = chiamateTemp[0]
                    
                    let consumiVoceTemp = getDataFromHTML(pattern: "(?:Consumi voce: <span class=\"red\">)(.*)(?:€)", html: htmlData)
                    italia.consumiVoce = consumiVoceTemp[0]
                    
                    let datiTemp = getDataFromHTML(pattern: "(?:<div class=\"conso__text\">\n *<span class=\"red\">)(.*)(?:</span> / )", html: htmlData)
                    italia.dati = datiTemp[0]
                    print("ESTERO DATI: ", datiTemp[1])
                    
                    let consumoDatiTemp = getDataFromHTML(pattern: "(?:Consumi Dati: <span class=\"red\">)(.*)(?:€)", html: htmlData)
                    italia.consumoDati = consumoDatiTemp[0]
                    print("ESTERO CONSUMO DATI: ", consumoDatiTemp[1])
                    
                    let smsTemp = getDataFromHTML(pattern: "(?:<span class=\"red\">)(.*)(?: SMS</span)", html: htmlData)
                    italia.sms = Int(smsTemp[0])!
                    
                    let smsExtraTemp = getDataFromHTML(pattern: "(?:SMS extra: <span class=\"red\">)(.*)(?:€)", html: htmlData)
                    italia.smsExtra = smsExtraTemp[0]
                    
                    let mmsTemp = getDataFromHTML(pattern: "(?:<span class=\"red\">)(.*)(?: MMS)", html: htmlData)
                    italia.mms = Int(mmsTemp[0])!
                    estero.mms = Int(mmsTemp[1])!
                    
                    let consumiMmsTemp = getDataFromHTML(pattern: "(?:Consumi MMS: <span class=\"red\">)(.*)(?:€)", html: htmlData)
                    italia.consumiMms = consumiMmsTemp[0]
                    estero.consumiMms = consumiMmsTemp[1]
                    
                    print("Nome e cognome:", nomeCognome)
                    print("id Utente: ", idUtente)
                    print("Cellulare: ", numeroCellulare)
                    print("Offerta: ", nomeOfferta)
                    print("Credito: € ", credito)
                    print("Chiamate: ", italia.chiamate)
                    print("Consumi voce: € ", italia.consumiVoce)
                    print("Traffico dati: ", italia.dati)
                    print("Consumo dati € ", italia.consumoDati)
                    print("SMS: ", italia.sms)
                    print("SMS Extra: € ", italia.smsExtra)
                    print("MMS: ", italia.mms)
                    print("Consumi MMS: € ", italia.consumiMms)
                    
                    DispatchQueue.main.async {
                        dataResult = 1
                        print("    doLogin ended")
                        completionHandler(dataResult)
                    }
                } //
            }
    }
    
}

func getDataFromHTML(pattern: String, html: NSString) -> [String] {
    
    // La funzione restituisce un array di stringhe
    // recuperandole in base al pattern passato
    print(html)
    let expression = try! NSRegularExpression(pattern: pattern, options: [])
    let results = expression.matches(in: html as String, options: [], range: NSRange(location: 0, length: html.length))
    if results.count > 0 {
        let range = results.first!.range(at: 1)
        let r = results.map({ _ in htmlData.substring(with: range) })
        return r
    } else {
        return ["", "notFound", ""]
    }
    
    
}

