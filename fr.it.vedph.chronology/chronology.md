# Chronology Fragment

- 🔑 single fragment: [it.vedph.token-text-layer:fr.it.vedph.chronology](fr.xsl)
- 🔑 all fragments: `it.vedph.token-text-layer::fr.it.vedph.chronology`

## Configuration

```json
{
  "RendererFilters": [
    {
      "Keys": "token-extractor",
      "Id": "it.vedph.text-filter.str.mongo-token-extractor"
    }
  ],
  "JsonRenderers": [
    {
      "Keys": "it.vedph.token-text-layer:fr.it.vedph.chronology",
      "Id": "it.vedph.json-renderer.xslt",
      "Options": {
        "Xslt": "...TODO: paste minified XSLT here...",
        "FilterKeys": ["token-extractor"]
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
