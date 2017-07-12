# react-native-airplay-btn
AirPlay library for iOS

##Installation
npm i https://github.com/ndillon1/react-native-airplay-btn --save

#### Only iOS

  - Open your Xcode project
  - In `Libraries` choose `Add files...` and add the files `AirPlay.swift, AirPlayBridge.m, AirPlayButtonBridge.m` from the `node_modules/react-native-airplay-btn` folder. Be sure that the option `copy if needed` is unchecked.
  - If Xcode ask you for include the 'Bridging-Herder.h', accept it
  - Include in the `Bridging-Herder.h` the next lines:
  ```
  #import <React/RCTViewManager.h>
  #import <React/RCTEventEmitter.h>
  ```

  - Rebuild your project and done!


## Author

Nadia Dillon
