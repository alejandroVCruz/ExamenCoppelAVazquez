//
//  GetGuestSession.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 12/11/22.
//

import Foundation
final class GetGuestSession{
    func executeApi(){
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=acd2646bc68e6b8550024d0531803ef8")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            print("Response \(String(describing: response))")
            print("Error \(String(describing: error))")
        }.resume()
    }
}
