# react-native-airplay-btn
AirPlay library for iOS

## Installation with Automatic Linking
```js
npm i react-native-airplay-btn --save
react-native link
```

### How to create listeners

```js
import { AirPlayListener } from react-native-airplay-btn

this.airPlayConnected = AirPlayListener.addListener('deviceConnected', ({ devices }) => this.setState({
    devices,
})); --> returns a boolean


// Remove Listener in componentWillUnmount
this.deviceConnected.remove();
```

Devices is an array of objects that contains information about currently connected audio output(s):
```js
[{deviceName: "Some Bluetooth Headphones Model", portType: "BluetoothA2DPOutput"}]
// or
[{deviceName: "Speakers", portType:"Speakers"}]
// or
[{deviceName: "Andrey’s Apple TV", portType: "AirPlay"}]
```

Probably it could just be an object, but internally AVAudioSessionRouteDescription returns array, so there *might* be a case when there is more than one device connected at the time.

## Methods

```js
  AirPlay.startScan();
  
  AirPlay.disconnect();
```

### Create AirPlay Button

```js
import { AirPlayButton } from 'react-native-airplay-btn';

<Button style={{ height: 30, width: 30, justifyContent: 'center', alignItems:'center' }} />
```

Note: The AirPlay Button does not show in the simulator


## Author

Original author of the library:

Nadia Dillon

Modifications:

Andrey Efremov (gazedash)
