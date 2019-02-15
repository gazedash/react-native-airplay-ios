import {
  requireNativeComponent,
  NativeModules,
  NativeEventEmitter,
  Platform
} from "react-native";

const { RNAirplay } = NativeModules;

// Export methods and button component
export const AirPlay = RNAirplay;

export const AirPlayListener = new NativeEventEmitter(RNAirplay);

export const AirPlayButton =
  Platform.OS === "ios" ? requireNativeComponent("RNAirplay") : () => null;
