//
//  ViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/21/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plantSearchBar: UISearchBar!
    @IBOutlet weak var plantTagCategories: UICollectionView!
    
    var searchedPlants: [Plant] = []
    var userIsSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table view stores list of plants
        tableView.dataSource = self
        tableView.delegate = self
        
        //Collection view stores plant catagory buttons
        plantTagCategories.dataSource = self
        plantTagCategories.delegate = self
        
        //Provides search feature
        plantSearchBar.delegate = self
        
        //Gesture - a two finger touch to a cell containing a plant in viewController will
        //   go directly to the wikipedia tab
        let touchTwiceWikipedia = UITapGestureRecognizer(target: self, action: #selector(touchTwiceWikipedia(_:)))
        touchTwiceWikipedia.numberOfTouchesRequired = 2
        touchTwiceWikipedia.numberOfTapsRequired = 1
        tableView.addGestureRecognizer(touchTwiceWikipedia)
    }
    
    
    @objc func touchTwiceWikipedia(_ gestureRecognizer: UITapGestureRecognizer){
        let touchLocation = gestureRecognizer.location(in: tableView)
        
        //acccounts for case in which user is searching for a plant and
        //   therefore has reduced index of table cells due to filtering
        if let indexPath = tableView.indexPathForRow(at: touchLocation){
            let userSelectedPlant: Plant
            if userIsSearching {
                userSelectedPlant = searchedPlants[indexPath.row]
            } else {
                userSelectedPlant = plants[indexPath.row]
            }
            
            performSegue(withIdentifier: "toWikipedia", sender: userSelectedPlant)
        }
    }
    
    func plantNameMatch(_ text: String, query: String) -> Bool {
        let matchText = text.range(of: query, options: .caseInsensitive) != nil
        return matchText
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            userIsSearching = false
            searchedPlants.removeAll()
        } else {
            userIsSearching = true
            searchedPlants = plants.filter { plant in
                plantNameMatch(plant.plantName, query: searchText) ||
                plantNameMatch(plant.plantLatinName, query: searchText)
            }
        }
        
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userIsSearching{
            return searchedPlants.count
        } else{
            return plants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        let plant: Plant
        if userIsSearching {
            plant = searchedPlants[indexPath.row]
        } else {
            plant = plants[indexPath.row]
        }
        
        cell.textLabel?.text = plant.plantName
        cell.detailTextLabel?.text = plant.plantLatinName
    
        if let imageName = plant.imageName {
            cell.imageView?.image = UIImage(named: imageName)
        } else {
            cell.imageView?.image = UIImage(named: "placeholder_image")
        }
        
        cell.layer.masksToBounds = true
        cell.selectionStyle = .blue
        
        cell.imageView?.layer.cornerRadius = 1
        cell.imageView?.layer.masksToBounds = true
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "toPlantDetail", sender: indexPath)
    }
    
    //Collection view containing plant catagory buttons
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Number of catagories is known and configured in storyboard
        return 10
    }
    
    //Customizes cell. Project handles most cell customation through storyboard file, however,
    //   I am too afraid to remove this potentially redudant code right before the deadline
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell? = nil
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "invasive", for: indexPath)
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "native", for: indexPath)
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noxious", for: indexPath)
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "illegal", for: indexPath)
        case 4:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toxic to eat", for: indexPath)
        case 5:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toxic to touch", for: indexPath)
        case 6:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "danger to agriculture", for: indexPath)
        case 7:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "danger to native species", for: indexPath)
        case 8:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infests waters", for: indexPath)
        case 9:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phototoxic", for: indexPath)
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "invasive", for: indexPath)
        }
        
        cell?.contentView.layer.cornerRadius = 8
        cell?.contentView.layer.masksToBounds = true
        cell?.contentView.backgroundColor = .systemGray4
        
        return cell ?? UICollectionViewCell()
    }
    
    //Handles logic for filtering 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .systemBlue
        }
        
        let selectedFilter: String
        switch indexPath.item {
        case 0:
            selectedFilter = "invasive"
        case 1:
            selectedFilter = "native"
        case 2:
            selectedFilter = "noxious"
        case 3:
            selectedFilter = "illegal"
        case 4:
            selectedFilter = "toxic to eat"
        case 5:
            selectedFilter = "toxic to touch"
        case 6:
            selectedFilter = "danger to agriculture"
        case 7:
            selectedFilter = "danger to native species"
        case 8:
            selectedFilter = "infests waters"
        case 9:
            selectedFilter = "phototoxic"
        default: return
        }
        
        searchedPlants.removeAll()
        
        for plant in plants {
            switch selectedFilter {
            case "invasive":
                if plant.isInvasive{
                    searchedPlants.append(plant)
                }
            case "native":
                if plant.isNative{
                    searchedPlants.append(plant)
                }
            case "noxious":
                if plant.isNoxious{
                    searchedPlants.append(plant)
                }
            case "illegal":
                if plant.isIllegal{
                    searchedPlants.append(plant)
                }
            case "toxic to eat":
                if plant.isToxicToEat{
                    searchedPlants.append(plant)
                }
            case "toxic to touch":
                if plant.isToxicToTouch{
                    searchedPlants.append(plant)
                }
            case "danger to agriculture":
                if plant.isDestructiveToAgriculture{
                    searchedPlants.append(plant)
                }
            case "danger to native species":
                if plant.isHarmfulToNativeSpecies{
                    searchedPlants.append(plant)
                }
            case "infests waters":
                if plant.isInfestingWaters{
                    searchedPlants.append(plant)
                }
            case "phototoxic":
                if plant.isPhototoxic{
                    searchedPlants.append(plant)
                }
            default:
                break
            }
        }
        
        userIsSearching = true
        
        tableView.reloadData()
        
    }
    
    //when a catagory button is deselected
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .systemGray4
        }
        
        userIsSearching = false
        searchedPlants.removeAll()
        plantSearchBar.text = ""
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlantDetail",
           let destinationVC = segue.destination as? PlantDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedPlant: Plant
            if userIsSearching {
                selectedPlant = searchedPlants[indexPath.row]
            } else {
                selectedPlant = plants[indexPath.row]
            }
            
            print("Passing plant: \(selectedPlant.plantName)")
            destinationVC.userSelectedPlant = selectedPlant
        }
        
        //seque triggered by double tap
        else if segue.identifier == "toWikipedia",
           let destinationVC = segue.destination as? WikipediaViewController,
           let selectedPlant = sender as? Plant {
            
            destinationVC.selectedPlant = selectedPlant.wikipediaArticleName
        }
        
        
        
    }
    
    
}
