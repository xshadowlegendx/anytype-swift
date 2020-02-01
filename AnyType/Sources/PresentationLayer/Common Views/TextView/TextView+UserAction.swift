//
//  TextView+UserAction.swift
//  AnyType
//
//  Created by Dmitry Lobanov on 01.02.2020.
//  Copyright © 2020 AnyType. All rights reserved.
//

import Foundation
import UIKit

// MARK: UserActions
extension TextView {
    public enum UserAction {
        typealias BlockAction = TextView.BlockToolbar.UnderlyingAction
        
        typealias MarksAction = TextView.HighlightedToolbar.UnderlyingAction // it should be what?! I guess it is Action with range, right?!
         
        // Actions with text...
        enum InputAction {
            case changeText(String)
        }
        
        // Actions with input custom keys...
        enum KeyboardAction {
            enum Key {
                case enterWithPayload(String?)
                case enterAtBeginning
                case enter
                case deleteWithPayload(String?)
                case delete
                static func convert(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Self? {
                    //
                    // Well...
                    // We should also keep values to the right of the Cursor.
                    // So, enter key should have minimum one value as String on the right as Optional<String>
//                    print("textView: \(textView.text) range: \(range) text: \(text). Text length: \(text.count)")
                    print("textViewLength: \(textView.text.count) range: \(range) textLength: \(text.count)")
                    switch (textView.text, range, text) {
                    case (_, .init(location: 1, length: 0), "\n"): return .enterAtBeginning
                    case let (source, at, "\n") where source?.count == at.location + at.length: return .enter
                    case let (source, at, "\n"):
                        guard let source = source, let theRange = Range(at, in: source) else { return nil }
                        return .enterWithPayload(source.replacingCharacters(in: theRange, with: "\n").split(separator: "\n").last.flatMap(String.init))
                    case ("", .init(location: 0,length: 0), ""): return .delete
                    case let (source, .init(location: 0, length: 0), ""): return .deleteWithPayload(source)
                    default: return nil
                    }
                }
            }
            case pressKey(Key)
            static func convert(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Self? {
//                print("textView.text: \(String(describing: textView.text))")
//                print("textView.range: \(range)")
//                print("textView.replacementText: \(text)")
                return Key.convert(textView, shouldChangeTextIn: range, replacementText: text).flatMap{.pressKey($0)}
            }
        }
        
        case blockAction(BlockAction), marksAction(MarksAction), inputAction(InputAction), keyboardAction(KeyboardAction)
    }
}
