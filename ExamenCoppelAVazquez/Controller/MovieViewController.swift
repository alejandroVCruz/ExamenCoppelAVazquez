//
//  MovieCollectionViewController.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 12/11/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieViewController: UIViewController, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var movieViewModel = MovieViewModel()
    private var movies : Movies?
    private var movie : [Movie] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    @IBAction func GetMoviePopular(_ sender: UIButton) {
        movieViewModel.GetPopularMovie { movies, error in

            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func GetMovieTopRated(_ sender: UIButton) {
        movieViewModel.GetTopRatedMovie { movies, error in
            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}
extension MovieViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie: Movie = movies!.results![indexPath.row]
        
        if let url = URL( string:("https://image.tmdb.org/t/p/w1280" + (movies?.results?[indexPath.row].posterPath)!))
        {
            DispatchQueue.global().async {
              if let data = try? Data( contentsOf:url)
              {
                DispatchQueue.main.async {
                    cell.Imagen.image = UIImage( data:data)
                }
              }
           }
        }

        cell.Titulo.text = movie.title
        cell.Fecha.text = movie.releaseDate
        //cell.Calificacion.text = movie.voteAverage
        cell.Descripcion.text = movie.overview
        return cell
    }
    

}

