//
//  MapsFromApple.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 20/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit
import MapKit

class MapsFromApple: NSObject {
    
    // MARK: - Properties
    
    private var mapView:MKMapView? // The view with the embedded Apple Maps.
    
    // MARK: - Methods
    
    ///
    /// Creates the MKMapView with the received size and saves it in 'mapView' property.
    ///
    /// - Parameter size : The size of the view.
    ///
    private func initialize(size: CGRect) {
        self.mapView = MKMapView(frame: size)
        self.mapView?.delegate = self // MKMapViewDelegate
        
        self.setDefaultCenterPoint()
    }
    
    ///
    /// Sets the default center point of the map.
    /// The data came from the MapConfigurator object.
    ///
    private func setDefaultCenterPoint() {
        // Check optional.
        guard let mapView = self.mapView else { return }
        
        // Get default data from MapConfiguration object.
        let lat: Double = MapConfiguration().centerPointLat
        let lng: Double = MapConfiguration().centerPointLng
        let centerCoordinate = CLLocationCoordinate2DMake(lat, lng)
        let latMeters: Double = MapConfiguration().latitudinalMeters
        let lngMeters: Double = MapConfiguration().longitudinalMeters
        
        // Create the region and set it to the map view.
        let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: latMeters, longitudinalMeters: lngMeters)
        mapView.setRegion(region, animated: true)
    }
    
    ///
    /// Calls 'initialize' method with the received size to create the Map and sends back the mapView as UIView.
    ///
    /// - Parameter size: The size of the view.
    /// - Returns: A UIView.
    ///
    public func getMapView(size: CGRect) -> UIView {
        self.initialize(size: size)
        
        if let mapView = self.mapView {
            return mapView
        } else {
            let errorView: UIView = UIView(frame: size)
            errorView.backgroundColor = UIColor.red
            return errorView
        }
    }
    
    ///
    /// Adds a marker in the maps.
    /// - Parameter id: The id that will be shown.
    /// - Parameter lat: Latitude of the marker.
    /// - Parameter lng: Longitude of the marker.
    ///
    public func addMarker(id asTitle: String, lat: Double, lng: Double) {
        let marker = MKPointAnnotation()
        marker.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = asTitle
        
        self.mapView?.addAnnotation(marker)
    }
    
    ///
    /// Adds a marker in the maps.
    /// - Parameter id: The id that will be shown.
    /// - Parameter lat: Latitude of the marker.
    /// - Parameter lng: Longitude of the marker.
    ///
    public func addStop(stop: Stop) {
//        let stop = MKPointAnnotation()
//        stop.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//        stop.title = asTitle
//
//        self.mapView?.addAnnotation(stop)
        
        if let doubleLat = Double(stop.lat), let doubleLng = Double(stop.lng) {
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLng)
            let customMarker: CustomMarker = CustomMarker(coordinate: coordinate, title: stop.name, subtitle: "", companyId: "", stopId: stop.id)
            
            self.mapView?.addAnnotation(customMarker)
        }
    }
    
    ///
    /// Adds a marker list in the maps.
    ///
    public func addMarkers(markerList: [Marker]) {
        for marker in markerList {
            self.addMarker(id: marker.id, lat: marker.lat, lng: marker.lng)
        }
    }
    
    ///
    /// Adds a marker list in the maps.
    ///
    public func addStops(stopList: [Stop]) {
        for stop in stopList {
            self.addStop(stop: stop)
        }
    }
    
}

extension MapsFromApple: MKMapViewDelegate {
    
    ///
    /// Method to draw the markers in the map.
    ///
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier: String = "customMarker"
        
        var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if markerView == nil {
            markerView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            markerView!.canShowCallout = true // Shows the annotation title after tapping on the annotation icon.
        } else {
            markerView!.annotation = annotation
        }
        
        let color: UIColor = convertHexToUIColor(hex: "FFF") ?? UIColor.black
        markerView!.image = MapMarker().createSmallRoundedImageWithColor(color: color)
        
        return markerView
    }
}
