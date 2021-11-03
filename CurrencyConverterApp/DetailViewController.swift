//
//  DetailViewController.swift
//  CurrencyConverterApp
//
//  Created by Ferdi DEMİRCİ on 3.11.2021.
//

import UIKit

class DetailViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    var list = [Currency]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        getData()
    }
    func getData() {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {(data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Ana hata!")
            }else{
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        print(jsonResponse)
                        DispatchQueue.main.async {
                            let array = Array(jsonResponse["rates"] as! [String:Any])
                            for (key,value) in array {
                                var entity = Currency()
                                entity.code = key
                                entity.value = value as! Double
                                self.list.append(entity)
                            }
                            self.tableView.reloadData()
                        }
                    }catch {
                        print("Hata")
                    }
                }
            }
            
        }.resume()
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableViewCell
        let currency = list[indexPath.row]
        cell.labelMoney.text = "\(currency.code): \(currency.value)"
        if let img = UIImage(named: currency.image) {
            cell.imageFlag.image = img
        }else{
            cell.imageFlag.image = UIImage(named: "default.png")
        }
        
        return cell
    }
}
