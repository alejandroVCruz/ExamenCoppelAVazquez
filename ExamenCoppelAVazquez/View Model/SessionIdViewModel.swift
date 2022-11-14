//
//  SessionIdViewModel.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 13/11/22.
//

import Foundation

class SessionIdViewModel{
    
    var sessionId = SessionId(success: false, sessionID: "")

    func GetSessionId(Id : @escaping (SessionId? , Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=acd2646bc68e6b8550024d0531803ef8")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")

            guard let data = data else {
                return
            }
            
            self.sessionId = try! decoder.decode(SessionId.self, from: data)
            Id(self.sessionId, nil)
            
        }.resume()
    }
}
