//
//  HomeViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import UIKit
import Firebase


class HomeViewController: UIViewController {
    
var products = [Product]()
    var selectedProduct:Product?
    var selectedProductImage:UIImage?
    
    
    @IBOutlet weak var productTableView: UITableView!{
        
    
    didSet {
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")

        }
                                  
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        getProducts()
        
        // Do any additional setup after loading the view.
    }
    
    func getProducts() {
        
        let ref = Firestore.firestore()
        ref.collection("Products").order(by: "createdAt", descending: true).addSnapshotListener { snapshot,error in
            if let error = error {
                print("DB ERROR Products",error.localizedDescription)
            }
            
            if let snapshot = snapshot {
                print("PRODUCT CANGES",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let productData = diff.document.data()
                    switch diff.type {
                    case.added :
                        if let userId = productData["userId"] as? String {
                            ref.collection("users").document(userId).getDocument { userSnapshot,error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(idct: userData)
                                    
                                    let product = Product(idct: productData, id: diff.document.documentID, user: user)
                                    self.productTableView.beginUpdates()
                                    if snapshot.documentChanges.count != 1 {
                                        self.products.append(product)
                                        
                                        self.productTableView.insertRows(at: [IndexPath(row: self.products.count - 1, section:0)], with: .automatic)
                                    }else {
                                        self.products.insert(product, at: 0)
                                        
                                        self.productTableView.insertRows(at: [IndexPath(row: 0, section: 0)],with: .automatic)
                                    }
                                    self.productTableView.endUpdates()
                                
                                }
                            }
                        }
                          
                    case.modified:
                        let productId = diff.document.documentID
                        if let currentProduct = self.products.first(where: {$0.id == productId}),
                           let updataIndex = self.products.firstIndex(where: {$0.id == productId}) {
                            let newProduct = Product(idct: productData, id: productId, user: currentProduct.user)
                            self.products[updataIndex] = newProduct
                            
                            
                            self.productTableView.beginUpdates()
                            self.productTableView.deleteRows(at: [IndexPath(row: updataIndex, section: 0)], with: .left)
                            self.productTableView.insertRows(at: [IndexPath(row: updataIndex, section: 0)], with: .left)
                            self.productTableView.endUpdates()
                        }
                        
                    case.removed:
                        let productId = diff.document.documentID
                        if let deleteIndex = self.products.firstIndex(where: {$0.id == productId}){
                            self.products.remove(at: deleteIndex)
                            
                            self.productTableView.beginUpdates()
                            self.productTableView.deleteRows(at: [IndexPath(row: deleteIndex, section: 0)], with: .automatic)
                            self.productTableView.endUpdates()
                        }
                        
                        
                        
                        
                    }
                }
            }
            
            
            
    }
    
    
    
    
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController")as? UINavigationController{
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
        } catch {
            print("ERROR in signout",error.localizedDescription)
        
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toProductVC" {
            let vc = segue.destination as! ProductViewController
            vc.selectedProduct = selectedProduct
            vc.selectedProductImage = selectedProductImage
        }else {
            let vc = segue.destination as! DetailsViewController
            vc.selectedProduct = selectedProduct
            vc.selectedProductImage = selectedProductImage
        }
    }
    
    }
    

    
    
    
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
       
        return cell.configure(wiht: products[indexPath.row])
    }
    
}
    extension HomeViewController : UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return productTableView.frame.width
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! ProductCell
            
            selectedProductImage = cell.ProductImageView.image
            selectedProduct = products[indexPath.row]
            
            if let currentUser = Auth.auth().currentUser,
               currentUser.uid == products[indexPath.row].user.id{
                performSegue(withIdentifier: "toProductVC", sender: self)
                
            } else {
                performSegue(withIdentifier: "toDetailsVC", sender: self)
            }
        }
    }

