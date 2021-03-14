//
//  PostImageViewController.swift
//  Parstagram
//
//  Created by Mikayla Orange on 3/2/21.
//

import UIKit
import Parse
import AlamofireImage

class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var caption: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        caption.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = caption.text!
        post["user"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
        
        post.saveInBackground {(success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("oh no!!")
            }
        }
    }
    

    @IBAction func onCameraTap(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .photoLibrary
        }
        else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ caption: UITextField) -> Bool {
        caption.resignFirstResponder() // dismiss keyboard

        return true;
    }
}
