//
//  TextView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//


import Foundation
import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
    @Binding var isEditing: Bool
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
//        textView.isEditable = true
        textView.dataDetectorTypes = .link
        textView.autocorrectionType = .no
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)

        if isEditing {
            uiView.isEditable = true
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
            }
            print("TRUE INI DITRIGGER")
        }
        else{
            uiView.isEditable = false
            print("False INI DITRIGGER")
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate{
        var text: Binding<String>

        init(_ text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
        
    }

}
