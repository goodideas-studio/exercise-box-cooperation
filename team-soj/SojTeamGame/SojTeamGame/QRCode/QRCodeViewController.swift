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
    var receiptNum8:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        CoinLabel.frame = CGRect(x: ((fullSize.width-300)/2), y: 480, width: 80, height: 40)
        CoinLabel.backgroundColor = UIColor.clear
        CoinLabel.layer.borderColor = UIColor.gray.cgColor
        CoinLabel.layer.borderWidth = 2
        CoinLabel.textColor = UIColor.black
        CoinLabel.font = UIFont.systemFont(ofSize: 24)
        CoinLabel.textAlignment = NSTextAlignment.center
        CoinLabel.numberOfLines = 2
        CoinLabel.text = "金額"
        CoinLabel.textAlignment = .center
        
        ////顯示 "儲值金額" label
        showCoinLabel.frame = CGRect(x: ((fullSize.width-300)/2 + 100), y: 480, width: 200, height: 40)
        showCoinLabel.backgroundColor = UIColor.clear
        showCoinLabel.layer.borderColor = UIColor.gray.cgColor
        showCoinLabel.layer.borderWidth = 2
        showCoinLabel.textColor = UIColor.black
        showCoinLabel.font = UIFont.systemFont(ofSize: 24)
        showCoinLabel.textAlignment = NSTextAlignment.center
        showCoinLabel.numberOfLines = 2
        showCoinLabel.text = "appCoin:400"
        showCoinLabel.textAlignment = .center
        
        
        self.view.addSubview(codeLabel)
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
//                    self.labeltext = data.stringValue
                    
//                    self.apiDecode()
//                    labelTextSetting()
                    
                }
            }
        }//end of metadataoutput
    

    }
    
    func labelTextSetting() {
        let receiptNum2start = String(labeltext.prefix(7))
        //                    let receiptNum2start = labeltext.index(labeltext.startIndex,offsetBy:0)
        //                    let receiptNum2end = labeltext.index(receiptNum2start, offsetBy:2)
        //                    let receiptNum2 = String(labeltext[ receiptNum2start ..< receiptNum2end ])
        let receiptNum8start = labeltext.index(labeltext.startIndex, offsetBy:2)
        let receiptNum8end = labeltext.index(receiptNum8start, offsetBy:8)
        //                    let range2to8 = receiptNum8start..<receiptNum8end
        //                    receiptNum8 = String(labeltext[range2to8])
        receiptNum8 = String(labeltext[ receiptNum8start ..< receiptNum8end])
        codeLabel.text = (" 發票號碼: " + receiptNum2start + " - " + receiptNum8 )
//        typeLabel.textColor = UIColor.red
//        typeLabel.text = comparemsg
        
    }//end of labelTextSetting()
    
    
}//end of Class

