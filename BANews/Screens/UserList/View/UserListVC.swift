//
//  ViewController.swift
//  BANews
//
//  Created by JustMac on 24/11/21.

import UIKit

class UserListVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let userlistVM : UserListViewModel = UserListViewModel.shared
    
    public var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewSetup()
        initDataSetup()
    }

    private func initViewSetup(){
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refresh_API), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = UIView()
        self.userlistVM.getServerPost()

        
    }
    private func initDataSetup(){
        // get data form local db
        userlistVM.reloadUser_table = {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        userlistVM.getLoclPosts()
    }
    
    @objc func refresh_API(_ sender: Any) {
        self.userlistVM.getServerPost()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.refreshControl.endRefreshing()

        }
    }
   
}




//MARK:- Tableview Delegate methods and DataSource Method
extension UserListVC : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.userlistVM.userlistCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell") as! UserlistCell
        cell.post = self.userlistVM.user(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userlistVM.setSelectedPost(at: indexPath.row)
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let memberDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(memberDetailsViewController, animated:true)
    }
    
    


}
