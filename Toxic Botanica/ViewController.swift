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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        plantTagCategories.dataSource = self
        plantTagCategories.delegate = self
        
        plantSearchBar.delegate = self
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

         return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "toPlantDetail", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    //did selection use index path
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)

        cell?.contentView.backgroundColor = .systemBlue
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)

        cell?.contentView.backgroundColor = .systemGray4
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlantDetail",
           let destinationVC = segue.destination as? PlantDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedPlant = plants[indexPath.row]
            print("Passing plant: \(selectedPlant.plantName)")
            destinationVC.userSelectedPlant = selectedPlant
        }
    }

}


