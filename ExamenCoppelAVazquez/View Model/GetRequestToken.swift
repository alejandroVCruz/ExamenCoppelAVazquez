//
//  GetRequestToken.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 12/11/22.
//

import Foundation

struct Token: Decodable{
    let request_token : String
    
    enum CodingKeys: String, CodingKey{
        case request_token = "request_token"
    }
}
extension Token{
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.request_token = try container.decode(String.self, forKey: .request_token)
    }
}



