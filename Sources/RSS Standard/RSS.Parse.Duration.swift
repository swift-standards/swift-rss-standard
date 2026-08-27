public import Parser

extension RSS.Parse {

    public struct Duration<Input: Collection.Slice.`Protocol`>: Sendable
    where Input: Sendable, Input.Element == UInt8 {
        @inlinable
        public init() {}
    }
}

extension RSS.Parse.Duration {

    public typealias Error = __ParseDurationError
}

extension RSS.Parse.Duration: Parser.`Protocol` {
    public typealias Failure = __ParseDurationError
    public typealias Body = Never

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) -> Output {

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

            if input.startIndex < input.endIndex && input[input.startIndex] == 0x3A {
                input = input[input.index(after: input.startIndex)...]
            } else {
                break
            }
        }

        guard !components.isEmpty else { throw .expectedDigit }

        return switch components.count {
        case 1: Output(hours: 0, minutes: 0, seconds: components[0])
        case 2: Output(hours: 0, minutes: components[0], seconds: components[1])
        default: Output(hours: components[0], minutes: components[1], seconds: components[2])
        }
    }
}
