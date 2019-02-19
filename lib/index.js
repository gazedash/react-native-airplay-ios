import {
  requireNativeComponent,
  NativeModules,
  NativeEventEmitter,
  Platform
} from "react-native";

import { withAirPlayControl as hoc } from './withAirPlayControl'

const { RNAirplay } = NativeModules;

// Export methods and button component
export const AirPlay = RNAirplay;

export const AirPlayListener = new NativeEventEmitter(RNAirplay);

export const AirPlayButton =
  Platform.OS === "ios" ? requireNativeComponent("RNAirplay") : () => null;

export const withAirPlayControl = hoc