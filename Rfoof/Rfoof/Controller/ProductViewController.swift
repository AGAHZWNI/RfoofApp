



import UIKit
import Firebase
import SwiftUI

class ProductViewController: UIViewController {
    var selectedProduct : Product?
    var selectedProductImage: UIImage?
    
    
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView! {
    
    didSet {
        productImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        productImageView.addGestureRecognizer(tapGesture)
    }
    
    }
    
    @IBOutlet weak var productTitleTextField: UITextField!
    
    @IBOutlet weak var productDescriptionTextField: UITextField!
    
    @IBOutlet weak var productPriceTextField: UITextField!
    
    let activityIndicator = UIActivityIndicatorView()

    //--------------------------------------
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    
    //----------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Titl".localized
        
        descriptionLabel.text = "Description".localized
        
        priceLabel.text = "Price".localized
        
        addButton.setTitle("Add".localized, for: .normal)
        
        
        //-------------------------------------

        if let selectedProduct = selectedProduct,
           let selectedImage = selectedProductImage{
            productTitleTextField.text = selectedProduct.title
            productDescriptionTextField.text = selectedProduct.description
            productImageView.image = selectedImage
            productPriceTextField.text = selectedProduct.price
            
            actionButton.setTitle("Update Product", for: .normal)
            
            let deleteBarButton = UIBarButtonItem(image:UIImage(systemName: "trash.fill"), style: .plain, target: self,action: #selector(handleDelete))
            
            self.navigationItem.rightBarButtonItem = deleteBarButton
            
        } else {
            actionButton.setTitle("Add Product", for: .normal)
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
        @objc func handleDelete (_ sender: UIBarButtonItem) {
            let ref = Firestore.firestore().collection("Products")
            if let selectedProduct = selectedProduct {
                Activity.showIndicator(parentView: self.view, childView: activityIndicator)
                ref.document(selectedProduct.id).delete { error in
                    if let error = error{
                        print("Error in db delete",error)
                    } else {
                        
                        let storageRef = Storage.storage().reference(withPath: "Products/\(selectedProduct.user.id)/\(selectedProduct.id)")
                        
                        storageRef.delete { error in
                            if let error = error {
                                print("Error in storage delete",error)
                            }else {
                                self.activityIndicator.stopAnimating()
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                    
                }
            }
        }
    
        
        
        
    
    
    @IBAction func handleActionTouch(_ sender: Any) {
        
        if let image = productImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.50),
           let title = productTitleTextField.text,
           let description = productDescriptionTextField.text,
           let price = productPriceTextField.text,
            let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            
            var productId = ""
            if let selectedProduct = selectedProduct {
                productId = selectedProduct.id
            } else {
                
             
                productId = "\(Firebase.UUID())"
              
            }
            
            let storageRef = Storage.storage().reference(withPath: "Products/\(currentUser.uid)/\(productId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            
            storageRef.putData(imageData, metadata: updloadMeta) {  storageMeta, error in
                if let error = error {
                    print("Upload error ", error.localizedDescription)
                }
                
                storageRef.downloadURL {url, error in
                    var productData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("Products")
                        
                        if let selectedProduct = self.selectedProduct {
                            productData = [
                                "userId" : selectedProduct.user.id,
                                "title" : title,
                                "price" :price,
                                "description": description,
                                "imageUrl": url.absoluteString,
                                "createdAt":selectedProduct.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                                
                                                                                
                            ]
                        } else {
                            productData = [
                            
                                "userId" : currentUser.uid,
                                "title" : title,
                                "price": price,
                                "description": description,
                                "imageUrl": url.absoluteString,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            
                                                                                    
                            ]
                        }
                        ref.document(productId).setData(productData) { error in
                            
                            if let error = error {
                                print("FireStore Error", error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                
            }

        }
        
        
        
        
    }
    
    
    
    

}

extension ProductViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
@objc func chooseImage() {
    self.showAlert()
}
private func showAlert() {
    
    let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
        self.getImage(fromSourceType: .camera)
    }))
    alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
        self.getImage(fromSourceType: .photoLibrary)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
//get image from source type
private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
    
    //Check is source type available
    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: nil)
    }
}
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
    productImageView.image = chosenImage
    dismiss(animated: true, completion: nil)
}
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
}

}

