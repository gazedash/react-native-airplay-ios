# react-native-airplay-btn
AirPlay library for iOS

##Installation
npm i react-native-airplay-btn --save

#### Only iOS

  - Open your Xcode project
  - In `Libraries` choose `Add files...` and add the files `AirPlay.swift, AirPlayBridge.m, AirPlayButtonBridge.m` from the `node_modules/react-native-airplay-btn` folder. Be sure that the option `copy if needed` is unchecked.
  - If Xcode asks you to include 'Bridging-Herder.h', accept it
  - Include in the `Bridging-Herder.h` the next lines:
  ```
  #import <React/RCTViewManager.h>
  #import <React/RCTEventEmitter.h>
  ```

  - Rebuild your project and done!

### How to create listeners

```js
import { NativeEventEmitter, NativeModules }
const airPlayEvt = new NativeEventEmitter(NativeModules.AirPlay);

```

## Methods

```js
  // typically located in componentDidMount
  AirPlay.startScan() --> // scan for airplay devices
  this.airPlayAvailable = airPlayEvt.addListener('airplayAvailable', devices => this.setState({
        airPlayAvailable: devices.available,
  })); --> returns a boolean

  this.airPlayConnected = airPlayEvt.addListener('airplayConnected', devices => this.setState({
        airPlayConnected: devices.connected,
  })); --> returns a boolean

  AirPlay.disconnect --> // disconnect from AVAudioSession
```

### Create AirPlay Button

```js
import { AirPlay } from 'react-native-airplay-btn';

<AirPlayButton style={{height: 30, width: 30, justifyContent: 'center',alignItems:'center' }} />
```



## Author

Nadia Dillon
