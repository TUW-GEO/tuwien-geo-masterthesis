/*
 * Copyright (c) 2026 npikall
 */

#let tu-blue = rgb("#006699")
#let forrest-green = rgb(0%, 27%, 13%)

#let thesis(
  lang: "de",
  eq-numbering: none,
  main-font: (
    "New Computer Modern Sans",
    "PT Sans",
    "Liberation Sans",
    "DejaVu Sans",
    "Latin Modern Sans",
  ),
  page-paper: "a4",
  page-margins: (top: 22mm, bottom: 22mm, left: 24mm, right: 24mm),
  doc,
) = {
  // Configure page
  set page(paper: page-paper, margin: page-margins)

  // Configure text
  set text(font: main-font, lang: lang)
  set heading(numbering: "1.1 ")
  set math.equation(numbering: eq-numbering)
  show outline: set text(fill: tu-blue)
  show link: set text(tu-blue)
  show cite: set text(forrest-green)

  // Configure lists
  set enum(spacing: 5pt, indent: 1.5em)
  set list(spacing: 5pt, indent: 1.5em)
  doc
}
