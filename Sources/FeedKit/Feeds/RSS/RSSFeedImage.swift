//
// RSSFeedImage.swift
//
// Copyright (c) 2016 - 2025 Nuno Dias
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/// Specifies a GIF, JPEG or PNG image that can be displayed with the channel.
///
/// <image> is an optional sub-element of <channel>, which contains three
/// required and three optional sub-elements.
///
/// <url> is the URL of a GIF, JPEG or PNG image that represents the channel.
///
/// <title> describes the image, it's used in the ALT attribute of the HTML
/// <img> tag when the channel is rendered in HTML.
///
/// <link> is the URL of the site, when the channel is rendered, the image
/// is a link to the site. (Note, in practice the image <title> and <link>
/// should have the same value as the channel's <title> and <link>.
///
/// Optional elements include <width> and <height>, numbers, indicating the
/// width and height of the image in pixels. <description> contains text
/// that is included in the TITLE attribute of the link formed around the
/// image in the HTML rendering.
///
/// Maximum value for width is 144, default value is 88.
///
/// Maximum value for height is 400, default value is 31.
public struct RSSFeedImage {
  // MARK: Lifecycle

  public init(
    url: String? = nil,
    title: String? = nil,
    link: String? = nil,
    width: Int? = nil,
    height: Int? = nil,
    description: String? = nil
  ) {
    self.url = url
    self.title = title
    self.link = link
    self.width = width
    self.height = height
    self.description = description
  }

  // MARK: Public

  /// The URL of a GIF, JPEG or PNG image that represents the channel.
  public var url: String?

  /// Describes the image, it's used in the ALT attribute of the HTML `<img>`
  /// tag when the channel is rendered in HTML.
  public var title: String?

  /// The URL of the site, when the channel is rendered, the image is a link
  /// to the site. (Note, in practice the image `<title>` and `<link>` should
  /// have the same value as the channel's `<title>` and `<link>`.
  public var link: String?

  /// Optional element `<width>` indicating the width of the image in pixels.
  /// Maximum value for width is 144, default value is 88.
  public var width: Int?

  /// Optional element `<height>` indicating the height of the image in pixels.
  /// Maximum value for height is 400, default value is 31.
  public var height: Int?

  /// Contains text that is included in the TITLE attribute of the link formed
  /// around the image in the HTML rendering.
  public var description: String?
}

// MARK: - Sendable

extension RSSFeedImage: Sendable {}

// MARK: - Equatable

extension RSSFeedImage: Equatable {}

// MARK: - Hashable

extension RSSFeedImage: Hashable {}

// MARK: - Codable

extension RSSFeedImage: Codable {
  private enum CodingKeys: CodingKey {
    case url
    case title
    case link
    case width
    case height
    case description
  }

  public init(from decoder: any Decoder) throws {
    let container: KeyedDecodingContainer<RSSFeedImage.CodingKeys> = try decoder.container(keyedBy: RSSFeedImage.CodingKeys.self)

    url = try container.decodeIfPresent(String.self, forKey: RSSFeedImage.CodingKeys.url)
    title = try container.decodeIfPresent(String.self, forKey: RSSFeedImage.CodingKeys.title)
    link = try container.decodeIfPresent(String.self, forKey: RSSFeedImage.CodingKeys.link)
    width = try container.decodeIfPresent(Int.self, forKey: RSSFeedImage.CodingKeys.width)
    height = try container.decodeIfPresent(Int.self, forKey: RSSFeedImage.CodingKeys.height)
    description = try container.decodeIfPresent(String.self, forKey: RSSFeedImage.CodingKeys.description)
  }

  public func encode(to encoder: any Encoder) throws {
    var container: KeyedEncodingContainer<RSSFeedImage.CodingKeys> = encoder.container(keyedBy: RSSFeedImage.CodingKeys.self)

    try container.encodeIfPresent(url, forKey: RSSFeedImage.CodingKeys.url)
    try container.encodeIfPresent(title, forKey: RSSFeedImage.CodingKeys.title)
    try container.encodeIfPresent(link, forKey: RSSFeedImage.CodingKeys.link)
    try container.encodeIfPresent(width, forKey: RSSFeedImage.CodingKeys.width)
    try container.encodeIfPresent(height, forKey: RSSFeedImage.CodingKeys.height)
    try container.encodeIfPresent(description, forKey: RSSFeedImage.CodingKeys.description)
  }
}
