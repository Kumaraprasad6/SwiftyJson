//
//  ViewController.swift
//  White House Petitions
//
//  Created by Kumara Prasad on 27/09/18.
//  Copyright © 2018 Matrix. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {


    var petitions = [[String: String]]() //array of dictionaries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        func parse(json: JSON){
            
            for result in json["results"].arrayValue{
                
                let title = result["title"].stringValue
                let body = result["body"].stringValue
                let sigs = result["signatureCount"].stringValue
                let obj = ["title": title, "body": body, "sigs": sigs]
                
                petitions.append(obj)
            }
            tableView.reloadData()
            
        }
        
        let urlString:String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
        else{
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
//        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString){
            if let data = try?  Data(contentsOf: url){
 
                
                let json = try?JSON(data: data)
                if json?["metadata"]["responseInfo"]["status"].intValue
                    == 200 {
                    // we're OK to parse!
                    print("hello")
                    parse(json:json!)
                }
            }
        }
        else{
            showError()
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
        let petetion = petitions[indexPath.row]
        cell.textLabel?.text = petetion["title"]
        cell.detailTextLabel?.text = petetion["body"]
//        cell.textLabel?.text = "Title"
//        cell.detailTextLabel?.text = "Subtitle"
        return  cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError(){
        
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; Please check your internet connection", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true, completion: nil)
    }
    
}
