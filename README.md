# geo-thesis

Typst thesis template for geography and geoinformation disciplines at TU Wien (Technische Universität Wien). Supports Diplomarbeit, Master's, and Bachelor's theses.

## Getting Started

```typ
#import "@preview/geo-thesis:0.1.0": *

#let info = (
  ..default-info,
  title: "My Thesis Title",
  author: "Max Mustermann",
  student-id: "12345678",
  supervisor: "Prof. Dr. Supervisor Name",
)

#show: thesis.with(info: info, lang: "en")

#make-title-page(info)
#make-declaration(info)
#make-abstract(
  en: [English abstract.],
  de: [Deutsche Kurzfassung.],
)

#outline()
= Introduction
...
```

## Features

- TU Wien branded title page (logo, blue colour scheme)
- Bilingual declaration of authorship (German + English)
- Abstract pages (English + German)
- Optional acknowledgements page
- Running header with chapter title, page counter in footer
- Glossary support via `glossarium`
- Configurable degree type: `"Diplomarbeit"`, `"Master"`, `"Bachelor"`

## Template Parameters

### `thesis()`

| Parameter      | Type        | Default                 | Description                   |
| -------------- | ----------- | ----------------------- | ----------------------------- |
| `info`         | dict        | `default-info`          | Thesis metadata               |
| `lang`         | str         | `"de"`                  | Document language             |
| `eq-numbering` | str or none | `none`                  | Equation numbering pattern    |
| `main-font`    | array       | New CM Sans, PT Sans, … | Font fallback list            |
| `page-paper`   | str         | `"a4"`                  | Paper size                    |
| `page-margins` | dict        | 22/24 mm                | Top/bottom/left/right margins |

### `default-info` fields

| Key             | Default                                       |
| --------------- | --------------------------------------------- |
| `title`         | `"Thesis Title"`                              |
| `author`        | `"Author Name"`                               |
| `student-id`    | `"00000000"`                                  |
| `degree`        | `"Diplomarbeit"`                              |
| `study-program` | `"Geodesy and Geoinformation"`                |
| `department`    | `"Department of Geodesy and Geoinformation"`  |
| `faculty`       | `"Faculty of Mathematics and Geoinformation"` |
| `university`    | `"Technische Universität Wien"`               |
| `supervisor`    | `"Supervisor Name"`                           |
| `co-supervisor` | `none`                                        |
| `cooperation`   | `none`                                        |
| `location`      | `"Wien"`                                      |
| `date`          | `datetime.today()`                            |

## Public API

- `default-info` — metadata dict with all fields pre-filled
- `thesis()` — main show rule
- `make-title-page(info)` — title page
- `make-declaration(info)` — authorship declaration
- `make-abstract(en: [], de: [])` — abstract pages
- `make-acknowledgements(body)` — optional acknowledgements
- `tu-blue` — `rgb("#006699")`
- `forrest-green` — `rgb(0%, 27%, 13%)`

## Development

Requires: `just`, `typst ≥ 0.13.0`, `tt` (tytanic), `gotpm`, `typstyle`, `uvx`.

```bash
just install   # install as @local/geo-thesis:0.1.0
just test      # run test suite
just docs      # compile manual
just format    # format .typ files
just ci        # full CI: test + docs + thumbnail + check
```
