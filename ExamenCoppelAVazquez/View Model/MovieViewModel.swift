//
//  MovieViewModel.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 13/11/22.
//

import Foundation

class MovieViewModel {
     //TODOS Métodos referentes a Movies
    
    func GetFavoriteMovies(movie : @escaping (Movies , Error?) -> Void){
                let urlSession = URLSession.shared
                let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/account/favorite/movies?api_key=acd2646bc68e6b8550024d0531803ef8&session_id=04b6506bffcbe5fac2387503c16640a39c544cdd&language=en-US&sort_by=created_at.asc&page=1")
                    urlSession.dataTask(with: url!){ data, response, error in
                    print("Data \(String(describing: data))")
                    
                        if let data = data {
                            let json = try? JSONSerialization.jsonObject(with: data)
        //                    print(String(describing: json))
                            let movies = try! decoder.decode(Movies.self, from: data)
                            movie(movies, nil)
                        }
                       
                    }.resume()
            }
    
    
    func GetPopularMovie(movie : @escaping (Movies , Error?) -> Void){
            let urlSession = URLSession.shared
            let decoder = JSONDecoder()
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=acd2646bc68e6b8550024d0531803ef8&language=en-US&page=1")
            urlSession.dataTask(with: url!){ data, response, error in
                print("Data \(String(describing: data))")
                
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data)
//                    print(String(describing: json))
                    let movies = try! decoder.decode(Movies.self, from: data)
                    movie(movies, nil)
                }
               
            }.resume()
        }
    
    func GetTopRatedMovie(movie : @escaping (Movies , Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=acd2646bc68e6b8550024d0531803ef8&language=en-US&page=1")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
             //   print(String(describing: json))
                let movies = try! decoder.decode(Movies.self, from: data)
                movie(movies, nil)
            }
           
        }.resume()
    }
}
