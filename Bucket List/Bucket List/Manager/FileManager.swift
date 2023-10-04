//
//  FileManager.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/03.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
