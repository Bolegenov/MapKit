//
//  ViewController.swift
//  Films
//
//  Created by Азамат Булегенов on 08.08.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelYear: UILabel!
    
    @IBOutlet weak var labelGenre: UILabel!
    
    @IBOutlet weak var labelBudget: UILabel!
    
    @IBOutlet weak var labelDescription: UILabel!
    
    var film = Films()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        labelName.text = film.name
        labelYear.text = film.year
        labelGenre.text = film.genre
        labelBudget.text = film.budget
        labelDescription.text = film.description
        imageview.image = UIImage(named: film.imagename)
    }


}

