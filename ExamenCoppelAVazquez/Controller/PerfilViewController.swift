//
//  PerfilViewController.swift
//  ExamenCoppelAVazquez
//
//  Created by MacBookMBA3 on 16/11/22.
//

import UIKit

class PerfilViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var Nombre: UITextField!
    
    @IBOutlet weak var Usuario: UITextField!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //-----------------------------------------------------------
    var requestToken : String?
    //---------------------------------------
    
    private var sessionIdViewModel = SessionIdViewModel()
    private var sessionId : SessionId?
    //---------------------------------------------------------
    private var perfil : Perfil?
    private var IdSession : Int?
    
    //--------------------------------------------------------
    private var movieViewModel = MovieViewModel()
    private var movies : Movies?
    //---------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //GenerarId()
        
        movieViewModel.GetFavoriteMovies { movies, error in
            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "MovieCollectionViewCell")
        //-----------------------------------------------------------------
        
        var idUser : Session?
        guard let token = self.requestToken else{return}
        
        idUser = Session(request_token: token)

    let sessionIdViewModel = SessionIdViewModel()
        sessionIdViewModel.PostSessionId(idSession:  IdSession!) { result, data in
            DispatchQueue.main.async{
            //validar Succes y si es true //Realizar segues a view movies
                //self.Titulo.text = movie?.title
                //self.Nombre.text =
            
    
        }

            
        }
        

    }
    
}

extension PerfilViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.performSegue(withIdentifier: "DetalleMovie", sender: self)
        return true
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
        cell.Lenguaje.text = movie.originalLanguage
        cell.Descripcion.text = movie.overview
        return cell
    }
}
