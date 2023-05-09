//
//  StringError.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? {return self}
}
