//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Mikayla Orange on 3/2/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    
    var postsArray = [PFObject]()
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadTweet()
        myRefreshControl.addTarget(self, action: #selector(loadTweet),for: .valueChanged )
        tableView.refreshControl = myRefreshControl

        // Do any additional setup after loading the view.
    }
    @objc func loadTweet() {
        let postQuery = PFQuery(className: "Posts")
        postQuery.includeKey("user")
        postQuery.limit = 20
        postQuery.findObjectsInBackground { (posts,error) in
            if posts != nil {
                print("hooray!")
                self.postsArray = posts!
                self.myRefreshControl.endRefreshing()

                self.tableView.reloadData()
            }
            else {
                print("empty...")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let postQuery = PFQuery(className: "Posts")
        postQuery.includeKey("user")
        postQuery.limit = 20
        postQuery.findObjectsInBackground { (posts,error) in
            if posts != nil {
                print("hooray!")
                self.postsArray = posts!
                self.tableView.reloadData()
            }
            else {
                print("empty...")
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let post = postsArray[indexPath.row]

        let user = post["user"] as! PFUser
        cell.postAuthor.text = user["username"] as? String
        cell.postComment.text = post["caption"] as? String
        let imageFile = post["image"] as! PFFileObject
        let imageUrl = imageFile.url!
        let url = URL(string: imageUrl)!
        cell.postImage.af.setImage(withURL: url)
        return cell
    }
    

}
