//
//  SewersViewController.swift
//  Eazip
//
//  Created by Marie on 29/01/2019.
//  Copyright © 2019 Eazip. All rights reserved.
//

import UIKit

class SewersViewController: UIViewController {
    
    @IBOutlet var sewerCollectionView : UICollectionView?
    @IBOutlet weak var headerviewLabel: EazipLabel!
    
    var collectionView: UICollectionView?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    // Data
    var dataSewers: [Sewer] = []
    var currentSewer: Sewer = Sewer(id: 0, bio: "", img: UIImage(named: "sewerPicture1")!, firstName: "", lastName: "", rating: 0, works: 0, street: "", city: "")
    var selectedClothes: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeaderView()
        getSewersData()
    }
    
    func setUpHeaderView() {
        headerviewLabel.textAlignment = .center
        headerviewLabel.text = "Découvrez nos" + "\n" + "couturiers"
    }

    
    private func setUpNavigationBarItems() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back_btn"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func getSewersData() {
        ApiSewersHelper() { sewerList, error in
            if sewerList != nil {
                self.dataSewers.append(contentsOf: sewerList!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.initSewerCollectionView()
                }
            }
        }
    }
    
    typealias Apicompletion = (_ sewerList: [Sewer]?, _ errorString: String?) -> Void
    
    func ApiSewersHelper(completion: Apicompletion?) {
        let url = URL(string: "http://ec2-35-180-118-48.eu-west-3.compute.amazonaws.com/sewers")
        let session = URLSession.shared
        
        session.dataTask(with: url!) { (data, response, error) in
            var tempSewerList: [Sewer] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let sewerArray = json["data"] as? NSArray {
                            for sewer in sewerArray as! [Dictionary<String, AnyObject>] {
                                let id = sewer["id"] as! Int
                                let firstName = sewer["first_name"] as! String
                                let lastName = sewer["last_name"] as! String
                                let rating: Int = 4
                                let bio = sewer["description"] as! String
                                let street = sewer["street"] as! String
                                let city = sewer["city"] as! String
                                let picture = "sewerPicture1"
                                let works = 3
                                
                                
                                tempSewerList.append(Sewer(id: id, bio: bio, img: UIImage(named: picture)!, firstName: firstName, lastName: lastName, rating: rating, works: works, street: street, city: city))
                            }
                            completion?(tempSewerList, nil)
                        }
                    }
                } catch {
                    completion?(nil, error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func initSewerCollectionView() {
        //Init delegate and datasource
        sewerCollectionView?.delegate = self
        sewerCollectionView?.dataSource =  self
        
        //Layout content position
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 30
        sewerCollectionView?.reloadData()
        sewerCollectionView?.collectionViewLayout = layout
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "selectedClothesBackToServicePage", sender: self)
        previousScreen()
    }
    
    func previousScreen() {
        goToScreen(identifier: "WorksByClothViewController")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentSewerSegue" {
            let vc = segue.destination as! SewerProfileViewController
            vc.self.currentProfile = currentSewer
            vc.self.selectedClothes = selectedClothes
        }
        
        if segue.identifier == "selectedClothesBackToServicePage" {
            let backVc = segue.destination as! WorksByClothViewController
            backVc.self.selectedClothes = selectedClothes
        }
    }
}



