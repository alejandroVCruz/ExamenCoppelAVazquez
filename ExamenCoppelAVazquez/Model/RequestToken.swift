//
//  RequestToken.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 13/11/22.
//

import Foundation

struct RequestToken: Codable{
    let success : Bool
    let request_token : String
    let expires_at : String
}

