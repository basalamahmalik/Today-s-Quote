//
//  Functions.swift
//  FinalProject
//
//  Created by Malik Basalamah on 10/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

extension Client{
    
    func qoutesOfTheDay(_ type: String, completion: @escaping (_ success:Bool,[DataInformation]?, _ errorString: String?)->Void) {
        
        let parameters = [Constants.ParameterKeys.category:type] as [String : Any]
        
        let _ = taskForGETMethod(parameters as [String : AnyObject]) { (results, error) in
            
            guard (error == nil) else{
                print(error!)
                completion(false ,nil,error?.localizedDescription)
                return
            }
            
            /* GUARD: Is "photos" key in our result? */
            guard let photosDictionary = results?[Constants.ResponseKeys.contents] as? [String:AnyObject] else {
                print("Cannot find keys '\(Constants.ResponseKeys.contents)' in \(results!)")
                completion(false,nil,error?.localizedDescription)
                return
            }
            /* GUARD: Is the "photo" key in photosDictionary? */
            guard let photosArray = photosDictionary[Constants.ResponseKeys.quotes] as? [[String: AnyObject]], photosArray.count != 0 else {
                print("Cannot find key '\(Constants.ResponseKeys.quotes)' in \(photosDictionary)")
                return
            }

            let informations = DataInformation.DataFromResults(photosArray)
            
            completion(true,informations,nil)

        }
    }
    
    func displayError(_ errorString: String?, viewController:UIViewController,_ completionHandlerForAlert: @escaping (_ success: Bool) -> Void) {
        
        if let errorString = errorString {
            
            let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: .default)
            // Add the actions
            alertController.addAction(okAction)
            // Present the controller
            viewController.present(alertController, animated: true, completion: nil)
            completionHandlerForAlert(true)
        }
        
    }
}
