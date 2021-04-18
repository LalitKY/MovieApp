//
//  Constants.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation

public struct EncryptionConstants {
    static let ENC_STRING = "enc"
    // Save this hex code in Keychain and fetch it from there to use
    static let ENV_HEX_CODE = "3132333435363738393031323334121212383930313233343536373839303132"
}

struct EnvironmentConstants {
     static let ENVIRONMENT_FILE_NAME = "Environment"
}

struct AppConstants {
    
    struct CellConstants {
        static let moveiCellID = "movie_cell_id"
        static let skeletonCellID = "skeleton_cell_id"
    }
    
}
