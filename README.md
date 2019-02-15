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

this.airPlayConnected = AirPlayListener.addListener('deviceConnected', device => this.setState({
    device,
})); --> returns a boolean


// Remove Listener in componentWillUnmount
this.deviceConnected.remove();
```

Device is an object that contains information about currently connected audio output:
```js
{deviceName: "Some Bluetooth Headphones Model", portType: "BluetoothA2DPOutput"}
// or
{deviceName: "Speaker", portType: "Speaker"}
// or
{deviceName: "Andrey’s Apple TV", portType: "AirPlay"}
```

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
