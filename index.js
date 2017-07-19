import React, { Component } from 'react';
import {
  requireNativeComponent,
  NativeModules,
  NativeEventEmitter
} from 'react-native';

const { RNAirplay } = NativeModules;

// Listen to emitted events

const airPlayEmitter = new NativeEventEmitter(RNAirplay);

// Register Events

const isAvailable = airPlayEmitter.addListener('airplayAvailable', (devices) => devices.available)
const isConnected = airPlayEmitter.addListener('airplayConnected', (devices) => devices.connected)


// Export methods and button component

export const AirPlay = RNAirplay;

export const AirPlayListener = airPlayEmitter;

export const AirPlayButton = requireNativeComponent('RNAirplay');
