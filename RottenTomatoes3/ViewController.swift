//
//  ViewController.swift
//  RottenTomatoes3
//
//  Created by Samina Qazi on 9/15/15.
//  Copyright © 2015 Samina Qazi. All rights reserved.
//

import UIKit
private let CELL_NAME = "com.codepath.rottentomatoes.moviecell"

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var movieTableView: UITableView!
    var movies:NSArray?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        return movies?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieDictionary = movies![indexPath.row] as! NSDictionary
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! MovieCell
        //cell.movieTitleLabel.text = "Fast and Furious \(indexPath.row)"
        cell.movieTitleLabel.text = movieDictionary["title"] as? String
        cell.movieDescriptionLabel.text = movieDictionary["synopsis"] as? String
        
        /* let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.textLabel?.text = "Row \(indexPath.row)" */
        
        return cell
        
    }
    
    
/*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("TableView? \(movieTableView.frame)")
        
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=f2fk8pundhpxf77fscxvkupy"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                dispatch_async(dispatch_get_main_queue()) {
                    self.movies = dictionary["movies"] as? NSArray
                    self.movieTableView.reloadData()
                }
                NSLog("Dictionary: \(dictionary)")
            } else {
                
            }
    }
    task.resume()
    }
}

class MovieCell:UITableViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
}


