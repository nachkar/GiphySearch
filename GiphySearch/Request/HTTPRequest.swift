//
//  HTTPRequest.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit
import Alamofire

class HTTPRequest: NSObject {
    override init () {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 60
    }

    func setHeaders(request: URLRequest) -> URLRequest {
        var urlRequest = request

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        return urlRequest
    }

    func POST(requestUrl: String, parameters: [String: Any], success: @escaping (_ response: Any) -> Void, failure: @escaping () -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!

            let url = URL(string: requestUrl)!
            let jsonDataBody = jsonString.data(using: .utf8, allowLossyConversion: false)!

            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = jsonDataBody
            request.cachePolicy = .reloadIgnoringCacheData

            request = setHeaders(request: request as URLRequest)

            //            let pathToCert = Bundle.main.path(forResource: "PinningCert", ofType: "cer")
            //            let certificateData:NSData = NSData(contentsOfFile: pathToCert!)!
            //            let serverTrustPolicy =   ServerTrustPolicy.pinCertificates(certificates: [SecCertificateCreateWithData(nil, certificateData)!], validateCertificateChain: true, validateHost:true)
            //            let serverTrustPolicies = ["api.ds.access-art.net":serverTrustPolicy]
            //
            //            let sessionManager = SessionManager( configuration: URLSessionConfiguration.default, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
            //
            //            sessionManager.session.configuration.timeoutIntervalForRequest = 120

            let manager = Alamofire.Session.default
            manager.request(request).responseJSON { response in

                switch response.result {
                case .success:
                    let resultString = String(data: response.data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

                    if let dictionary = resultString.convertToDictionary() {
                        success(dictionary as Any)
                    } else {
                        failure()
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    failure()
                    break
                }
            }

        } catch {
            print("JSON serialization failed:  \(error)")
        }
    }

    func GET(requestUrl: String, success: @escaping (_ response: Any) -> Void, failure: @escaping () -> Void) {

        let url = URL(string: requestUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.cachePolicy = .reloadIgnoringCacheData

        request = setHeaders(request: request as URLRequest)

        let manager = Alamofire.Session.default
        manager.request(request).responseJSON { response in

            switch response.result {
            case .success:
                let resultString = String(data: response.data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

                if let dictionary = resultString.convertToDictionary() {
                    success(dictionary as Any)
                } else {
                    failure()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                failure()
                break
            }
        }
    }

    func PUT(requestUrl: String, parameters: [String: Any], success: @escaping (_ response: Any) -> Void, failure: @escaping () -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!

            let url = URL(string: requestUrl)!
            let jsonDataBody = jsonString.data(using: .utf8, allowLossyConversion: false)!

            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.put.rawValue
            request.httpBody = jsonDataBody

            request = setHeaders(request: request as URLRequest)

            let manager = Alamofire.Session.default
            manager.request(request).responseJSON { response in

                switch response.result {
                case .success:
                    let resultString = String(data: response.data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

                    if let dictionary = resultString.convertToDictionary() {
                        success(dictionary as Any)
                    } else {
                        failure()
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    failure()
                    break
                }
            }

        } catch {
            print("JSON serialization failed:  \(error)")
        }
    }

    func DELETE(requestUrl: String, parameters: [String: Any], success: @escaping (_ response: Any) -> Void, failure: @escaping () -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!

            let url = URL(string: requestUrl)!
            let jsonDataBody = jsonString.data(using: .utf8, allowLossyConversion: false)!

            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.delete.rawValue
            request.httpBody = jsonDataBody

            request = setHeaders(request: request as URLRequest)

            let manager = Alamofire.Session.default
            manager.request(request).responseJSON { response in

                switch response.result {
                case .success:
                    let resultString = String(data: response.data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

                    if let dictionary = resultString.convertToDictionary() {
                        success(dictionary as Any)
                    } else {
                        failure()
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    failure()
                    break
                }
            }
        } catch {
            print("JSON serialization failed:  \(error)")
        }
    }
}
