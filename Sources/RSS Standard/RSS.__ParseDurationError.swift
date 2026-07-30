//
//  RSS.__ParseDurationError.swift
//  swift-rss-standard
//
//  Module-scope, non-generic error for the iTunes-style duration parser.
//
//  Hoisted out of the generic `RSS.Parse.Duration<Input>` namespace so the
//  `@error` SIL result carries no phantom `Input` type parameter — the structural
//  fix for the `FunctionSignatureOpts` release-build ICE
//  (`SILArgument.cpp:40 !type.hasTypeParameter()`).
//  Surfaced through the public path `RSS.Parse.Duration.Error` (a typealias).
//

/// Errors that can occur when parsing an iTunes-style duration.
public enum __ParseDurationError: Swift.Error, Sendable, Equatable {
    case expectedDigit
}
