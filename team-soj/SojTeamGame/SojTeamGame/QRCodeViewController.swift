//
//  QRCodeViewController.swift
//  SojTeamGame
//
//  Created by Sonny on 2018/5/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    
    let fullSize = UIScreen.main.bounds.size
    var qrCodeFrameView = UIView()
    var codeLabel = UILabel()
    var CoinLabel = UILabel()
    var showCoinLabel = UILabel()
    var session = AVCaptureSession()
    var preViewLayer = AVCaptureVideoPreviewLayer()
    var labeltext: String!
    var receiptNum7start: String? = ""
//    var receiptNum3:String = ""
    var finalText = ""
    var output = AVCaptureMetadataOutput()
    var deviceInput = DeviceInput()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        session.addInput(deviceInput.backWildAngeCamera!)
        session.addOutput(output)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        //dump(output.availableMetadataObjectTypes)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.global())
        
        session.startRunning()
    }

    override func viewWillLayoutSubviews() {
        //顯示掃描內容 label
        layoutSetting()
        //顯示掃描 QRCode 預覽畫面
        settingPreviewLayer()
        

        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //設定兩個 label 的位置、範圍
    func layoutSetting() {
        
        //設定掃描內容 label 的位置、大小、範圍
        codeLabel.frame = CGRect(x: ((fullSize.width-300)/2), y: 400, width: 300, height: 40)
        codeLabel.backgroundColor = UIColor.clear
        codeLabel.layer.borderColor = UIColor.gray.cgColor
        codeLabel.layer.borderWidth = 2
        codeLabel.textColor = UIColor.black
        codeLabel.font = UIFont.systemFont(ofSize: 24)
        codeLabel.textAlignment = NSTextAlignment.center
        codeLabel.numberOfLines = 2
        codeLabel.textAlignment = .center
        
        //顯示"金額" label
        CoinLabel.frame = CGRect(x: ((fullSize.width-300)/2), y: 480, width: 150, height: 40)
        CoinLabel.backgroundColor = UIColor.clear
        CoinLabel.layer.borderColor = UIColor.gray.cgColor
        CoinLabel.layer.borderWidth = 2
        CoinLabel.textColor = UIColor.black
        CoinLabel.font = UIFont.systemFont(ofSize: 24)
        CoinLabel.textAlignment = NSTextAlignment.center
        CoinLabel.numberOfLines = 2
        CoinLabel.text = "現有金額"
        CoinLabel.textAlignment = .center
        
        ////顯示 "現有金額" label
        showCoinLabel.frame = CGRect(x: ((fullSize.width-300)/2 + 180), y: 480, width: 120, height: 40)
        showCoinLabel.backgroundColor = UIColor.clear
        showCoinLabel.layer.borderColor = UIColor.gray.cgColor
        showCoinLabel.layer.borderWidth = 2
        showCoinLabel.textColor = UIColor.black
        showCoinLabel.font = UIFont.systemFont(ofSize: 24)
        showCoinLabel.textAlignment = NSTextAlignment.center
        showCoinLabel.numberOfLines = 2
        showCoinLabel.text = "\(Record.current.coin)"
        showCoinLabel.textAlignment = .center
        
        
//        self.view.addSubview(codeLabel)
        self.view.addSubview(CoinLabel)
        self.view.addSubview(showCoinLabel)
//        self.view.addSubview(typeLabel)
        
    }//end of layoutSetting()

   
    func settingPreviewLayer() {
        
        //設定camera scan 在螢幕上的圓形視窗
        preViewLayer.frame = CGRect(x: ((fullSize.width-300)/2), y: 80, width: 300 , height: 300)
        preViewLayer.cornerRadius = 150
        preViewLayer.borderWidth = 4
        preViewLayer.borderColor = UIColor.blue.cgColor
        preViewLayer.session = session
        preViewLayer.videoGravity = .resizeAspectFill
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        view.layer.addSublayer(preViewLayer)
        print("Enable prevewlayer")
        
        //
        preViewLayer.addSublayer(qrCodeFrameView.layer)
    }//end of settingPreviewLayer()
    
    
    //使用 metadataOutput 掃描、輸出 QRCode內容
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //        print("output from metadataOutput")
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            
            DispatchQueue.main.async {
                self.qrCodeFrameView.frame = CGRect.zero
                self.preViewLayer.borderWidth = 4
                self.preViewLayer.borderColor = UIColor.blue.cgColor
                self.codeLabel.text = ""
                
                
            }
        }
        for metaData in metadataObjects {
            if let data = metaData as? AVMetadataMachineReadableCodeObject
            {
                let barCodeObject = preViewLayer.transformedMetadataObject(for: metaData)
                DispatchQueue.main.async {
                    self.qrCodeFrameView.frame = barCodeObject!.bounds
                    self.preViewLayer.borderWidth = 4
                    self.preViewLayer.borderColor = UIColor.green.cgColor
                    //將掃描到的 QRcode 資料丟到 labeltext
                    self.labeltext = data.stringValue
                    print("labeltext : \(self.labeltext)")
                    
//                    self.apiDecode()
                    self.labelTextSetting()
                    
                }
            }
        }//end of metadataoutput
    

    }
    
    //顯示掃描資料到對應 label
    func labelTextSetting() {
        
        //擷取 QRcode 內容並分段
        let receiptNum10start = String(labeltext.prefix(10))
        receiptNum7start = String(labeltext.prefix(7))
        
//        let receiptNum3start = labeltext.index(labeltext.startIndex, offsetBy:7)
//        let receiptNum3end = labeltext.index(receiptNum3start, offsetBy:3)
        finalText = String(labeltext.dropFirst(7))
//        receiptNum3 = String(labeltext[ receiptNum3start ..< receiptNum3end])
        print(finalText)
        //顯示 QRcode 內容
        codeLabel.text = receiptNum7start
//        showCoinLabel.text = receiptNum3

        comparemetadata()
        
//        typeLabel.textColor = UIColor.red

    }//end of labelTextSetting()
 
    
    
    func comparemetadata() {
        if receiptNum7start == "AppCamp" {
            session.stopRunning()
            print("the metadata is correct")
            popokAlert()

        }
    }//end of comparemetadata
    
//    func popokAlert() {
//
//
//        self.view.addSubview(okAlert)
//
//
//    }//end of popAlert
    
    
    @objc func popokAlert() {
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "恭喜",
            message: "成功儲值 \(finalText)，按下確認返回",
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                Record.current.addCoin(addCoin: Int(self.finalText)!)
                self.showCoinLabel.text = "\(Record.current.coin)"
                print(Record.current.coin)
                print("按下確認後，閉包裡的動作")
                self.navigationController?.popViewController(animated: true)
        })
        
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
//                Record.current.addCoin(addCoin: Int(self.finalText)!)
                self.showCoinLabel.text = "\(Record.current.coin)"
                self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
    
}//end of Class

