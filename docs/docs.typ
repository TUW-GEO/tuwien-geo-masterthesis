#import "../src/lib.typ"
#import "@preview/codly-languages:0.1.8": *
#import "@preview/codly:1.3.0": *
#import "@preview/tidy:0.4.3"


#set par(justify: true)
#show heading.where(level: 1): it => align(center, it)
#show heading.where(level: 1): set text(rgb("#006699"))
#show heading.where(level: 2): set text(rgb("#006699"))
#show: codly-init.with()
#codly(languages: codly-languages)

#let manifest = toml("../typst.toml")

#heading(outlined: false)[tuwien-geo-masterthesis]
#align(center, heading(
  level: 2,
  text(black)[v.#manifest.package.version],
  outlined: false,
))
#v(1cm)

#outline(depth: 3)

= Introduction

`tuwien-geo-masterthesis` is a Typst thesis template for the Department of
Geodesy and Geoinformation at TU Wien. It provides a ready-to-use document
structure with title page, front matter, branded headers/footers, and a
glossary.

== Quick Start

```typ
#import "@preview/tuwien-geo-masterthesis:0.1.0": *
#import "utils.typ": *           // glossary entry list

#let info = (
  ..default-info,
  title: "My Thesis Title",
  author: "Max Mustermann",
  student-id: "12345678",
  supervisor: "Prof. Dr. Someone",
)

#show: thesis.with(info: info, lang: "en")
#register-glossary(entry-list)
#show: make-glossary

#make-title-page(info)
#make-declaration(info)
#make-abstract(
  en: [English abstract.],
  de: [Deutsche Kurzfassung.],
)
// #make-acknowledgements[Optional.]

#outline()
#outline(target: figure.where(kind: image), title: [List of Figures])
#outline(target: figure.where(kind: table), title: [List of Tables])

= Introduction
...
```

== Metadata

All thesis-specific data is collected in a single dictionary and passed to each
function. Start from `default-info` and override only the fields you need:

```typ
#let info = (..default-info, title: "...", author: "...")
```

See `default-info` below for all available fields and their defaults.

== Document Structure

The expected call order is:

+ `#show: thesis.with(info: info)` — apply global layout (page, fonts,
  header/footer)
+ `#make-title-page(info)` — TU Wien title page with bundled logos
+ `#make-declaration(info)` — bilingual statutory declaration (DE + EN)
+ `#make-abstract(en: [...], de: [...])` — Abstract and Kurzfassung
+ `#make-acknowledgements[...]` — optional acknowledgements
+ `#outline()` — table of contents; add further `#outline(target: ...)` for
  LoF/LoT
+ Main chapters with numbered `=` headings
+ Back matter: bibliography, AI usage, abbreviations (`#print-glossary`),
  appendix

== Degree Types

Pass `degree` in the `info` dict. Supported values:

- `"Diplomarbeit"` (default) — _Diplom-Ingenieur/in_
- `"Master"` — _Master of Science_
- `"Bachelor"` — _Bachelor of Science_

#colbreak()
= API Reference

#let docs = tidy.parse-module(read("../src/lib.typ"))
#tidy.show-module(docs, style: tidy.styles.default, first-heading-level: 1)
