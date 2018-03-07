//
//  HomeViewController.swift
//  testApp
//
//  Created by Doyle on 7/03/18.
//  Copyright © 2018 Doyle. All rights reserved.
//

import UIKit
import GuillotineMenu

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet fileprivate var barButton: UIButton!
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate let cellHeight: CGFloat = 210
    fileprivate let cellSpacing: CGFloat = 20
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var items = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(
            red: 65.0 / 255.0,
            green: 62.0 / 255.0,
            blue: 79.0 / 255.0,
            alpha: 1
        )
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let userDefaults = UserDefaults.standard
        navBar?.topItem?.title = userDefaults.string(forKey: "email")!
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.presentButton = sender
        presentationAnimator.animationDuration = 0.2
        present(menuViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.items.removeAllObjects()
        getUsers();
        
    }
    
    func getUsers() {
        RestApiManager.sharedInstance.getRandomUser { json in
            for js in json.array! {
                let user: AnyObject = js.object as AnyObject
                self.items.add(user)
                //let user: (name: String, email: String) = (js["nombre"].stringValue, js["email"].string!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCel", for: indexPath) as! UsersTableViewCell
        
        let user = JSON(self.items[indexPath.row])
        cell.lbName.text = user["nombre"].stringValue
        cell.lbEmail.text = user["email"].stringValue
        
        return cell
        
    }
    
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}

