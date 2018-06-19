//
//  Italia.swift
//  Iliad Unofficial
//
//  Created by Michele Gravina on 14/06/18.
//  Copyright © 2018 Michele Gravina. All rights reserved.
//

import UIKit

class Italia: UIViewController {

    @IBOutlet weak var chiamate: UILabel!
    @IBOutlet weak var consumiVoce: UILabel!
    @IBOutlet weak var sms: UILabel!
    @IBOutlet weak var smsExtra: UILabel!
    @IBOutlet weak var dati: UILabel!
    @IBOutlet weak var consumiDati: UILabel!
    @IBOutlet weak var mms: UILabel!
    @IBOutlet weak var consumiMms: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chiamate.text = italia.chiamate
        consumiVoce.text = italia.consumiVoce
        sms.text = String(italia.sms)
        smsExtra.text = italia.smsExtra
        dati.text = italia.dati
        consumiDati.text = italia.consumoDati
        mms.text = String(italia.mms)
        consumiMms.text = italia.consumiMms
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
