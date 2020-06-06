//
//  File.swift
//  Keychain+BiometricsHelper
//
//  Created by Tema.Tian on 2020/6/5.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import LocalAuthentication
import KeychainAccess

typealias BiometricsFallBack = () -> Void
typealias BiometricsCallBack = (_ useable: Bool, _ success: Bool, _ error: Error?) -> Void

class BiometricsHelper {

  static let DEVICEFINGERPRINT = "com.keychain.com"
  static let SERVICE = "com.keychain.service.com"

  class func isFingerprintChange() -> Bool {
    let data = self.getDeviceFingerprint()
    if data.isNone && self.isLockout() {
      return false
    } else {
      let oldData = self.getSavedDeviceFingerprint()
      if oldData.isNone {
        return false
      } else if oldData == data {
        return false
      } else {
        return true
      }
    }
  }

  open class func deviceOwnerAuthenticationWithBiometrics(title: String, fallbackTitle: String?, fallbackBlock: BiometricsFallBack?, resultBlock: BiometricsCallBack?) {
    let context = LAContext();
    context.localizedFallbackTitle = fallbackTitle
    var useableError: NSError?
    if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &useableError) {
      context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: title) { (success, error) in
        DispatchQueue.main.async {
          if success {
            if resultBlock.isSome {
              resultBlock!(true, success, error)
              _ = saveDeviceFingerprint()
            }
          } else {
            guard let error = error else { return }
            print("ErrorCode:\(error._code) errorMsg:\(error.localizedDescription)")
            if error._code == LAError.userFallback.rawValue {
              if fallbackBlock.isSome {
                fallbackBlock!()
              }
            } else if error._code == LAError.biometryLockout.rawValue {
              self.deviceOwnerAuthentication(title: title, resultBlock: resultBlock)
            } else {
              if resultBlock.isSome {
                resultBlock!(false, success, error)
              }
            }
          }
        }
      }
    } else {
      print("ErrorCode:\(String(describing: useableError?._code)) errorMsg:\(String(describing: useableError?.localizedDescription))")
      if useableError?.code == LAError.biometryLockout.rawValue {
        self.deviceOwnerAuthentication(title: title, resultBlock: resultBlock)
      } else {
        if resultBlock.isSome {
          resultBlock!(false, false, useableError)
        }
      }
    }
  }

  private class func deviceOwnerAuthentication(title: String, resultBlock: BiometricsCallBack?) {
    let context = LAContext();
    context.localizedFallbackTitle = ""
    var useableError: NSError?
    if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &useableError) {
      context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: title) { (success, error) in
        DispatchQueue.main.async {
          if resultBlock.isSome {
            resultBlock!(true, success, error)
          }
        }
        guard let error = error else{ return }
        print("ErrorCode:\(error._code) errorMsg:\(error.localizedDescription)")
      }
    } else {
      print("ErrorCode:\(String(describing: useableError?._code)) errorMsg:\(String(describing: useableError?.localizedDescription))")
      if resultBlock.isSome {
        resultBlock!(false, false, useableError)
      }
    }
  }

  private class func getSavedDeviceFingerprint() -> Data? {
    let keychain = Keychain(service: SERVICE)
    return keychain[data: DEVICEFINGERPRINT]
  }
  
  private class func saveDeviceFingerprint() -> Bool {
    if let data = self.getDeviceFingerprint(){
      let keychain = Keychain(service: SERVICE)
      keychain[data: DEVICEFINGERPRINT] = data
      return true;
    } else {
      return false;
    }
  }

  private class func getDeviceFingerprint() -> Data? {
    let context = LAContext()
    var error: NSError? = nil;
    if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      return context.evaluatedPolicyDomainState
    }
    print("ErrorCode:\(String(describing: error?._code)) errorMsg:\(String(describing: error?.localizedDescription))")
    return nil
  }

  private class func isLockout() -> Bool {
    let context = LAContext()
    var error: NSError?
    context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
    guard error != nil else { return false }
    if error!.code == LAError.biometryLockout.rawValue {
      return true
    } else {
      return false
    }
  }
}

