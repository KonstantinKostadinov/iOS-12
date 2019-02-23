//
//  ViewController.swift
//  Food
//
//  Created by username on 23.02.19.
//  Copyright © 2019 Konstantin Kostadinov. All rights reserved.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker,animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera// for photo library - imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage?{
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else{
                fatalError("Could not convert to CIImage")
            }
            detect(image: ciimage)

        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Loading CoreML Model failed!")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image!")
            }
            if let firstResult = result.first{
                if firstResult .identifier.contains("hot dog"){
                    self.navigationItem.title = "Hot dog!"
                }
                else{
                    self.navigationItem.title = "Not Hot dog!"
                }
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        }catch{
                print(error)
            }
    }
}

