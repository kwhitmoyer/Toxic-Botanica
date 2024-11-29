//
//  ViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/21/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        let plant = plants[indexPath.row]
        cell.textLabel?.text = plant.plantName
        cell.detailTextLabel?.text = plant.plantLatinName
        guard let imageName = plant.imageName else{
            cell.imageView?.image = UIImage(named: "placeholder_image")
            return cell
        }
        cell.imageView?.image = UIImage(named: imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "toPlantDetail", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlantDetail",
           let destinationVC = segue.destination as? PlantDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedPlant = plants[indexPath.row]
            print("Passing plant: \(selectedPlant.plantName)")
            destinationVC.userSelectedPlant = selectedPlant
        } else {
            print("Segue identifier does not match or destinationVC is not PlantDetailViewController")
        }
    }


}

