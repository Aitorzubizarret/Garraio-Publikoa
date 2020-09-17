//
//  ViewController.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 20/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    // MARK: - Properties
    var mapsFromApple: MapsFromApple?
    var markerListViewModel: MarkerListViewModel = MarkerListViewModel()
    var infoPanel: InfoPanelViewController!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMapsFromApple()
        
        self.bind()
        
        self.getLocalData()
        
        self.addInfoPanel()
    }
    
    ///
    /// Creates the MapsFromApple object and adds the received mapView to the main view.
    ///
    private func addMapsFromApple() {
        self.mapsFromApple = MapsFromApple() // Creates the object.
        
        guard let maps = self.mapsFromApple else { return }
        
        self.view.addSubview(maps.getMapView(size: self.view.bounds)) // Adds the view (with the maps enbedded) into our main view.
        
        self.mapsFromApple?.actionsDelegate = self // This view controller will be the delegate of the 'MapsAction' protocol.
    }
    
    ///
    /// Gets new data from the ViewModel.
    ///
    private func bind() {
        self.markerListViewModel.binding = {
            for company in self.markerListViewModel.companyList {
                self.mapsFromApple?.addCompany(company: company)
            }
        }
    }
    
    ///
    /// Gets  data from local JSON files.
    ///
    private func getLocalData() {
        /*
        self.markerListViewModel.getCompany(filename: FileName.bilbobus)
    }
    
    ///
    /// Creates the ViewController to show the info of the stop.
    ///
    private func addInfoPanel() {
        // Creates de ViewController.
        infoPanel = InfoPanelViewController(nibName: "InfoPanelViewController", bundle: nil)
        
        // Adds the ViewController as a child and adds the view of the ViewController to the main view.
        self.addChild(infoPanel)
        self.view.addSubview(infoPanel.view)
        
        // Properties of the view.
        infoPanel.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
        infoPanel.view.layer.cornerRadius = 24
        infoPanel.view.layer.borderWidth = 1
        infoPanel.view.layer.borderColor = UIColor.lightGray.cgColor
        infoPanel.view.clipsToBounds = true
    }
}

///
/// MapsActions
///
extension MapViewController: MapsActions {
    func showInfoPanel(marker: CustomMarker?) {
        
        // Updates the label of the InfoPanel.
        infoPanel.stopNameLabel.text = marker?.title
        infoPanel.companyNameLabel.text = marker?.companyName
        
        // Animates the InfoPanel frame position to show the view.
        UIView.animate(withDuration: 0.24) {
            self.infoPanel.view.frame.origin.y = self.view.frame.height - 300
        }
    }
    
    func hideInfoPanel() {
        // // Animates the InfoPanel frame position to hide the view.
        UIView.animate(withDuration: 0.24) {
            self.infoPanel.view.frame.origin.y = self.view.frame.height
        }
    }
}
