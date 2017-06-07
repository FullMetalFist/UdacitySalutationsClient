//
//  ViewController.swift
//  SalutationsClient
//
//  Created by Michael Vilabrera on 6/7/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

import UIKit

let saluationsEndpoint = "http://10.10.1.21:8080/salutation"

class ViewController: UIViewController {
    
    @IBOutlet weak var salutationLabel: UILabel!
    
    
    @IBAction func getSalutation(_ sender: Any) {
        let task = URLSession.shared.dataTask(with: URL(string: saluationsEndpoint)!) { (data, response, error) in
            
            // check for error
            if let error = error {
                print(error)
                return
            }
            
            // extract data and display in UI
            if let data = data {
                var salutation: [String: String]! = nil
                do {
                    salutation = try JSONSerialization.jsonObject(with: data) as? [String: String]
                } catch {
                    print("could not serialize \(data)")
                    return
                }
                DispatchQueue.main.async {
                    self.salutationLabel.text = salutation["text"]
                }
            } else {
                print("no data was returned")
            }
        }
        // resume task
        task.resume()
    }
}

