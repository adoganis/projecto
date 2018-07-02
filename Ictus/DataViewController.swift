//
//  DataViewController.swift
//  Ictus
//
//  Created by Alexandros Doganis on 6/18/18.
//  Copyright © 2018 Alexandros Doganis. All rights reserved.
//

import UIKit
import CoreNFC

class DataViewController: UIViewController, NFCNDEFReaderSessionDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = "hello hello: placeholder for linkedin link"
    var nfcSession: NFCNDEFReaderSession?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }
    
    @IBAction func scanPressed(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Parse the card's information
        var result = "linked in link from settings."
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        
        DispatchQueue.main.async {
            self.messageLabel.text = result
    }


}
}
