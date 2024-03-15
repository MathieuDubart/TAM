//
//  KeyboardViewController.swift
//  SmartKeyboard
//
//  Created by Mathieu DUBART on 14/03/2024.
//

import UIKit
import KeyboardKitPro

class KeyboardViewController: KeyboardInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var lastSentence: String = ""
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let licenseKey = try? self.getLicenseKeyFor("KEYBOARDKIT_KEY")
        
        _ = try? setupPro(
                withLicenseKey: licenseKey ?? "",
                locales: [.french] // Define which locales to use
            ) { _ in
                // Make any license-based configurations here
                
            }
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
        
        if let message = self.getInputFieldText() {
            KeyboardLogger.log("textWillChange - \(message)")
        } else {
            KeyboardLogger.log("empty optional (nil)")
        }
        
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    func getInputFieldText() -> String? {
        return self.textDocumentProxy.documentContextBeforeInput
    }

    func getLicenseKeyFor(_ key: String) throws -> String {
        guard let licenseKey = ProcessInfo.processInfo.environment[key] else {
            throw KeyErrors.notAvailable
        }
        
        Logger.log("LicenseKey loaded")
        return licenseKey
    }
}
