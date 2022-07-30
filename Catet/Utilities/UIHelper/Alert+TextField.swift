//
//  Alert+TextField.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import Foundation
import SwiftUI

enum alertMode: String{
    case add
    case edit
}

struct AlertControllerView: UIViewControllerRepresentable{
    @ObservedObject var learningViewModel: LearningViewModel
    @Binding var learningTitleTextField: String
    @Binding var showAlert: Bool
    var alertTitle: String
    var alertMessage: String
    var alertMode: alertMode
    var learning: LearningEntity?
    
    mutating func forLearning(learning: LearningEntity){
        self.learning = learning
    }
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        if self.showAlert{
            let addAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            addAlert.addTextField { (textField) in
                textField.text = self.learningTitleTextField
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){ _ in
                self.learningTitleTextField = ""
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { [self, unowned addAlert] _ in
                if let textField = addAlert.textFields?.first, let text = textField.text {
                    self.learningTitleTextField = text
                }
                if alertMode == .add{
                    learningViewModel.addLearning(title: learningTitleTextField)
                    self.learningTitleTextField = ""
                }
                else if alertMode == .edit{
                    guard let learning = learning else {
                        return
                    }
                    learning.title = learningTitleTextField
                    learningViewModel.renameLearning(learning: learning, newTitle: learningTitleTextField)
                }
                
            }
            
            saveAction.isEnabled = false
            addAlert.addAction(cancelAction)
            addAlert.addAction(saveAction)
            addAlert.view.tintColor = UIColor(named: Theme.accentColor.rawValue)
            NotificationCenter
                .default
                .addObserver(forName: UITextField.textDidChangeNotification,
                             object:addAlert.textFields?[0],
                             queue: OperationQueue.main) {
                    (notification) -> Void in
                let textFieldEmail = addAlert.textFields![0]
                saveAction.isEnabled = !textFieldEmail.text!.isEmpty
            }
            DispatchQueue.main.async {
                uiViewController.present(addAlert, animated: true) {
                    self.showAlert = false
                }
            }
        }
    }
    
    func makeCoordinator() -> AlertControllerView.Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var control: AlertControllerView
        init(_ control: AlertControllerView) {
            self.control = control
        }
        
    }
    
    
}
