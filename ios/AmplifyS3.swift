import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin

@objc(AmplifyS3)
class AmplifyS3: NSObject {

  @objc(setup:withResolver:withRejecter:)
  func setup(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSS3StoragePlugin())
        try Amplify.configure()
        print("Amplify configured with Auth and Storage plugins")
        resolve(true)
    } catch {
        print("Failed to initialize Amplify with \(error)")
        reject(true)
    }
  }

  @objc(uploadFile:withResolver:withRejecter:)
  func uploadFile(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) async throws -> Void {
    let dataString = "Example file contents"
    let data = Data(dataString.utf8)
    let uploadTask = Amplify.Storage.uploadData(
        key: "ExampleKey",
        data: data
    )
    Task {
        for await progress in await uploadTask.progress {
            print("Progress: \(progress)")
        }
    }
    let value = try await uploadTask.value
    print("Completed: \(value)")

    resolve(true)
  }
}
