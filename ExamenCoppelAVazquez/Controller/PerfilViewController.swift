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
    private var IdSession : String?
    
    //--------------------------------------------------------
    private var movieViewModel = MovieViewModel()
    private var movies : Movies?
    private var movie : Movie?
    //---------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
        
    }
    
    func loadData(){
        //-----------------------------------------------------------------------------
        var idUser : Session?
        
        guard let token = UserDefaults.standard.object(forKey: "requestToken") as? String else{
            return
        }
        idUser = Session(request_token: token)
        let sessionIdViewModel = SessionIdViewModel()
        //print(perfil.requestToken)
        sessionIdViewModel.PostSessionId(requestToken: idUser!) { sessionId, error in
            DispatchQueue.main.async{
            //validar Succes y si es true //Realizar segues a view movies
                
                self.IdSession = sessionId?.session_id
                
                self.loadData2()
                
        }
        }
        //sessionIdViewModel.PostSessionId(idSession:  IdSession!) { result, data in

        
    }
    func loadData2(){
        //---------------------------------------------------------------------------------
            movieViewModel.GetFavoriteMovies(idSession: IdSession!) { movies, error in
                self.perfil = movies
                DispatchQueue.main.async {
                    self.Nombre.text = self.perfil?.name
                    self.Usuario.text = self.perfil?.username
                    
                    //3er servicio de favoritos
                   
                }
            }
        
    }
    
    func loadData3(){
        self.collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "MovieCollectionViewCell")
        //-----------------------------------------------------------------
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
