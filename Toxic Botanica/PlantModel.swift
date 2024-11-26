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
    let isNoxious: Bool
    let isIllegal: Bool
    let isToxicToEat: Bool
    let isToxicToTouch: Bool
    let isDestructiveToAgriculture: Bool
    let isHarmfulToNativeSpecies: Bool
    let isInfestingWaters: Bool
    let isPhototoxic: Bool
    
    let imageName: String?
    
}
