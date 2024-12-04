//
//  WikipediaViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/26/24.
//  Note: Heavily relies on the code from this tutorial
//  https://developer.apple.com/documentation/uikit/views_and_controls/using_swiftui_with_uikit

import UIKit
import SwiftUI

class WikipediaViewController: UIViewController {
    var selectedPlant: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = WikipediaView(selectedPlant: selectedPlant ?? "nil")

        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
