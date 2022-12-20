//
//  CoolWebViewManager.swift
//  TestProject
//
//  Created by apple on 08/12/22.
//

import Foundation

@objc(CoolWebViewManger)

class CoolWebViewManger:RCTViewManager {
  
  override func view() -> UIView!{
    
    let lable = UILabel()
    lable.text = "HelloHello"
    lable.textAlignment = .center
    return lable
    
  }
  @objc override static func requiresMainQueueSetup()->Bool{
    return false
  }
  
}
