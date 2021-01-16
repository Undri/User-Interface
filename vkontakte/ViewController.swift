//
//  ViewController.swift
//  GeekFirst
//
//  Created by Kovalev Alexander on 11.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var scrollView: UIScrollView?
    

    private var keyboardShown = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
        addTapGestureRecognizer()
    }

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
  
    private func addTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: passwordTextField, action: #selector(resignFirstResponder))
        view.addGestureRecognizer(recognizer)
    }
    

    @objc private func keyboardWillShow(notification: Notification) {
        guard !keyboardShown else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        scrollView?.contentInset.bottom += keyboardFrame.height
        keyboardShown = true
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard keyboardShown else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else {
            return
        }
        scrollView?.contentInset.bottom -= keyboardFrame.height
        keyboardShown = false
    }
}

