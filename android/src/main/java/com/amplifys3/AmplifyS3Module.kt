package com.amplifys3

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise

import android.util.Log
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.storage.s3.AWSS3StoragePlugin
import java.io.File

class AmplifyS3Module(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun setup(promise: Promise) {
    try {
        // Add these lines to add the AWSCognitoAuthPlugin and AWSS3StoragePlugin plugins
        Amplify.addPlugin(AWSCognitoAuthPlugin())
        Amplify.addPlugin(AWSS3StoragePlugin())
        Amplify.configure(applicationContext)

        Log.i("MyAmplifyApp", "Initialized Amplify")
        promise.resolve(true)
    } catch (error: AmplifyException) {
        Log.e("MyAmplifyApp", "Could not initialize Amplify", error)
        promise.reject()
    }
  }

  @ReactMethod
  private fun uploadFile(promise: Promise) {
    val exampleFile = File(applicationContext.filesDir, "ExampleKey")
    exampleFile.writeText("Example file contents")

    Amplify.Storage.uploadFile("ExampleKey", exampleFile,
        { Log.i("MyAmplifyApp", "Successfully uploaded: ${it.key}") },
        { Log.e("MyAmplifyApp", "Upload failed", it) }
    )

    promise.resolve
  }

  companion object {
    const val NAME = "AmplifyS3"
  }
}
