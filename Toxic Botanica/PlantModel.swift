//
//  PlantModel.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/25/24.
//

import Foundation


struct Plant {
    let plantName: String
    let plantLatinName: String
    let wikipediaArticleName: String
    let description: String
    
    let isInvasive: Bool
    let isNative: Bool
    let isNoxious: Bool  //legal classification - has state or fed listed it as a 'dangerous plant'
    let isIllegal: Bool  
    let isToxicToEat: Bool    //toxicity is defined as fatal harm upon consumption - false value doesn't mean its edible
    let isToxicToTouch: Bool
    let isDestructiveToAgriculture: Bool
    let isHarmfulToNativeSpecies: Bool
    let isInfestingWaters: Bool
    let isPhototoxic: Bool   //phototoxic - causes burns to human/livestock
    
    let imageName: String?
    
}
