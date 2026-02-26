/*
 * geo-thesis
 */

#import "@local/geo-thesis:0.1.0": *
#import "utils.typ": *

// Layout and styling
#show: thesis.with(lang: "en")


#register-glossary(entry-list)
#show: make-glossary

#outline()

= Introduction
Update your personal details (name, title, etc.) in `main.typ`. This file also manages the inclusion
or removal of chapters. Each chapter is stored in its own `.typ` file (numbers 0 to 99).

== Examples
=== Citation
Citation in parenthesis @Doe2000 or #cite(<Doe2000>, form: "prose")

=== Abbreviation
At the first occurence, @eop is expanded; in subsequent instances, only the abbreviation is
displayed automatically: @eop. All abbreviations must be defined in the `entry-list` in `utils.typ`.
Only those acronyms explicitly referenced in the text will appear in the list of abbreviations.

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

#figure(rect(align([Image of the TU Wien Logo], horizon), height: 3cm), caption: [Tu Wien
  Logo])<fig-logo>

=== Mathematical formulas
Mathematical formulas may appear directly within a sentence, for example
$sum_(k=1)^(infinity) 1 / k^2 = pi/2$, or they can be displayed separately from the surrounding text
as

$
  sum_(k=1)^infinity 1/k^2 = pi / 2
$

Alternatively, the expression may be presented as a numbered equation:

// the numbering can be set globally as well
#math.equation(
  numbering: "(1)",
  block: true,
  $
    sum_(k=1)^infinity 1/k^2 = pi / 2
  $,
)

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
The Results of the thesis.

= Discussion
The Disccussion of the thesis.

= Conclusion and outlook
Conclusion and outlook.

#bibliography("refs.bib", style: "apa")

#heading([AI usage], numbering: none)

#heading([Abbreviations], numbering: none)
#print-glossary(
  entry-list,
)


#counter(heading).update(0)
#heading([Appendix], numbering: "A.i.")

