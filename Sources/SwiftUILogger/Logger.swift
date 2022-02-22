//
//  Logger.swift
//
//
//  Created by Viktor Kushnerov on 22/12/19.
//
//
import Foundation
import os.log

var PREVIEW_MODE: Bool = false

public enum Logger {
    static func log(
        log: OSLog = .default,
        type: OSLogType = .error,
        className: AnyClass? = nil,
        callback: String = "",
        delegate: String = "",
        value: Any? = nil,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        let file = file.replacingOccurrences(
            of: "/Users/filimo/MyProjects/ReaderTranslator/ReaderTranslator/",
            with: ""
        )
        let callback = callback.isEmpty ? "" : ".\(callback)"
        let delegate = delegate.isEmpty ? "" : ".\(delegate)"
        let className = className == nil ? "" : String(describing: className!)
        let value = value == nil ? "" : ": \(String(describing: value!))"

        os_log("%s:%i %s%s%s.%s%s", log: log, type: type,
               file, line, className, delegate, callback, function, value)
    }
}

// MARK: - ❌ DEBUG RELATED

/** short and beautiful print */
public func pp(_ object: Any?) {
    #if DEBUG
        if let object = object {
            pp("⚪️ \(object)")
        } else {
            pp("⚪️ \(String(describing: object))")
        }
    #endif
}

public func pp(_ text: String, terminator: String? = nil) {
    #if DEBUG
        terminator == nil ? print(text) : print(text, terminator: terminator!)
    #endif
}

public func warn(_ text: String) { pp("⚠️ " + text) }

public func err(_ text: String, type: Swift.Error = NonFatal.ErrorWithMessage) { pp("❌ " + text) }

public enum NonFatal: Error { case ErrorWithMessage }

public func pp<T>(
    object: Any?,

    className: T.Type,
    callback: String = "",
    delegate: String = "",
    value: Any? = nil,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    #if DEBUG
        if let object = object {
            pp(
                "⚪️ \(object)",

                className: T.self,
                callback: callback,
                delegate: delegate,
                value: value,
                file: file,
                line: line,
                function: function
            )
        } else {
            pp("⚪️ \(String(describing: object))", className: className)
        }
    #endif
}

public func pp<T>(
    log: OSLog = .default,
    type: OSLogType = .default,

    _ text: String,
    terminator: String? = nil,

    className: T.Type,
    callback: String = "",
    delegate: String = "",
    value: Any? = nil,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    #if DEBUG
        let file = file.components(separatedBy: "/ios/Tripster/").last!
        let callback = callback.isEmpty ? "" : ".\(callback)"
        let delegate = delegate.isEmpty ? "" : ".\(delegate)"
        let className = String(describing: className)
        let value = value == nil ? "" : ": \(String(describing: value!))"

        os_log(
            "\n\n%s:%i\n%s%s%s.%s%s\n%s%s",
            log: log,
            type: type,
            file,
            line,
            className,
            delegate,
            callback,
            function,
            value,
            text,
            terminator ?? ""
        )

    #endif
}

public func warn<T>(
    _ text: String,

    className: T.Type,
    callback: String = "",
    delegate: String = "",
    value: Any? = nil,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    pp(
        type: .info, "⚠️ " + text,

        className: T.self,
        callback: callback,
        delegate: delegate,
        value: value,
        file: file,
        line: line,
        function: function
    )
}

public func err<T>(
    _ text: String,
    type _: Swift.Error = NonFatal.ErrorWithMessage,

    className: T.Type,
    callback: String = "",
    delegate: String = "",
    value: Any? = nil,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    pp(
        type: .error, "❌ " + text,

        className: T.self,
        callback: callback,
        delegate: delegate,
        value: value,
        file: file,
        line: line,
        function: function
    )
}
