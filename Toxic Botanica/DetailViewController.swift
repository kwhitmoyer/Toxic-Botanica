//
//  DetailViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/21/24.  
//

import UIKit

class PlantDetailViewController: UIViewController {
    var selectedPlant: String?
    
    @IBOutlet weak var plantCommonName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let plantName = selectedPlant {
            plantCommonName.text = plantName
        }
        
    }
}
