//
//  DeviceInput.swift
//  SojTeamGame
//
//  Created by Sonny on 2018/5/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation
import AVFoundation

class DeviceInput :NSObject {
    
    //宣告手機相機名稱 ：
    var backWildAngeCamera : AVCaptureDeviceInput?
    var frontWildAngleCamera : AVCaptureDeviceInput?
    var backTelePhotoCamera : AVCaptureDeviceInput?
    var backDualCamera : AVCaptureDeviceInput?
    
    
    func getAllCameras() {
        let cameraDevices = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInWideAngleCamera, .builtInTelephotoCamera,.builtInDualCamera], mediaType: .video, position: .unspecified).devices
        for camera in cameraDevices {
            let inputDevices = try! AVCaptureDeviceInput(device: camera)
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .front {
                frontWildAngleCamera = inputDevices
            }
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .back {
                backWildAngeCamera = inputDevices
            }
            if camera.deviceType == .builtInTelephotoCamera {
                backTelePhotoCamera = inputDevices
            }
            if camera.deviceType == .builtInDualCamera {
                backDualCamera = inputDevices
            }
        }
    }
    
    override init() {
        super.init()
        //開始偵測手機上的 camera
        getAllCameras()

    }
    
    
}
