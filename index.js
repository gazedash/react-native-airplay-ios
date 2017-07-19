import React, { Component } from 'react';
import {
  requireNativeComponent,
  NativeModules,
  NativeEventEmitter
} from 'react-native';

const { AirPlay } = NativeModules;

// Listen to emitted events

const airPlayEmitter = new NativeEventEmitter(AirPlay);

const isAvailable = airPlayEmitter.addListener('airplayAvailable', (devices) => devices.available)
const isConnected = airPlayEmitter.addListener('airplayConnected', (devices) => devices.connected)


// Export methods and button component

export default {
  startScan: function() {
    AirPlay.startScan()
  },

  isAlreadyConnected: function() {
    AirPlay.isAlreadyConnected()
  },

  disconnect: function() {
    AirPlay.disconnect();
  }

  Button: requireNativeComponent('RNAirplay'),
}
