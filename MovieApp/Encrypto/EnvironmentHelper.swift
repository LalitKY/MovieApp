//
//  EnvironmentHelper.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation
import CryptoSwift

/// This class to decrypt encrypted files save in app bungle at run time.
/// Script file and files to be decypted are not included in targets
final class EnvironmentHelper {
    
    static let sharedInstance = EnvironmentHelper()
    var appUrl: String?
    var apiKey: String?
    var imagePrefixUrl: String?
    
    private init() {}
    
    /// This method is to decrypt plist files data sored in app bundle
    func decryptPlist() {
        var plistData: [String: AnyObject] = [:] //Our secure data
        do {
            if let path = Bundle.main.path(forResource: EnvironmentConstants.ENVIRONMENT_FILE_NAME, ofType: EncryptionConstants.ENC_STRING)  {
                let data_enc = NSData.init(contentsOfFile: path)! as Data
                let aes = try AES(key: [UInt8](hex: String(EncryptionConstants.ENV_HEX_CODE)), blockMode: ECB(), padding: .noPadding)
                let decryptedDta = try data_enc.decrypt(cipher: aes)
                var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
                plistData = try PropertyListSerialization.propertyList(from: decryptedDta, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            }
        }catch {
            debugPrint("Environment Helper :\(error)")
        }
        if let app_url = plistData["app_url"] as? String {
            appUrl = app_url
        }
        if let api_key = plistData["api_key"] as? String {
            apiKey = api_key
        }
        if let image_prefix_url = plistData["image_prefix_url"] as? String? {
            imagePrefixUrl = image_prefix_url
        }
    }
        
}
