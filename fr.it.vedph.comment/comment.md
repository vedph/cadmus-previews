# Comment Fragment

- 🔑 single fragment: [it.vedph.token-text-layer:fr.it.vedph.comment](fr.xsl)
- 🔑 all fragments: `it.vedph.token-text-layer::fr.it.vedph.comment`

## Configuration

- filters:
  - Markdown, to render the comment body.
  - ISO639 or BCP47 (pick the one you use, remove the other) to render language codes from keywords.

```json
{
  "RendererFilters": [
    {
      "Keys": "markdown",
      "Id": "it.vedph.text-filter.str.markdown",
      "Options": {
        "MarkdownOpen": "<_md>",
        "MarkdownClose": "</_md>",
        "Format": "html"
      }
    },
    {
      "Keys": "iso639-3",
      "Id": "it.vedph.text-filter.str.iso639"
    },
    {
      "Keys": "bcp47",
      "Id": "it.vedph.text-filter.str.bcp47"
    }
  ],
  "JsonRenderers": [
    {
      "Keys": "it.vedph.token-text-layer:fr.it.vedph.comment",
      "Id": "it.vedph.json-renderer.xslt",
      "Options": {
        "WrappedEntryNames": {
          "categories": "category",
          "references": "reference",
          "keywords": "keyword",
          "externalIds": "externalId"
        },
        "Xslt": "...TODO: paste minified XSLT here...",
        "FilterKeys": [
          "markdown",
          "bcp47"
        ]
      }
    }
  ],
  "TextPartFlatteners": [
    {
      "Keys": "it.vedph.token-text",
      "Id": "it.vedph.text-flattener.token"
    }
  ]
}
```
