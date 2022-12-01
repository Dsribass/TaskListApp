//
//  Util.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/12/22.
//

import Foundation

extension CaseIterable where Self: Equatable {
  var index: Self.AllCases.Index? {
    return Self.allCases.firstIndex { self == $0 }
  }
}
