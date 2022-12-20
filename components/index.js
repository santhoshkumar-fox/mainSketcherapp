import { StyleSheet, Text, View,NativeModules,Image} from 'react-native'
import React, { useState,useRef,useImperativeHandle, forwardRef } from 'react'
import ViewShot from "react-native-view-shot"
import CanvasPk from '../nativecomponents/CanvasPk'

const AppleSketchvalue = forwardRef(({strokeWidth,canvasWidth,canvasHeight,drawOnApple,backgroundColor,backgroundImageurl},ref) => {
    const imageref = useRef();
    const SketchRedo = async () => {
        try {
          NativeModules.CustomPlayer.redo()
            .then(result =>
              console.log('result for resolve :', JSON.stringify(result)),
            )
            .catch(e => console.log(e.message, e.code));
        } catch (error) {}
      };
      const sketchUndo = async () => {
        try {
          NativeModules.CustomPlayer.undo()
            .then(result =>
              console.log('result for resolve :', JSON.stringify(result)),
            )
            .catch(e => console.log(e.message, e.code));
        } catch (error) {}
      };
      const sketchReset = async () => {
        try {
          NativeModules.CustomPlayer.reset()
            .then(result =>
              console.log('result for resolve :', JSON.stringify(result)),
            )
            .catch(e => console.log(e.message, e.code));
        } catch (error) {}
      };
      const sketchEraser = async () => {
        try {
          NativeModules.CustomPlayer.eraser()
            .then(result =>
              console.log('result for resolve :', JSON.stringify(result)),
            )
            .catch(e => console.log(e.message, e.code));
        } catch (error) {}
      };
      const sketchPen = async () => {
        try {
          NativeModules.CustomPlayer.pen()
            .then(result =>
              console.log('result for resolve :', JSON.stringify(result)),
            )
            .catch(e => console.log(e.message, e.code));
        } catch (error) {}
      };
      const saveAsImage = () => {
        imageref?.current?.capture().then(uri => {
          return ("hi")
        });
      };

      useImperativeHandle(ref,()=>{
        return{
            redo(){
                SketchRedo();
            },
            undo(){
                sketchUndo();
            },
            reset(){
                sketchReset();
            },
            eraser(){
                sketchEraser();
            },
            pen(){
                sketchPen();
            },
            saveImage(){
                saveAsImage();
            }
        }
      })
  return (
    <ViewShot
    style={{width: canvasWidth, height: canvasHeight, backgroundColor: backgroundColor}}
    ref={imageref}>
    <Image
      source={{
        url: backgroundImageurl,
      }}
      style={[{width: '100%', height: '100%'}, StyleSheet.absoluteFill]}
    />
      <CanvasPk
          strokeWidth={strokeWidth}
          style={{width: canvasWidth, height: canvasHeight}}
          applepencile={!drawOnApple}
          positionArray={[`${canvasWidth}`, `${canvasWidth}`]}
        />
    </ViewShot>
  )
})
export default AppleSketchvalue




const styles = StyleSheet.create({})