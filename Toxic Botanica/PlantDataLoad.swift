//
//  PlantDataLoad.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/25/24.
//


/* Ingested poison: wild hemlock, jack-in-the-pulpet, deadly nightshade, (green) false helleborne, pokeweed, buttercup, yue (conifer) germander, */
/* Skin-burn poison: Wild parsnip, giant hogweed*/
/* Skin-irrated poisons: Poison hemlock, poison ivy, poison oak*/


import Foundation

let giantHogweed = Plant(
    plantName: "Giant Hogweed",
    plantLatinName: "Heracleum Mantegazziaum",
    wikipediaArticleName: "heracleum_mantegazzianum",
    description: "A 15-foot tall relative of the parsnip. Its sap contains phototoxic compounds that can cause 3rd degree burns on contact with human skin.",
    isInvasive: true,
    isNative: false,
    isNoxious: true,
    isIllegal: true,
    isToxicToEat: true,
    isToxicToTouch:  true,
    isDestructiveToAgriculture: true,
    isHarmfulToNativeSpecies: true, //burns livestock
    isInfestingWaters: false,
    isPhototoxic: true,
    imageName: "giant_hogweed_flower"
)

let poisonHemlock = Plant(
    plantName: "Poison Hemlock",
    plantLatinName: "Conium Maculatum",
    wikipediaArticleName: "conium_maculatum",
    description: "An extremely toxic 5-foot plant with white, umbrella-likeflowers. Ingesting fives leaves is enough to induce death through respiratory muscle failure.",
    isInvasive: true,
    isNative: false,
    isNoxious: true,
    isIllegal: true,
    isToxicToEat: true,
    isToxicToTouch: true,
    isDestructiveToAgriculture: true, //kills livestock
    isHarmfulToNativeSpecies: true,
    isInfestingWaters: false,
    isPhototoxic: false,
    imageName: "poison_hemlock_flower"
)

let garlicMustard = Plant(
    plantName: "Garlic Mustard",
    plantLatinName: "Alliaria Petiolata",
    wikipediaArticleName: "alliaria_petiolata",
    description: "A 3-foot tall flowering plant with dense clusters of four-petaled white flowers. While edible, it is highly invasive and outcompetes native plants.",
    isInvasive: true,
    isNative: false,
    isNoxious: true,
    isIllegal: false,
    isToxicToEat: false,
    isToxicToTouch: false,
    isDestructiveToAgriculture: true,
    isHarmfulToNativeSpecies: true,
    isInfestingWaters: false,
    isPhototoxic: false,
    imageName: "garlic_mustard_flower"
)

let starryStonewart = Plant(
    plantName: "Starry Stonewort",
    plantLatinName: "Nitellopsis Obtusa",
    wikipediaArticleName: "nitelloposis_obtusa",
    description: "A stemmed, seaweed-like algae that forms dense, obstructive mats and is distingushable by its white flower-like bulbil",
    isInvasive: true,
    isNative: false,
    isNoxious: true,
    isIllegal: false,
    isToxicToEat: false,
    isToxicToTouch: false,
    isDestructiveToAgriculture: true, //harms fishing
    isHarmfulToNativeSpecies: true, //harms ecological system
    isInfestingWaters: true,
    isPhototoxic: false,
    imageName: "starry_stonewart_patch"
 )

let plants = [giantHogweed, poisonHemlock, garlicMustard, starryStonewart]



    
    
    
    
