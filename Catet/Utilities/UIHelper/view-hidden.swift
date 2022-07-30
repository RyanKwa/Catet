//
//  isHidden.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 25/07/22.
//

import SwiftUI

public extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove{
                self.hidden()
            }
        }
        else{
            self
        }
    }
}
