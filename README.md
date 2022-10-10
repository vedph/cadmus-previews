# Cadmus Preview Templates

This project is just a collection of templates used to build preview configurations for the Cadmus editor. As such, it can be used as a sample to help you build your own preview. All what you need is knowing XSLT and a bit of JSON; your favorite XML editor; and an XSLT processor.

You can open the project with Oxygen, or just use the files in each folder. Each folder is related to a specific part or fragment, and is named accordingly from its ID.

For more documentation on preview, see [Cadmus migration documentation](https://github.com/vedph/cadmus-migration/blob/master/docs/index.md).

## Quick Start

To create a preview:

(1) choose the part or fragment you want to build the preview for, and create a folder named after its ID.

(2) in the folder, create a `sample.xml` file to contain sample data for the chosen part or fragment (file names are just conventions, you can use whatever name you prefer). This can be copied from the JSON content of each part or layer part in the Cadmus MongoDB database, or just created by hand. In both cases, you should ensure that you adjust JSON for preview, manually performing the operations which will then be automatic in the system:

- for fragment parts, pick a single fragment from the `fragments` array, and wrap it into `{ "root": {...} }`.
- for any other parts, just wrap into `{ "root": {...} }` the JSON content.

(3) in the folder, create a `go.xslt` XSLT file to generate your preview transforming `sample.xml`. The XSLT skeleton typically is as follows. Note that this template includes html and body, and CSS inside html's head, just to let you see the output of your script in a complete HTML document.

```xslt
<?xml version="1.0" encoding="UTF-8"?>
<!-- Cadmus preview - ID -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="1.0">
    <xsl:output media-type="text/html" method="html" omit-xml-declaration="yes" encoding="UTF-8"/>
    <!-- TODO optional templates for root's descendants here... -->
    <xsl:template match="root">
        <html>
            <head>
                <style type="text/css">
                    .pv-flex-row {
                        display: flex;
                        gap: 8px;
                        align-items: center;
                        flex-wrap: wrap;
                    }
                    .pv-flex-row * {
                        flex: 0 0 auto;
                    }
                    /* TODO other styles here... prefix them according to ID */
                </style>
            </head>
            <body>
            <!-- TODO your templates / <xsl:apply-templates/> here... -->
            </body>
        </html>
    </xsl:template>
    <!-- fallback -->
    <xsl:template match="*"/>

</xsl:stylesheet>
```

(4) if using Oxygen, update the transform scenarios so that you apply `go.xslt` to `sample.xml`.

>Note that these templates are built for no dependencies, so you just need a text editor to work. This implies that you will eventually have to take into account filters, but you won't see their effects. For instance, your XSLT template might output a mock `<_md>` element just to let a Markdown filter replace it with the conversion of its content into HTML; yet, if using only simple XSLT transforms you will just see the mock element.

(5) once you have completed the script, you should remove `head`, move the styles into your Cadmus app CSS, and unwrap the contents of `html` and `body`. In the end, the preview script should just generate an HTML fragment, usually rooted under some element like `div`. To add your preview:

- in the app frontend, just add your styles to `preview-styles.css`.
- in the API backend, add your preview configuration to `preview-profile.json`. Here you should have all the filters used by your renderers, and a JSON renderer for each preview type. For instance:

```json
{
  "RendererFilters": [
    TODO: add your filters here, like these ones...
    {
      "Keys": "markdown",
      "Id": "it.vedph.renderer-filter.markdown",
      "Options": {
        "MarkdownOpen": "<_md>",
        "MarkdownClose": "</_md>",
        "Format": "html"
      }
    },
    {
      "Keys": "token-extractor",
      "Id": "it.vedph.renderer-filter.mongo-token-extractor",
      "Options": {
        "LocationPattern": "<location>([^<]+)</location>",
        "TextTemplate": "<span class=\"apparatus-lemma\">{text}</span>",
        "TextCutting": true,
        "Mode": 3,
        "Limit": 80,
        "MinusLimit": 5,
        "PlusLimit": 5
      }
    }
  ],
  "JsonRenderers": [
    {
      "Keys": "TODO: your part ID: partID or partID|fragmentID",
      "Id": "it.vedph.json-renderer.xslt",
      "Options": {
        "FilterKeys": [
          TODO: add your filter keys here...
          "token-extractor"
        ],
        "Xslt": "...TODO: paste your minimized script here..."
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

>To minify your XSLT you can use any tool like [this web minifier](https://codebeautify.org/xml-minifier). Please ensure to properly escape the XSLT code when placing it in the JSON configuration: any `"` should be escaped as `\"`.
