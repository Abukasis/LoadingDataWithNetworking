//
//  TableViewController.swift
//  LoadingDataWithNetworking
//
//  Created by Oliver on 9/24/19.
//  Copyright © 2019 Addie. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var ArtistNameList = [String]()
    var AlbumPictureList = [UIImage]()
    var AlbumTitleList = [String]()
    
    
    func getData(){
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let feed = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            
            var results = feed!["feed"] as? NSDictionary
            var insideResults = results!["results"] as? NSArray
            
        
            for item in insideResults!{
                let data = item as! NSDictionary
                let artistName = data["artistName"]  as! String
                let albumName = data["name"]  as! String
                let albumPhotoURL =  data["artworkUrl100"] as! URL
                
                let pictureData = try? Data(contentsOf: albumPhotoURL ) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                let albumPhoto = UIImage(data: pictureData!)
                
                self.ArtistNameList.append(artistName)
                self.AlbumTitleList.append(albumName)
                
                self.AlbumPictureList.append(albumPhoto!)
                
            }
            
            
            // delectus aut autem
         
        }
        
        task.resume()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
