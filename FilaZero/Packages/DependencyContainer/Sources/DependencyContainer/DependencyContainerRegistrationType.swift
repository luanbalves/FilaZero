//
//  DependencyContainerRegistrationType.swift
//
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation

public enum DependencyContainerRegistrationType {
    case singlesInstance(AnyObject)
    case closureBased (() -> Any)
}
