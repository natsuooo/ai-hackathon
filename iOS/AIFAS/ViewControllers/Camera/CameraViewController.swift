//
//  ViewController.swift
//  AIFAS
//
//  Created by 冨平準喜 on 2021/06/14.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, Instantiatable {
    var previewView : UIView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    //Camera Capture requiered properties
    var videoDataOutput: AVCaptureVideoDataOutput!
    var photoOutput : AVCapturePhotoOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        previewView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        previewView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(previewView)
        view.sendSubviewToBack(previewView)
        self.setupAVCapture()
        
        cameraButton.layer.cornerRadius = cameraButton.bounds.width / 2

    }
    
    override var shouldAutorotate: Bool {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
        UIDevice.current.orientation == UIDeviceOrientation.landscapeRight ||
        UIDevice.current.orientation == UIDeviceOrientation.unknown) {
            return false
        }
        else {
            return true
        }
    }
    
    
    @IBAction func tappedShutter(sender: UIButton) {
        // シャッターボタンが押されたときに
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        self.photoOutput.capturePhoto(with: settings, delegate: self)
    }
}

// AVCaptureVideoDataOutputSampleBufferDelegate protocol and related methods
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
     func setupAVCapture(){
        session.sessionPreset = AVCaptureSession.Preset.vga640x480
        guard let device = AVCaptureDevice
        .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                 for: .video,
                 position: AVCaptureDevice.Position.front) else {
                            return
        }
        captureDevice = device
        beginSession()
    }

    func beginSession(){
        var deviceInput: AVCaptureDeviceInput!

        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else {
                print("error: cant get deviceInput")
                return
            }

            if self.session.canAddInput(deviceInput){
                self.session.addInput(deviceInput)
            }
            
            photoOutput = AVCapturePhotoOutput()
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            if session.canAddOutput(self.photoOutput){
                session.addOutput(self.photoOutput)
            }
            

            videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames=true
            videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
            videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)

            if session.canAddOutput(self.videoDataOutput){
                session.addOutput(self.videoDataOutput)
            }

            videoDataOutput.connection(with: .video)?.isEnabled = true

            previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

            let rootLayer :CALayer = self.previewView.layer
            rootLayer.masksToBounds=true
            previewLayer.frame = rootLayer.bounds
            rootLayer.addSublayer(self.previewLayer)
            session.startRunning()
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let uiImage = UIImage(data: imageData)
            // 写真ライブラリに画像を保存
            UIImageWriteToSavedPhotosAlbum(uiImage!, nil,nil,nil)
            // シェア画面に移動
            let vc = EditViewController.instantiateFromStoryboard()
            vc.image = uiImage
            present(vc, animated: true, completion: nil)
            
            
        }
    }

    // clean up AVCapture
    func stopCamera(){
        session.stopRunning()
    }

}

