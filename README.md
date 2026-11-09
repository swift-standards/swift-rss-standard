# swift-rss-standard

Use this package when you build or hold an RSS 2.0 feed as Swift values: a channel, its items, enclosures and GUIDs. Start from `RSS.Channel` and `RSS.Item`. For podcast fields add the `RSS Standard iTunes` product and use `ITunes.Channel` and `ITunes.Item`. For Dublin Core fields add `RSS Standard Dublin Core` and use `DublinCore.Metadata`. To write the feed as RSS 2.0 XML, add `RSS Standard XML` and encode `W3C_XML.Document(channel)`; the package does not read RSS XML. If you publish a JSON Feed instead, use swift-json-feed-standard.

## Laws

- `RSS Standard XML` writes a channel inside `<rss version="2.0">`: its title, link and description first, then each optional element only when present, then its items. Dates are RFC 5322 dates, skipped hours are written in ascending order, and a GUID always carries `isPermaLink`.
- An `RSS.Image` is at most 144 wide and 400 high. A larger width or height is refused.
- An `RSS.Hour` is 0 through 23. An integer literal outside that range traps.
- An `RSS.GUID` is a permalink unless you say otherwise. A permalink must parse as a URI with a scheme. A GUID that is not a permalink accepts any text.
- `RSS.Weekday` values are the full English day names, such as `Monday`.
- `ITunes.Duration.init(_:)` reads seconds, minutes:seconds or hours:minutes:seconds. A single number is a total of seconds and is split into hours, minutes and seconds, with hours nil below one hour. Two components leave hours nil. Empty components, anything other than ASCII digits, more than three components and totals that overflow `Int` are refused.
- With `RSS Standard Foundation Integration`, decoding runs the same checks as the initializers. A GUID without `isPermaLink` decodes as a permalink. Missing `categories` and `items` decode as empty lists. An `ITunes.Duration` encodes as an object with `hours`, `minutes` and `seconds`, not as the iTunes text form.
