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
    public func addStops(stopList: [Stop]) {
        for stop in stopList {
            self.addStop(stop: stop)
        }
    }
    
    ///
    /// Adds a line in the maps.
    ///
    public func addLine(line: Line) {
        
        // The color of the line.
        var lineColor: UIColor? = convertHexToUIColor(hex: line.color)
        
        for direction in line.directions {
            var polyline = direction.polyline
            var coordinates: [CLLocationCoordinate2D] = []
            
            while polyline.count != 0 {
                let lat: Double = polyline.last ?? 0
                polyline = polyline.dropLast()
                let lng: Double = polyline.last ?? 0
                polyline = polyline.dropLast()
                
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                coordinates.append(coordinate)
            }
            
            // Creates a polyline with the coordinates and sets the color of the line.
            let overlay = CustomPolyline(coordinates: &coordinates, count: coordinates.count)
            overlay.color = lineColor
            
            self.mapView?.addOverlay(overlay)
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
        
        let color: UIColor = convertHexToUIColor(hex: "99cc13") ?? UIColor.black
        markerView!.image = MapMarker().createSmallRoundedImageWithColor(color: color)
        
        return markerView
    }
    
    
    ///
    /// Method to draw the polyline in the map.
    ///
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: CustomPolyline.self) {
            let customPolyline: CustomPolyline = overlay as! CustomPolyline
            let polylineColor: UIColor = customPolyline.color ?? UIColor.black
            
            let polyLineRenderer = MKPolylineRenderer(overlay: customPolyline)
            polyLineRenderer.strokeColor = polylineColor
            
            // Line Dashed
            //polyLineRenderer.lineDashPhase = 2
            //polyLineRenderer.lineDashPattern = [NSNumber(value: 4), NSNumber(value: 10)]
            polyLineRenderer.lineWidth = 6.0
            
            return polyLineRenderer
        }
        
        return MKPolylineRenderer()
    }
    
    
}
