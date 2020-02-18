//
//  ViewController.swift
//  TableViewWithAPI
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var Viewtabel: UITableView!
    
    var modelData = [MyModel]()
    
    var titleName = [String]()
    var imageName = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Viewtabel.rowHeight = 250
        loadData()
    }
    
    func loadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error == nil {
                do{
                    let myData = try!JSONDecoder().decode([MyModel].self, from: data!)
                    DispatchQueue.main.async {
                        for item in myData{
                            self.titleName.append(item.title)
                            self.imageName.append(item.url)
                            //print(self.imageName)
                        }
                        self.Viewtabel.reloadData()
                    }
                }catch{
                    print(":( Nothing Found")
                }
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        if let imgUrl = imageName[indexPath.row] as? String {
            if let url = URL(string: imgUrl){
                cell.showPic.af_setImage(withURL: url)
            }
        }

        
        return cell
    }
    


}

