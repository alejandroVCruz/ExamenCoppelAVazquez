//
//  PerfilViewModel.swift
//  ExamenCoppelAVazquez
//
//  Created by MacBookMBA3 on 16/11/22.
//

import Foundation

class PerfilViewModel{
    //TODOS Métodos referentes a Movies
    func GetDetail(idSession: String , perfilDetail : @escaping (Perfil , Error?) -> Void){
            let urlSession = URLSession.shared
            let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/account?api_key=acd2646bc68e6b8550024d0531803ef8&session_id=\(idSession)")
            urlSession.dataTask(with: url!){ data, response, error in
                print("Data \(String(describing: data))")
                
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data)
//                    print(String(describing: json))
                    let perfil = try! decoder.decode(Perfil.self, from: data)
                    perfilDetail(perfil, nil)
                }
               
            }.resume()
        }
    
}
