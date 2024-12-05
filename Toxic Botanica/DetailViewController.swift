//
//  DetailViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/21/24.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    var userSelectedPlant: Plant? // Passed plant object
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var plantImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let plant = userSelectedPlant {
            if let imageName = plant.imageName {
                plantImageView.image = UIImage(named: imageName)
            } else {
                plantImageView.image = UIImage(named: "placeholder_image")
            }
            
            let plantNameLabel = UILabel()
            plantNameLabel.text = plant.plantName
            plantNameLabel.numberOfLines = 0
            plantNameLabel.lineBreakMode = .byWordWrapping
            
            let plantLatinNameLabel = UILabel()
            plantLatinNameLabel.text = userSelectedPlant?.plantLatinName
            plantLatinNameLabel.numberOfLines = 0
            plantLatinNameLabel.lineBreakMode = .byWordWrapping
            
            let plantDescriptionLabel = UILabel()
            plantDescriptionLabel.text = userSelectedPlant?.description
            plantDescriptionLabel.numberOfLines = 0
            plantDescriptionLabel.lineBreakMode = .byWordWrapping
            
            stackView.addArrangedSubview(plantNameLabel)
            stackView.addArrangedSubview(plantLatinNameLabel)
            stackView.addArrangedSubview(plantDescriptionLabel)
            
            if plant.isToxicToEat{
                let toxicToEatLabel = UILabel()
                toxicToEatLabel.text = "⚠️ \(plant.plantName) is toxic if ingested."
                toxicToEatLabel.numberOfLines = 0
                toxicToEatLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(toxicToEatLabel)
            }
            
            if plant.isToxicToTouch{
                let toxicToTouchLabel = UILabel()
                toxicToTouchLabel.text = "⚠️ \(plant.plantName) is toxic if touched."
                toxicToTouchLabel.numberOfLines = 0
                toxicToTouchLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(toxicToTouchLabel)
            }
            
            if plant.isInvasive && !plant.isNative{
                let invasiveLabel = UILabel()
                invasiveLabel.text = "\(plant.plantName) is invasive to the Eastern Temperate Forest region of the United States."
                invasiveLabel.numberOfLines = 0
                invasiveLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(invasiveLabel)
            }
            
            if plant.isNative && !plant.isInvasive{
                let nativeLabel = UILabel()
                nativeLabel.text = "\(plant.plantName) is native to the Eastern Temperate Forest region, but is considered to be a nuisance."
                nativeLabel.numberOfLines = 0
                nativeLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(nativeLabel)
            }
            
            if plant.isNoxious{
                let noxiousLabel = UILabel()
                noxiousLabel.text = "\(plant.plantName) is listed as a noxious species in at least one state. Under federal and state law, noxious plants are defined as overly aggressive, difficult to manage, parasitic, poisonous, or carriers/hosts of serious insects or diseases."
                noxiousLabel.numberOfLines = 0
                noxiousLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(noxiousLabel)
            }
            
            if plant.isIllegal{
                let illegalLabel = UILabel()
                illegalLabel.text = "\(plant.plantName) is illegal to plant in at least one US state"
                illegalLabel.numberOfLines = 0
                illegalLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(illegalLabel)
            }
            
            if plant.isHarmfulToNativeSpecies{
                let nativeSpeciesHarmLabel = UILabel()
                nativeSpeciesHarmLabel.text = "\(plant.plantName) is harmful to native species."
                nativeSpeciesHarmLabel.numberOfLines = 0
                nativeSpeciesHarmLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(nativeSpeciesHarmLabel)
            }
            
            if plant.isDestructiveToAgriculture{
                let agricultureHarmLabel = UILabel()
                agricultureHarmLabel.text = "\(plant.plantName) is harmful to agriculture."
                agricultureHarmLabel.numberOfLines = 0
                agricultureHarmLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(agricultureHarmLabel)
            }
            
            if plant.isInfestingWaters{
                let waterwayHarmLabel = UILabel()
                waterwayHarmLabel.text = "\(plant.plantName) is harmful to agriculture."
                waterwayHarmLabel.numberOfLines = 0
                waterwayHarmLabel.lineBreakMode = .byWordWrapping
                stackView.addArrangedSubview(waterwayHarmLabel)
            }
        

        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWikipediaArticle",
           let destinationVC = segue.destination as? WikipediaViewController {
            destinationVC.selectedPlant = userSelectedPlant?.wikipediaArticleName
        }
    }
    


}
