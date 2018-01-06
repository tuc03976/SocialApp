//
//  ViewController.swift
//  Photo Demo
//
//  Created by Robert Percival on 27/06/2017.
//  Copyright © 2017 Robert Percival. All rights reserved.
//

import UIKit
import AVKit
import AVKit
import AVFoundation
import Social
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVPlayerViewControllerDelegate {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    

    var imagePickerController: UIImagePickerController?
    var videoURL: NSURL?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = image
            
            /* videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
            print("\(String(describing: videoURL!))") */
            
        } else {
            
            videoURL = info["UIImagePickerControllerMediaURL"] as? NSURL
            
            if let videoURL = videoURL {
            let asset = AVAsset(url: videoURL as URL)
            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
            
            var time = asset.duration
            time.value = min(time.value, 2)
            
            do {
                let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
                imageView.image = UIImage(cgImage: imageRef)
            } catch {
                print("error")
                
            }
            }
            
         
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
        if imagePickerController != nil {
            
            imagePickerController!.sourceType = .photoLibrary
            
            imagePickerController!.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
            present(imagePickerController!, animated: true, completion: nil) }
        
        
        /* imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //imagePickerController.mediaTypes = ["public.image", "public.movie"]
        
        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil) */
        
    }
    
    
    @IBAction func playVideoTapped(_ sender: Any) {
        
        if let videoURL = videoURL {
        // let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
            
        } else {
            
            print("choose video first")
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if imagePickerController != nil {
            
            imagePickerController!.sourceType = .camera
            
            imagePickerController!.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
            
            present(imagePickerController!, animated: true, completion: nil) }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func shareTapped(_ sender: Any) {
       
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
        
        
        
    }

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        print("good to go")
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

