import React, {useState, useRef} from 'react';
import {
StyleSheet,Text,View,NativeModules,requireNativeComponent,Image,TouchableOpacity,Button,} from 'react-native';
import CanvasPk from './nativecomponents/CanvasPk';
import ViewShot from 'react-native-view-shot';
import AppleSketch from './components';



const App = () => {
  const [imagevalue, setImageVlaue] = useState(
    '/Users/apple/Library/Developer/CoreSimulator/Devices/9C3BBE07-AB80-4385-94BE-02FFD7784BE9/data/Containers/Data/Application/870132C1-2C4F-4E10-B9E5-400C040F5961/tmp/ReactNative/236E9DD6-A45E-4D23-ACA6-BE18363ED020.png',
  );
  const ref = useRef(null);
  const takeImage = () => {
    ref?.current?.capture().then(uri => {
      console.log('do something with ', uri);
      setImageVlaue(`${uri}`);
    });
  };
  const [sw, setSw] = useState(2);
  const appleSketchRef = useRef();
  return (
    <View style={styles.container}>
      
      <AppleSketch
      ref={appleSketchRef}
      strokeWidth={5}
      canvasWidth={300}
      canvasHeight={300}
      drawOnApple={false}
      backgroundColor={"red"}
      backgroundImageurl={'https://images.pexels.com/photos/4835429/pexels-photo-4835429.jpeg?auto=compress&cs=tinysrgb&w=800'}
      />

      <Button title='undo' onPress={()=>{appleSketchRef?.current?.undo()}}/>
      <Button title='redo' onPress={()=>{appleSketchRef?.current?.redo()}}/>
      <Button title='save' onPress={()=>{console.log(appleSketchRef?.current?.saveImage())}}/>
      <Button title='reset' onPress={()=>{appleSketchRef?.current?.reset()}}/>
      <Button title='eraser' onPress={()=>{appleSketchRef?.current?.eraser()}}/>
      <Button title='pen' onPress={()=>{appleSketchRef?.current?.pen()}}/>
     
    </View>
  );
};
export default App;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});
