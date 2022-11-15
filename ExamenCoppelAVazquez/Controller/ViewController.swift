//
//  ViewController.swift
//  ExamenCoppelAVazquez
//
//  Created by MacBookMBA3 on 11/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Usuario: UITextField!
    
    @IBOutlet weak var Contraseña: UITextField!
    
    
    private var requestTokenViewModel = RequestTokenViewModel()
    private var sessionIdViewModel = SessionIdViewModel()
    
    private var requestToken : RequestToken?  // TODO PROYECTO - NECESITA SER GUARDADO EN UN KEYCHAIN USERDEFAULT (SAVE OBJECT COMPLEX)
    private var sessionId : SessionId?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GenerarToken()
        //GenerarId()
    }
    
    
    @IBAction func Ingresar(_ sender: Any) {
//        let alert = UIAlertController(title: "Enviar datos", message: "Se enviara la informacion", preferredStyle: .alert)
         var user : User?
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
//            action in
            guard let usuario = self.Usuario.text else {print("Usuario no valido"); return}
            guard let contraseña = self.Contraseña.text else {print("Contraseña no valida"); return}
            guard let token = self.requestToken?.request_token else{return}
            
            user = User(username: usuario, password: contraseña, request_token: token)
           
//}))
        let userViewModel = UserViewModel()
        userViewModel.Login(user: user!) { result, data in
            DispatchQueue.main.async {
                //validar Succes y si es true //Realizar segues a view movies
        
                if userViewModel.requestToken.success {
                    let alert = UIAlertController(title: "DATOS CORRECTOS", message: "BIENVENIDO", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.performSegue(withIdentifier: "MOVIE", sender: self)
                    
                }else{
                    let alert = UIAlertController(title: "SUCCESS FALSE", message: "HUBO UN ERROR A LA HORA DE INGRESAR", preferredStyle: UIAlertController.Style.alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                }
            }

                
            }
        }
        
    
    
    func GenerarToken(){
        requestTokenViewModel.GetRequestToken { object, error in
            guard let _ = object else {
                print("Error")
                return
            }
            self.requestToken = object
        }
    }
   // func GenerarId(){
       // sessionIdViewModel.GetSessionId { object1, error in
         //   guard let _ = object1 else {
           //     print("Error")
             //   return
           // }
            //self.sessionId = object1
        //}
    //}
  

}

