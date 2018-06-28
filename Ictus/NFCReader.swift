//
//  NFCReader.swift
//  Ictus
//
//  Created by Amar on 6/21/18.
//  Copyright © 2018 Alexandros Doganis. All rights reserved.
// leave this file alone for now. it doesnt do anything just as yet.. 

import Foundation
import CoreNFC

class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                print("New Record Found:")
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC NDEF Invalidated")
        print("\(error)")
    }
    func beginSession() {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.begin()
    }
}

