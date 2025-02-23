//
//  Constant.swift
//  School
//
//  Created by Mahmoud on 01/12/2024.
//

import Foundation
import Alamofire

struct CustomError: Error, Codable {
    let success: Bool?
    let message: String?
}

class BaseAPI<T: TargetType> {
    
    
    func performRequest<M: Codable>(target: T, rsponseClass: M.Type, completion:@escaping (Result<M?, CustomError>) -> Void) {
        
        let method     = Alamofire.HTTPMethod(rawValue: target.method.rawValue)//target.method.rawValue
        let headers    = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParameters(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(_):
                print("success")
                guard let data = response.data else { return }
                do{
                    let jsonData = try JSONDecoder().decode(M.self, from: data)
                    completion(.success(jsonData))
                }catch let jsonError {
                    completion(.failure(CustomError(success: false, message: "\(jsonError)")))
                }
            case .failure(let error):
                print(error)
                guard let error = (response.error?.underlyingError as? URLError) else { return }
                
                switch error.code {
                case .timedOut:
                    completion(.failure(CustomError(success: false, message: "Timout")))
                case .notConnectedToInternet:
                    completion(.failure(CustomError(success: false, message: "Not connected to internet")))
                default:
                    break
                }
                
                guard let data = response.data else {
                    completion(.failure(CustomError(success: false, message: "\(error)")))
                    return
                }
                
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(CustomError(success: false, message: "\(error)")))
                    return
                }
                
                switch statusCode {
                case 400..<500:
                    do{
                        let jsonError = try JSONDecoder().decode(CustomError.self, from: data)
                        completion(.failure(jsonError))
                    }catch let jsonError {
                        let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: jsonError])
                        completion(.failure(CustomError(success: false, message: "\(error)")))
                    }
                default:
                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: "something went wrong"])
                    completion(.failure(CustomError(success: false, message: "\(error)")))
                }
            }
        }
    }
    
    
    private func buildParameters(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding())
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
