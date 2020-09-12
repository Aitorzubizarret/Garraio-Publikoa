//
//  LocalFile.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 21/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

enum FileName: String {
    case bilbobus = "Bilbobus"
    case dbus = "DBus"
    case tuvisa = "Tuvisa"
    case udalbus = "Udalbus"
    case bizkaibus = "Bizkaibus"
    case irunbus = "Irunbus"
    case lurraldebus = "Lurraldebus"
    case pesa = "Pesa"
    case tuc = "TUC"
    case alavabus = "Alavabus"
    case metroBilbao = "MetroBilbao"
    case euskotren = "Euskotren"
    case tranviaBilbao = "TranviaBilbao"
    case tranviaVitoria = "TranviaVitoria"
    case funicularLarreineta = "FunicularLarreineta"
    case funicularArtxanda = "FunicularArtxanda"
    case funicularIgeldo = "FunicularIgeldo"
    case bilbaobizi = "Bilbaobizi"
    case etxebarriBus = "EtxebarriBus"
    case kbus = "KBus"
    case renfeCercanias = "RenfeCercanias"
    case renfeFeve = "RenfeFeve"
    case zarauzkoHiribusa = "ZarauzkoHiribusa"
    case hernanikoHiribusa = "HernanikoHiribusa"
    case muittuManttangorri = "MuittuManttangorri"
    case xorrolaAutobusa = "XorrolaAutobusa"
    case bizkaiaZubia = "BizkaiaZubia"
    case getxoBizi = "GetxoBizi"
    case topo = "Topo"
}

class LocalFile {
    
    ///
    /// Reads a local file and sends back its data.
    /// - Parameter fileName: The name of the file.
    /// - Parameter success: 'True' if the JSON file has been read and / or decode correctly, otherwise 'false'.
    /// - Parameter data: The data of the file as Bus.
    ///
    public func readJSONFile(fileName: FileName, completion: @escaping(_ success: Bool, _ data: Company?) -> Void) {
        if let path = Bundle.main.path(forResource: fileName.rawValue, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                
                // Get the data from the JSON file.
                let data = try Data(contentsOf: fileUrl, options: Data.ReadingOptions.alwaysMapped)
                
                // Decode the data from JSON to Company object.
                let companyInfo = try JSONDecoder().decode(Company.self, from: data)
                
                completion(true, companyInfo)
            } catch let error {
                completion(false, nil)
                print("Error: \(error)")
            }
        } else {
            print("Error getting the path of the file.")
            completion(false, nil)
        }
    }
}
