//
//  AtomFeedSummary.swift
//
//  Copyright (c) 2016 - 2024 Nuno Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// The "atom:summary" element is a Text construct that conveys a short
/// summary, abstract, or excerpt of an enactry.
///
/// atomSummary = element atom:summary { atomTextConstruct }
///
/// It is not advisable for the atom:summary element to duplicate
/// atom:title or atom:content because Atom Processors might assume there
/// is a useful summary when there is none.
public struct AtomFeedSummary {
  /// The element's text.
  public var text: String?

  /// The element's attributes.
  public struct Attributes: Codable, Equatable {
    /// Text constructs MAY have a "type" attribute.  When present, the value
    /// MUST be one of "text", "html", or "xhtml".  If the "type" attribute
    /// is not provided, Atom Processors MUST behave as though it were
    /// present with a value of "text".
    public var type: String?

    public init(type: String? = nil) {
      self.type = type
    }
  }

  /// The element's attributes.
  public var attributes: Attributes?

  public init(
    text: String? = nil,
    attributes: Attributes? = nil) {
    self.text = text
    self.attributes = attributes
  }
}

// MARK: - Equatable

extension AtomFeedSummary: Equatable {}

// MARK: - Codable

extension AtomFeedSummary: Codable {
  private enum CodingKeys: String, CodingKey {
    case text = "@text"
    case attributes = "@attributes"
  }

  public init(from decoder: any Decoder) throws {
    let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)

    text = try container.decodeIfPresent(String.self, forKey: CodingKeys.text)
    attributes = try container.decodeIfPresent(AtomFeedSummary.Attributes.self, forKey: CodingKeys.attributes)
  }

  public func encode(to encoder: any Encoder) throws {
    var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)

    try container.encodeIfPresent(text, forKey: CodingKeys.text)
    try container.encodeIfPresent(attributes, forKey: CodingKeys.attributes)
  }
}
