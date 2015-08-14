//
//  PhotoPickerController.swift
//  Renty
//
//  Created by yahya on 7/21/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit
import AVFoundation
import Bond
import Parse



class PhotoPickerController: UIViewController   {
    
    //var image : UIImage!
    @IBOutlet weak var previewView : UIView!
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var capturedImage2: UIImageView!
    @IBOutlet weak var capturedImage3: UIImageView!
    
    @IBOutlet weak var yesview: UIView!
    
    @IBOutlet var takePhotoButton: UIButton!
    
   // @IBOutlet weak var takePhotoButtonDone: UIButton!
    @IBAction func close(sender: AnyObject) {
        
        self.performSegueWithIdentifier("close", sender: self)
        
    }
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBAction func unwindTophotoPicker (segue : UIStoryboardSegue ) {
        
    }
    var counter : Int = 0
    //    var imageArray : NSMutableArray = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        var input = AVCaptureDeviceInput(device: backCamera, error: &error)
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait



                previewView.layer.addSublayer(previewLayer)

                
                captureSession!.startRunning()
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
      previewLayer!.frame = previewView.bounds
        
    }
    
    
    
    @IBAction func didPressTakePhoto(sender: UIButton) {
        
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    var dataProvider = CGDataProviderCreateWithCFData(imageData)
                    var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault)
                    
                    
                    var image = UIImage(CGImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.Right)
                    let borderColor = UIColor(red: 174.0/255.0, green: 174.0/255.0, blue: 174.0/255.0, alpha: 1.0)

                    if (self.counter<1)
                    {
                      
                        self.capturedImage.image = image
                        self.counter++;
                        var image1 = self.capturedImage.image
                        self.capturedImage.setBorder(13, width: 1, color: borderColor)

                    }
                    else if (self.counter>1 &&  self.counter<3)
                    {
    

                        self.capturedImage2.image = image
                        self.counter++;
                        var image2 = self.capturedImage2.image

                        self.capturedImage2.setBorder(13, width: 1, color: borderColor)

                    }
                    else if (self.counter<3)
                 
                    {
                        
                        self.capturedImage3.image = image
                        self.counter++;
                        var image3 = self.capturedImage3.image
                        self.capturedImage3.setBorder(13, width: 1, color: borderColor)
                        
                    }
                    else if  (self.counter==3)
                        
                    {
                        self.takePhotoButton.hidden = true
                       // self.takePhotoButtonDone.hidden = false

                     self.previewView.hidden = true
                    self.yesview.hidden = false
                     self.yesview.frame = self.previewView.frame

//
                    }
                    
                    
                    
                    
                }
            })
        }
    }
    
    @IBAction func didPressTakeAnother(sender: AnyObject) {
        captureSession!.startRunning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Preview" {
            if let vc = segue.destinationViewController as? AddProductViewController {
                vc.image1 = capturedImage.image
                vc.image2 = capturedImage2.image
                vc.image3 = capturedImage3.image
            }
        }
    }
}
