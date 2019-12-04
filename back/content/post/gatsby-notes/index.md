+++
title = "Gatsby Notes"
date = 2018-02-03T09:03:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NODE","JS"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

## bind eip

```
gatsby develop -- --host=0.0.0.0
```

## Prettier VS Code plugin

## JSX

The hybrid “HTML-in-JS” is actually a syntax extension

of JavaScript, for React, called JSX


In pure JavaScript, it looks more like this:

`src/pages/index.js`

```
import React from "react"
export default () => React.createElement("div", null, "Hello world!")
```

Now you can spot the use of the 'react' import! But wait. You’re writing JSX, not pure HTML and 

JavaScript. How does the browser read that? The short answer: It doesn’t. Gatsby sites come with 

tooling already set up to convert your source code into something that browsers can interpret.


## default plugins

```
query MyQuery {
  allSitePlugin {
    totalCount
    edges {
      node {
        name
        browserAPIs
        pluginFilepath
        version
        resolve
        pluginOptions {
          name
          path
        }
      }
    }
  }
}
```

## implement an API


[API](https://www.gatsbyjs.org/docs/node-apis/)

To implement an API, export a function with the name of the API 

gatsby-node.js

```
exports.onCreateNode = ({ node }) => {
  console.log(node.internal.type)
}
```


This onCreateNode function will be called by Gatsby whenever a new node is created (or updated).