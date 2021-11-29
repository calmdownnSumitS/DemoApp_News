//
//  DetailViewController.swift
//  BANews
//
//  Created by JustMac on 24/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    private let userdetailVM : UserDetailViewModel = UserDetailViewModel.shared

    
    @IBOutlet weak var tableDetailView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewSetup()
        initDataSetup()
    }
    
    private func initViewSetup(){
        tableDetailView.dataSource = self
        tableDetailView.tableFooterView = UIView()
        
    }
    private func initDataSetup(){
        userdetailVM.reloadUser_table = {
            self.tableDetailView.reloadData()
        }
        
        userdetailVM.selectedPostInfo()
    }

    
//MARK:- 
    @IBAction func backToViewcontroller(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let pCell = tableView.dequeueReusableCell(withIdentifier: "pCell") as! DetailProfileCell
            pCell.user = userdetailVM.getUser()
            return pCell
            
        }else{
            
            let iCell = tableView.dequeueReusableCell(withIdentifier: "iCell") as? DetailInfoCell
            iCell?.userPost = userdetailVM.getPost()
            return iCell!
        }
    }
    
    
}
