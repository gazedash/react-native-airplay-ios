import React from 'react'
import { View, Text } from 'react-native'
import { withAirPlayControl } from 'react-native-airplay-ios'

type Device = {
  deviceName: string,
  portName: string,
}

type Props = {
  devices: Device[],
}

// Shows currently connected audio output devices
export const AirPlayDevice = withAirPlayControl(({ devices }: Props) => (
  <View style={{ flex: 1, alignItems: 'center' }}>
    {devices.map((device) => (
      <Text>
        {device.deviceName} {device.portName}
      </Text>
    ))}
  </View>
))
