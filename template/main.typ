/*
 * geo-thesis
 */

#import "@local/geo-thesis:0.1.0": *
#import "utils.typ": *

#let info = (
  ..default-info,
  lang: "de", // "de" | "en"
  title: "Master Thesis Title",
  author: "Martina Müller",
  student-id: "01234567",
  faculty: "Fakultät für Mathematik und Geoinformation",
  supervisor: "Title Dr. Name Surname",
  co-supervisor: "Univ.-Ass. Dr. Name Surname",
  cooperation: "(in Zusammenarbeit mit XYZ)",
  // degree: "Master",             // "Diplomarbeit" | "Master" | "Bachelor"
  // thesis-type-label: "CUSTOM",  // override computed degree label
)

#show: thesis.with(info: info)
#register-glossary(entry-list)
#show: make-glossary

// --- Front matter ---
#make-title-page(info)

#make-declaration(info)

#make-abstract(
  en: [Replace this with your English abstract.],
  de: [Ersetzen Sie diesen Text durch Ihre deutsche Kurzfassung.],
)

// Uncomment to add acknowledgements:
// #make-acknowledgements[I would like to thank ...]

// --- Table of contents ---
#outline()
#outline(target: figure.where(kind: image), title: [List of Figures])
#outline(target: figure.where(kind: table), title: [List of Tables])

// --- Chapters ---
= Introduction
Update your personal details and thesis info in the `info` dictionary at the top
of this file. Each chapter can be placed in its own `.typ` file and included via
`#include "1_introduction.typ"`.

== Examples
=== Citation
Citation in parenthesis @Doe2000 or #cite(<Doe2000>, form: "prose")

=== Abbreviation
At the first occurrence, @eop is expanded; in subsequent instances, only the
abbreviation is displayed automatically: @eop. All abbreviations must be defined
in the `entry-list` in `utils.typ`. Only those acronyms explicitly referenced in
the text will appear in the list of abbreviations.

=== Table
Reference to @tab-data. Tables are automatically positioned by Typst.

#figure(
  table(
    columns: 6,
    [Example], [A], [B], [C], [D], [E],
    [A], [8.42], [217.15], [0.64], [3.12], [61.33],
    [B], [3.15], [2.88], [0.41], [0.92], [8.45],
  ),
  caption: [Caption of the template],
)<tab-data>

=== Figure
@fig-logo shows the TU Wien Logo. Figures are automatically positioned by Typst.

#figure(
  rect(align([Image of the TU Wien Logo], horizon), height: 3cm),
  caption: [TU Wien Logo],
)<fig-logo>

=== Mathematical formulas
Mathematical formulas may appear directly within a sentence, for example
$sum_(k=1)^(infinity) 1 / k^2 = pi/2$, or they can be displayed separately:

$
  sum_(k=1)^infinity 1/k^2 = pi / 2
$

=== Hyperlink
Webpage of #link("https://www.tuwien.at/", "TU Wien")

=== Bullet Lists

- Foo
- Bar
- Baz

+ Foo
+ Bar
+ Baz

= Literature review / Theoretical background
State of the art.

= Methodology
The methodology used.

= Results
The results of the thesis.

= Discussion
The discussion of the thesis.

= Conclusion and outlook
Conclusion and outlook.

// --- Back matter ---
#bibliography("refs.bib", style: "apa")

#heading([AI usage], numbering: none)
List all generative AI tools used, and specify where, how and when they were
applied.

#heading([Abbreviations], numbering: none)
#print-glossary(entry-list)

#counter(heading).update(0)
#heading([Appendix], numbering: "A.i.")
Additional material.
