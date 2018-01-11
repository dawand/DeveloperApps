//
//  MyAppsTableViewController.swift
//  DeveloperApps
//
//  Created by Dawand Sulaiman on 11/01/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

import UIKit
import DeveloperApps

class MyAppsTableViewController: UITableViewController {

    var categories = Set<String>()
    var categoryApps = [String: [App]]()
    var appObjects = [Objects]()
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [App]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeveloperApps.getApps(for: "dawand") { (apps, error) -> Void in
            for app in apps! {
                let cat = app.category[0]
                self.categories.insert(cat)
            }
            
            for cat in self.categories {
                var catApps = [App]()
                for a in apps! {
                    if a.category[0] == cat {
                        catApps.append(a)
                    }
                }
                self.categoryApps[cat] = catApps
            }
            
            for (key, value) in self.categoryApps {
                self.appObjects.append(Objects(sectionName: key, sectionObjects: value))
            }
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return appObjects.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appObjects[section].sectionObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAppsCell", for: indexPath)

        let app = appObjects[indexPath.section].sectionObjects[indexPath.row]
        
        cell.textLabel?.text = app.name
        
        URLSession.shared.dataTask(with: URL(string: app.artworkUrl)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                cell.imageView?.image = image
            })
            
        }).resume()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = appObjects[indexPath.section].sectionObjects[indexPath.row]
        if UIApplication.shared.canOpenURL(URL(string:app.url)!) {
            UIApplication.shared.open(URL(string:app.url)!)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return appObjects[section].sectionName
    }
}
