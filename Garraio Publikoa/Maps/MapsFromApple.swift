//
//  MapsFromApple.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 20/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit
import MapKit

protocol MapsActions {
    func showInfoPanel(marker: CustomMarker?)
    func hideInfoPanel()
}

class MapsFromApple: NSObject {
    
    // MARK: - Properties
    
    private var mapView:MKMapView? // The view with the embedded Apple Maps.
    public var actionsDelegate: MapsActions? // The delegate for the 'MapsActions' protocol.
    
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
    /// - Returns: The mapView as a UIView.
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
    /// Adds a marker to the maps.
    /// - Parameter stop: A Stop object.
    /// - Parameter color: A UIColor.
    ///
    public func addStop(stop: Stop, companyInfo: CompanyInfo) {
        if let doubleLat = Double(stop.lat), let doubleLng = Double(stop.lng) {
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLng)
            
            // The color of the stop.
            let stopColor: UIColor = convertHexToUIColor(hex: companyInfo.color) ?? UIColor.black
            
            // Creates a marker.
            let customMarker: CustomMarker = CustomMarker(coordinate: coordinate, title: stop.name, subtitle: "", companyId: companyInfo.id, companyName: companyInfo.name, stopId: stop.id, color: stopColor)
            
            // Adds the marker to the map.
            self.mapView?.addAnnotation(customMarker)
        }
    }
    
    ///
    /// Adds a marker list to the maps.
    /// - Parameter stopList: A list of Stop objects.
    /// - Parameter color: A UIColor.
    ///
    public func addStops(stopList: [Stop], companyInfo: CompanyInfo) {
        for stop in stopList {
            self.addStop(stop: stop, companyInfo: companyInfo)
        }
    }
    
    ///
    /// Adds a line with it's stops to the map.
    /// - Parameter line: A line object.
    /// - Parameter stopList: A list of Stop objects.
    ///
    public func addLineWithStops(line: Line, stopList: [Stop], companyInfo: CompanyInfo) {
        
        // The color of the line.
        let lineColor: UIColor = convertHexToUIColor(hex: line.color) ?? UIColor.black
        
        // Each line has at least two directions.
        for direction in line.directions {
            
            // Creates the coordinates of the polyline.
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
            let overlay: CustomPolyline = CustomPolyline(coordinates: &coordinates, count: coordinates.count)
            overlay.color = lineColor
            
            // Adds the polyline to the map.
            self.mapView?.addOverlay(overlay)
            
            // The line / direction only has the ID's of the stops, so first we need to compare this ID's with the company stop list to get the info of each stop. After getting the info of our stops we are going to add those to the map.
            for stopId in direction.stopsIdWithStopTime {
                for stop in stopList {
                    if stopId.id == stop.id {
                        if let doubleLat = Double(stop.lat), let doubleLng = Double(stop.lng) {
                            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLng)
                            let customMarker: CustomMarker = CustomMarker(coordinate: coordinate, title: stop.name, subtitle: "", companyId: companyInfo.id, companyName: companyInfo.name, stopId: stop.id, color: lineColor)
                            
                            self.mapView?.addAnnotation(customMarker)
                        }
                        break
                    }
                }
            }
        }
    }
    
    ///
    /// Adds lines with it's stops to the maps.
    /// - Parameter lineList: A list of Line objects.
    /// - Parameter stopList: A list of Stop objects.
    ///
    public func addLinesWithStops(lineList: [Line], stopList: [Stop], companyInfo: CompanyInfo) {
        
        for line in lineList {
            self.addLineWithStops(line: line, stopList: stopList, companyInfo: companyInfo)
        }
    }
    
    ///
    /// Adds the info from a company (lines and stops) to the maps.
    /// - Parameter company: A Company.
    ///
    public func addCompany(company: Company) {
        
        // If the company doens't have lines but has stops, print them.
        if (company.lines.isEmpty) && (!company.stops.isEmpty) {
            self.addStops(stopList: company.stops, companyInfo: company.info)
        } else {
            // Adds lines with it's stops.
            self.addLinesWithStops(lineList: company.lines, stopList: company.stops, companyInfo: company.info)
        }
    }
    
}

extension MapsFromApple: MKMapViewDelegate {
    
    ///
    /// Method to draw the markers in the map.
    ///
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: CustomMarker.self) {
            let customMarker: CustomMarker = annotation as! CustomMarker
            
            let identifier: String = "customMarker"
            
            var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if markerView == nil {
                markerView = MKAnnotationView(annotation: customMarker, reuseIdentifier: identifier)
                markerView!.canShowCallout = false // Hides the annotation title after tapping on the annotation icon.
            } else {
                markerView!.annotation = customMarker
            }
            
            let color: UIColor = customMarker.color
            markerView!.image = MapMarker().createSmallRoundedImageWithColor(color: color)
            
            return markerView
        } else {
            return nil
        }
    }
    
    ///
    /// Method detects the tap on an annotation.
    ///
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let delegate = self.actionsDelegate {
            if let annotation = view.annotation, annotation.isKind(of: CustomMarker.self) {
                let marker: CustomMarker = annotation as! CustomMarker
                delegate.showInfoPanel(marker: marker)
            }
        }
    }
    
    ///
    /// Method detects the tap outside an annotation when an annotation was previously seleccted.
    ///
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let delegate = self.actionsDelegate {
            delegate.hideInfoPanel()
        }
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
