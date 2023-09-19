import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-amplify-s3' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const AmplifyS3 = NativeModules.AmplifyS3
  ? NativeModules.AmplifyS3
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function setup(): Promise<boolean> {
  return AmplifyS3.setup();
}

export function uploadFile(): Promise<boolean> {
  return AmplifyS3.uploadFile();
}