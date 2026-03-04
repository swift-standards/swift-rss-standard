//
//  RSS.Parse.Duration.swift
//  swift-rss-standard
//
//  iTunes-style duration: HH:MM:SS or MM:SS or SS
//

public import Parser_Primitives

extension RSS.Parse {
    /// Parses an iTunes-style duration.
    ///
    /// Formats:
    /// - `HH:MM:SS` — hours, minutes, seconds
    /// - `MM:SS` — minutes, seconds
    /// - `SS` — seconds only
    ///
    /// Returns the components as integers.
    public struct Duration<Input: Collection.Slice.`Protocol`>: Sendable
    where Input: Sendable, Input.Element == UInt8 {
        @inlinable
        public init() {}
    }
}

extension RSS.Parse.Duration {
    public struct Output: Sendable, Equatable {
        public let hours: Int
        public let minutes: Int
        public let seconds: Int

        @inlinable
        public init(hours: Int, minutes: Int, seconds: Int) {
            self.hours = hours
            self.minutes = minutes
            self.seconds = seconds
        }
    }

    public enum Error: Swift.Error, Sendable, Equatable {
        case expectedDigit
    }
}

extension RSS.Parse.Duration: Parser.`Protocol` {
    public typealias Failure = RSS.Parse.Duration<Input>.Error

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) -> Output {
        // Parse colon-separated numbers
        var components: [Int] = []

        while true {
            var value = 0
            var digits = 0
            while input.startIndex < input.endIndex {
                let byte = input[input.startIndex]
                guard byte >= 0x30 && byte <= 0x39 else { break }
                value = value &* 10 &+ Int(byte &- 0x30)
                input = input[input.index(after: input.startIndex)...]
                digits += 1
            }

            guard digits > 0 || !components.isEmpty else { throw .expectedDigit }
            if digits > 0 {
                components.append(value)
            }

            // Check for ':'
            if input.startIndex < input.endIndex && input[input.startIndex] == 0x3A {
                input = input[input.index(after: input.startIndex)...]
            } else {
                break
            }
        }

        guard !components.isEmpty else { throw .expectedDigit }

        // Map components to hours/minutes/seconds based on count
        return switch components.count {
        case 1: Output(hours: 0, minutes: 0, seconds: components[0])
        case 2: Output(hours: 0, minutes: components[0], seconds: components[1])
        default: Output(hours: components[0], minutes: components[1], seconds: components[2])
        }
    }
}
