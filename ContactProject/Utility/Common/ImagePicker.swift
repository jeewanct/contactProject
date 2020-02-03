//
//  ImagePicker.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate: class {
    func photoPicker(selectedImage: UIImage)
}

class ImagePicker: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var alertController: UIAlertController?
    weak var viewController: UIViewController?
    lazy var pickerController = UIImagePickerController()
    weak var delegate:PhotoPickerDelegate?
    
    
    init(viewControllerToPresent viewController: UIViewController, showRemoveOption:Bool, disableCamera: Bool = false) {
        super.init()
        self.viewController = viewController
        presentImagePickerOptions(showRemoveOption: showRemoveOption, disableCamera: disableCamera)
    }
    
    init(viewController: UIViewController){
        super.init()
        self.viewController = viewController
    }
    
    
    func selectPicture(pickerType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(pickerType){
            pickerController.delegate = self
            pickerController.sourceType = pickerType;
            
            //Commenting below line not shows videos in iPhone Albums, thus videos cannot be ploaded
            //             pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            pickerController.allowsEditing = true
            self.viewController?.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func selectPictureFrontBack(cameraType: UIImagePickerController.CameraDevice,pickerType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(pickerType){
            pickerController.delegate = self
            pickerController.sourceType = pickerType;
            pickerController.cameraDevice = cameraType
            
            //Commenting below line not shows videos in iPhone Albums, thus videos cannot be ploaded
            //             pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            pickerController.allowsEditing = true
            self.viewController?.present(pickerController, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)  {
        self.pickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        var chosenImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage //2
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        } else{
            print("Something went wrong")
        }
        
        
        delegate?.photoPicker(selectedImage: chosenImage)
        
        self.viewController?.dismiss(animated:true, completion: nil) //5
        
    }
    
    
    
}
extension ImagePicker{
    
    public func presentImagePickerOptions(showRemoveOption:Bool, disableCamera: Bool = false){
        
        self.alertController = UIAlertController(title: "Add Image", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.alertController?.dismiss(animated: false, completion: nil)
        }
        alertController?.addAction(cancelAction)
        
        let photoAlbumAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.selectPicture(pickerType: .photoLibrary)
        }
        
        alertController?.addAction(photoAlbumAction)
        
        if disableCamera == false{
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) -> Void in
                self.selectPicture(pickerType: .camera)
            }
            alertController?.addAction(cameraAction)
        }
        
        self.viewController?.present(alertController!, animated: true, completion: nil)
    }
}

