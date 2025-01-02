//
//  SCFahrradparkenReporterWorker.swift
//  OSCA
//
//  Created by Bhaskar N S on 18/05/23.
//  Copyright © 2023 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import Foundation
import CoreLocation

protocol SCFahrradParkenReporterWorking {
    
    func getFahrradparkenCategories(cityId: String, completion: @escaping ([SCModelDefectCategory], SCWorkerError?) -> Void)
    func submitDefect(cityId: String, defectRequest: SCModelDefectRequest, completion: @escaping ((_ uniqueId : String?, _ error: SCWorkerError?) -> Void))
    func uploadDefectImage(cityId: String, imageData: Data, completion: @escaping ((_ mediaURL : String?, _ error: SCWorkerError?) -> Void))
    func getFahrradparkenReportedLocations(cityId: String, request: FahrradparkenServiceRequest, completion: @escaping ([FahrradparkenLocation], SCWorkerError?) -> Void)
}


class SCFahrradParkenReporterWoker: SCWorker, SCFahrradParkenReporterWorking {
    
    private let fahrradParkenPath = "/api/v2/smartcity/defectReporter" //TODO: change this actionName
    private let defectReporterImageUploadPath = "/api/v2/smartcity/otc/upload"
    private var fahrradParkenCategories : [SCModelDefectCategory]?
    private let defectReporterPath = "/api/v2/smartcity/defectReporter"
    
    func getFahrradparkenReportedLocations(cityId: String, request: FahrradparkenServiceRequest, completion: @escaping ([FahrradparkenLocation], SCWorkerError?) -> Void) {
        
        guard let nortEast = request.northEast, let southWest = request.southWest else {
            return
        }
        let queryParam: [String: String] = ["cityId": cityId,
                                            "actionName": "GET_FahrradparkenExistingDefects",
                                            "limit": "\(request.limit)",
                                            "bbox": "\(southWest.longitude),\(southWest.latitude),\(nortEast.longitude),\(nortEast.latitude)",
                                            "service_code": request.serviceCode]
        let url = GlobalConstants.appendURLPathToSOLUrl(path: fahrradParkenPath, parameter: queryParam)
        self.request.fetchData(from: url, method: "GET", body: nil, needsAuth: false) { result in
            switch result {
            case .success(let data):
                do {
                    let fahrradParkenLocations = try JSONDecoder().decode(SCHttpModelResponse<[FahrradparkenLocation]>.self, from: data)
                    completion(fahrradParkenLocations.content, nil)
                } catch let error {
                    debugPrint(error)
                    completion([], .technicalError)
                }
            case .failure(let error):
                debugPrint("SCFahrradParkenReporterWoker: \(error)")
                completion([], self.mapRequestError(error))
            }
        }
    }
    
    
    func getFahrradparkenCategories(cityId: String, completion: @escaping ([SCModelDefectCategory], SCWorkerError?) -> Void) {
        let queryParam: [String: String] = ["cityId": cityId,
                                            "actionName": "GET_CityFahrradparkenCategories"]
        let url = GlobalConstants.appendURLPathToSOLUrl(path: fahrradParkenPath, parameter: queryParam)
        request.fetchData(from: url, method: "GET", body: nil, needsAuth: false) { result in
            switch result {
            case .success(let data):
                do {
                    let fahrradParkenCategory = try JSONDecoder().decode(SCHttpModelResponse<[SCHttpModelDefectCategory]>.self, from: data)
                    let fahrradParkenCategoryContent = fahrradParkenCategory.content.map {$0.toModel()}
                    self.fahrradParkenCategories = fahrradParkenCategoryContent
                    completion(fahrradParkenCategoryContent, nil)
                } catch let error {
                    debugPrint(error)
                    completion([], .technicalError)
                }
            case .failure(let error):
                debugPrint("SCFahrradParkenReporterWoker: \(error)")
                completion([], self.mapRequestError(error))
            }
        }
        
    }
    
    struct SCHttpResponseDefectRequest: Decodable {
        let uniqueId: String
    }
    
    func submitDefect(cityId: String, defectRequest: SCModelDefectRequest, completion: @escaping ((String?, SCWorkerError?) -> Void)) {
        
        let queryDictionary = ["cityId": cityId, "actionName": "POST_CityFahrradparkenDefect"]
        let url = GlobalConstants.appendURLPathToSOLUrl(path: defectReporterPath, parameter: queryDictionary )
        
        let bodyDict = defectRequest.toModel()
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict, options: []) else {
            completion(nil, SCWorkerError.technicalError)
            return
        }
        
        request.fetchData(from: url, method: "POST", body: bodyData, needsAuth: false)
        { (result) in
            switch result {
            case .success(let fetchedData):
                do {
                    let httpContent = try JSONDecoder().decode(SCHttpModelResponse<SCHttpResponseDefectRequest>.self, from: fetchedData)
                    debugPrint("SCDefectReporterWorker: ", httpContent.content.uniqueId)

                    completion(httpContent.content.uniqueId, nil)
                } catch {
                    completion(nil, SCWorkerError.technicalError)
                }
            case .failure(let error):
                debugPrint("SCDefectReporterWorker: requestFailed", error)
                completion(nil, self.mapRequestError(error))
            }
        }
    }
    
    struct SCHttpResponseDefectImageRequest: Decodable {
        let mediaURL: String
    }
    
    func uploadDefectImage(cityId: String, imageData: Data, completion: @escaping ((String?, SCWorkerError?) -> Void)) {
        
        let queryDictionary = ["cityId": cityId, "actionName": "POST_Image"]
        let url = GlobalConstants.appendURLPathToSOLUrl(path: defectReporterImageUploadPath, parameter: queryDictionary )
             
        let additionalHeaders = ["Content-Type": "image/jpeg",
                                 "Content-Length": "\(imageData.count)"]
        
        request.uploadData(from: url, method: "POST", body: imageData, needsAuth: false, additionalHeaders: additionalHeaders) { result in
            switch result {
            case .success(let fetchedData):
                do {
                    let httpContent = try JSONDecoder().decode(SCHttpModelResponse<SCHttpResponseDefectImageRequest>.self, from: fetchedData)
                    debugPrint("SCDefectReporterWorker: ", httpContent.content.mediaURL)

                    completion(httpContent.content.mediaURL, nil)
                } catch {
                    completion(nil, SCWorkerError.technicalError)
                }
            case .failure(let error):
                debugPrint("SCDefectReporterWorker: requestFailed", error)
                completion(nil, self.mapRequestError(error))
            }
        }
    }
}

//TODO: added to mock data - can be removed later
class SCFahrradParkenReporterJson: SCFahrradParkenReporterWorking {
    func getFahrradparkenReportedLocations(cityId: String, request: FahrradparkenServiceRequest, completion: @escaping ([FahrradparkenLocation], SCWorkerError?) -> Void) {
        fetchFromJsonFile(fileName: "FahrradparkenLocations") { data, error in
            guard error == nil else {
                completion([], error)
                return
            }
            do {
                let reportedLocations = try JSONDecoder().decode(SCHttpModelResponse<[FahrradparkenLocation]>.self, from: data!)
                completion(reportedLocations.content, nil)
            } catch let error {
                print("**error \(error)")
                print("**error.localizedDescription \(error.localizedDescription)")
                completion([], .technicalError)
            }
        }
    }

    func getFahrradparkenCategories(cityId: String, completion: @escaping ([SCModelDefectCategory], SCWorkerError?) -> Void) {
        fetchFromJsonFile(fileName: "FahrradParkenCategories") { data, error in
            guard error == nil else {
                completion([], error)
                return
            }
            do {
                let fahrradParkenCategory = try JSONDecoder().decode(SCHttpModelResponse<[SCHttpModelDefectCategory]>.self, from: data!)
                let fahrradParkenCategoryContent = fahrradParkenCategory.content.map {$0.toModel()}
                completion(fahrradParkenCategoryContent, nil)
            } catch let error {
                debugPrint(error)
                completion([], .technicalError)
            }
        }
    }

    func submitDefect(cityId: String, defectRequest: SCModelDefectRequest, completion: @escaping ((String?, SCWorkerError?) -> Void)) {

    }

    func uploadDefectImage(cityId: String, imageData: Data, completion: @escaping ((String?, SCWorkerError?) -> Void)) {

    }

    func fetchFromJsonFile(fileName: String, completionHandler: @escaping ((Data?, SCWorkerError?) -> Void)) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                completionHandler(data, nil)
            } catch {
                completionHandler(nil, .technicalError)
            }
        }
    }
}
