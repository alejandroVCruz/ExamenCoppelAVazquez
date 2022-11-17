//
//  SessionIdViewModel.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 13/11/22.
//

import Foundation

class SessionIdViewModel{
    
   // var sessionId = SessionId(success: false, session_id: "")
    var requestToken = RequestToken(success: false, request_token: "", expires_at: "")
    
    func PostSessionId(idSession: Int, Id : @escaping (RequestToken? , Error?) -> Void){
        do{
            let decoder = JSONDecoder()
            let baseURL = "https://api.themoviedb.org/3/authentication/session/new?api_key=acd2646bc68e6b8550024d0531803ef8"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(idSession)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
                print("Data \(String(describing: data))")
                self.requestToken = try! decoder.decode(RequestToken.self, from: data)
                Id(self.requestToken, nil)
            }.resume()
        }
    }
}
