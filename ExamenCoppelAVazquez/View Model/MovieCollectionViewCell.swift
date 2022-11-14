//
//  MovieCollectionViewCell.swift
//  ExamenCoppelAVazquez
//
//  Created by Digis01 Soluciones Digitales on 13/11/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var Titulo: UILabel!
    
    @IBOutlet weak var Fecha: UILabel!
    
    @IBOutlet weak var Calificacion: UILabel!
    
    @IBOutlet weak var Descripcion: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
