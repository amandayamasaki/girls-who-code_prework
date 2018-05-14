//
//  GalleryViewController.swift
//  yamasaki_prework
//
//  Created by amanda on 5/13/18.
//  Copyright © 2018 amanda. All rights reserved.
//

import UIKit
import CoreData

class GalleryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - Navigation
    
    var imagePickerController: UIImagePickerController!
    @IBOutlet weak var takePhoto_button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func takePhoto_button(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func saveImage(imageName:String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,
                                                             true)[0] as NSString).appendingPathComponent(imageName)
        
        let image = imageView.image!
        let imageData = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: imagePath as String, contents: imageData, attributes: nil)
    }
    func getImage(imageName:String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,
                                                             true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath) {
            imageView.image = UIImage(contentsOfFile: imagePath)
        } else {
            print("Oh no! No Image!")
        }
    }
    @IBAction func saveImage_button(_ sender: Any) {
        saveImage(imageName: "test.png")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(imageName:"test.png")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
