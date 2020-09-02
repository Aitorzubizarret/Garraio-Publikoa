//
//  ViewController.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 20/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    var mapsFromApple: MapsFromApple?
    var markerListViewModel: MarkerListViewModel = MarkerListViewModel()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMapsFromApple()
        
        self.bind()
        
        self.getLocalData()
    }
    
    ///
    /// Creates the MapsFromApple object and adds the received mapView to the main view.
    ///
    private func addMapsFromApple() {
        self.mapsFromApple = MapsFromApple() // Creates the object.
        
        guard let maps = self.mapsFromApple else { return }
        
        self.view.addSubview(maps.getMapView(size: self.view.bounds)) // Adds the view (with the maps enbedded) into our main view.
    }
    
    ///
    /// Gets new data from the ViewModel.
    ///
    private func bind() {
        self.markerListViewModel.binding = {
            for company in self.markerListViewModel.companyList {
                self.mapsFromApple?.addStops(stopList: company.stops)
                for line in company.lines {
                    self.mapsFromApple?.addLine(line: line)
                }
            }
        }
    }
    
    ///
    /// Gets  data from local JSON files.
    ///
    private func getLocalData() {
        self.markerListViewModel.getCompany(filename: FileName.bilbobus)
    }

}

