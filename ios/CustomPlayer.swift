import Foundation
import UIKit
import PlayerKit
import AVFoundation
import PencilKit


@available(iOS 13.0, *)
@objc(CustomPlayer)


class CustomPLayer: RCTViewManager {
  var mainCanvas = CanvasViewPk();
  
override func view() -> UIView! {
  return mainCanvas;
  }
  
  //save function not in work
  @available(iOS 14.0, *)
  @objc
  func save(_  resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
     // Save the drawing from the PKCanvasView
    let data = mainCanvas.pkView.drawing.dataRepresentation();
     if !data.isEmpty{
//       resolve("\(data)")
//       let stroke = mainCanvas.pkView.drawing.strokes
//       print(data);
//       print("String Data value")
//       var SD:String = String(decoding: data, as:UTF8.self)
//       resolve("\(SD)")
//       print("Stringvalue :",SD)
//       print("after string")
//       let DS = Data(SD.utf8)
//       print(type(of: DS))
//       print("\(String(decoding: DS, as:UTF8.self))")
       print("Data :",data);
       var nsdata = NSData(data: data)
       print("NSDATA :",nsdata);
       var normaldata = Data(referencing: nsdata)
//       resolve("\(nsdata)");
       var sd = String(decoding:data, as:UTF8.self)
       resolve(sd)
       mainCanvas.pkView.drawing = PKDrawing()
              do {
                let newdrawing = try PKDrawing(data: data )
                mainCanvas.pkView.drawing = newdrawing
              } catch {
                  print("error accured in getch data")
              }
     }
     else{
       let error = NSError(domain: "PKCanvasManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save drawing"])
       reject("PKCanvasManagerError", "Failed to save drawing", error)
     }
   }
//  undo
  @available(iOS 14.0, *)
  @objc
  func undo(_  resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    if ((mainCanvas.pkView.undoManager?.canUndo) == true){
       mainCanvas.pkView.undoManager?.undo();
      resolve("undoed")
     }

     else{
       let error = NSError(domain: "PKCanvasManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save drawing"])
       reject("PKCanvasManagerError", "Failed to save drawing", error)
     }
   }
//  redo
  @available(iOS 14.0, *)
  @objc
  func redo(_  resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    if ((mainCanvas.pkView.undoManager?.canRedo) == true){
       mainCanvas.pkView.undoManager?.redo();
      resolve("redoed")
     }
     else{
       let error = NSError(domain: "PKCanvasManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save drawing"])
       reject("PKCanvasManagerError", "Failed to save drawing", error)
     }
   }
// reset
  @available(iOS 14.0, *)
  @objc
  func reset(_  resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    if ((mainCanvas.pkView.undoManager?.canUndo) == true){
      let strokeCount = mainCanvas.pkView.drawing.strokes.count
      if (strokeCount > 0){
        for _ in 0...strokeCount{
          mainCanvas.pkView.undoManager?.undo();
        }
      }
     }
     else{
       let error = NSError(domain: "PKCanvasManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save drawing"])
       reject("PKCanvasManagerError", "Failed to save drawing", error)
     }
   }
//  eraser
  @available(iOS 14.0, *)
  @objc
  func eraser(_  resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    if (true){
      mainCanvas.pkView.tool = PKEraserTool(.bitmap);
      resolve("Eraser Slected!")
     }
     else{
       let error = NSError(domain: "PKCanvasManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save drawing"])
       reject("PKCanvasManagerError", "Failed to save drawing", error)
     }
   }
  
//  ?pen
  @available(iOS 14.0, *)
  @objc
  func pen(_  resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    if (true){
      mainCanvas.pkView.tool = PKInkingTool(.monoline,color: .blue,width:mainCanvas.strokeWidth as! CGFloat )
      resolve("Eraser Slected!")
     }
     else{
       let error = NSError(domain: "PKCanvasManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save drawing"])
       reject("PKCanvasManagerError", "Failed to save drawing", error)
     }
   }

  override static func requiresMainQueueSetup() -> Bool {
      return true
    }
  
  @objc
  override func constantsToExport() -> [AnyHashable : Any]! {
    return ["incraement":mainCanvas.value]
  }
 
}

@available(iOS 13.0, *)
@objc (CanvasViewPk)
class CanvasViewPk: UIView {
  
  var value = 20;
  @objc var pkView:PKCanvasView!
  @objc var strokeWidth:NSNumber = 3{
    didSet{
      pkView.tool = PKInkingTool(.monoline,color: .blue,width:strokeWidth as? CGFloat)
    }
  }
  @objc var applepencile:Bool = true{
    didSet{
      pkView.allowsFingerDrawing=applepencile
      
    }
  }
  @objc var positionArray:NSArray = NSArray(objects: 200,200){
    didSet{
      var arr1 = positionArray
      var objCArray = NSMutableArray(array: arr1)
      if let swiftArray = objCArray as NSArray as? [String] {
        pkView.frame = CGRect(x: 0, y: 0, width: Int(swiftArray[0])! , height: Int(swiftArray[1])!)
        if #available(iOS 14.0, *) {
        } else {
        }
      }
    }
  }
  override init(frame:CGRect){
    super.init(frame: frame)
    pkView = PKCanvasView();
    pkView.backgroundColor = .clear
    pkView.allowsFingerDrawing = true
    pkView.isOpaque = false
    pkView.drawing = PKDrawing()
    pkView.tool = PKInkingTool(.monoline,color: .black,width:5 )
    pkView.undoManager?.enableUndoRegistration()
    self.addSubview(pkView)
  }

  required init?(coder aDecoder:NSCoder){
    fatalError("init(coder:) has not implemented")
  }
}


