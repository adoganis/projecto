//
//  NFCReader.swift
//  Ictus
//
//  Created by Rishabh on 6/21/18.
//  Copyright © 2018 Alexandros Doganis. All rights reserved.
// leave this file alone for now. it doesnt do anything just as yet.. 

import CoreNFC

protocol NFCScannerProtocol: class {
    var scannerSession: NFCReaderSession? { get set }
    func startSession()
}

class NFCScanner: NSObject, NFCScannerProtocol {
    var scannerSession: NFCReaderSession?
    
    func startSession() {
        if let session = scannerSession {
            session.invalidate()
            scannerSession = nil
        }
        scannerSession = NFCNDEFReaderSession(delegate: self,
                                              queue:nil,
                                              invalidateAfterFirstRead:false)
        scannerSession?.begin()
    }
    
}

extension NFCScanner: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("reader session invalidate with error: \(error.localizedDescription)")
        if session == scannerSession {
            scannerSession = nil
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("reader session did detect NDEFs messages: \(messages)")
    }
    
}
