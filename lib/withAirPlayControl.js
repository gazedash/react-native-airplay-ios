import React from 'react'
import hoistNonReactStatic from 'hoist-non-react-statics'
import { Platform } from 'react-native'
import { AirPlayListener, AirPlay } from 'react-native-airplay-ios'

type Props = {}

function _AirPlayControl(WrappedComponent) {
  class Enhance extends React.Component<Props> {
    state = {
      devices: [],
    }
    componentDidMount() {
      AirPlay.startScan()
      this.deviceConnected = AirPlayListener.addListener(
        'deviceConnected',
        ({ devices }) => {
          console.log(devices)
          this.setState({
            devices,
          })
        }
      )
    }

    componentWillUnmount() {
      this.deviceConnected.remove()
    }

    render() {
      return <WrappedComponent devices={this.state.devices} {...this.props} />
    }
  }

  hoistNonReactStatic(Enhance, WrappedComponent)
  return Enhance
}

export const withAirPlayControl = Platform.select({
  ios: _AirPlayControl,
  android: () => () => null,
})
