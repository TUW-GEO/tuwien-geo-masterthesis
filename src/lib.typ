/*
 * Copyright (c) 2026 npikall
 */

// TU Wien institutional blue.
#let tu-blue = rgb("#006699")

// Department forest green (used for citations).
#let forrest-green = rgb(0%, 27%, 13%)

/// Default thesis metadata. Override by spreading:
/// `#let info = (..default-info, title: "My Thesis", author: "Me")`
///
/// - `title` (str): Thesis title.
/// - `author` (str): Author full name.
/// - `student-id` (str): Matriculation number.
/// - `degree` (str): `"Diplomarbeit"`, `"Master"`, or `"Bachelor"`.
/// - `study-program` (str): Study programme name.
/// - `department` (str): Department name.
/// - `faculty` (str): Faculty name.
/// - `university` (str): University name.
/// - `supervisor` (str): Main supervisor with academic title.
/// - `co-supervisor` (str or none): Co-supervisor; line omitted if `none`.
/// - `cooperation` (str or none): Cooperation institution note; omitted if `none`.
/// - `location` (str): City of submission.
/// - `date` (datetime): Submission date.
#let default-info = (
  title: "Thesis Title",
  author: "Author Name",
  student-id: "00000000",
  degree: "Diplomarbeit",
  study-program: "Geodesy and Geoinformation",
  department: "Department of Geodesy and Geoinformation",
  faculty: "Faculty of Mathematics and Geoinformation",
  university: "Technische Universität Wien",
  supervisor: "Supervisor Name",
  co-supervisor: none,
  cooperation: none,
  location: "Wien",
  date: datetime.today(),
)

/// Generate the title page. Call before any other content.
///
/// -> content
#let make-title-page(
  /// - info (dictionary): Thesis metadata; use `default-info` as base.
  /// -> content
  info,
) = {
  let degree-label = if info.degree == "Master" {
    "MASTER'S THESIS"
  } else if info.degree == "Bachelor" {
    "BACHELOR'S THESIS"
  } else {
    "DIPLOMARBEIT"
  }

  let degree-string = if info.degree == "Master" {
    "Master of Science"
  } else if info.degree == "Bachelor" {
    "Bachelor of Science"
  } else {
    "Diplom-Ingenieur/in"
  }

  let date-str = info.date.display("[day].[month].[year]")

  set page(header: none, footer: none, numbering: none)

  grid(
    columns: (1fr, 1fr),
    image("graphics/tuwien_logo.png", height: 2.5cm), align(right, image("graphics/Blue.png", height: 2.5cm)),
  )

  v(2cm)

  align(center)[
    #text(size: 14pt, upper(degree-label))

    #v(1.5cm)

    #text(size: 20pt, weight: "bold", info.title)

    #v(1.5cm)

    #text(size: 11pt)[zur Erlangung des akademischen Grades]

    #v(0.8em)

    #text(size: 14pt, weight: "bold", degree-string)

    #v(0.8em)

    #text(size: 11pt)[im Rahmen des Studiums]

    #v(0.8em)

    #text(size: 13pt, weight: "bold", info.study-program)

    #v(0.8em)

    #text(size: 11pt)[eingereicht von]

    #v(0.8em)

    #text(size: 13pt, weight: "bold", info.author)

    #text(size: 11pt)[Matrikelnummer #info.student-id]
  ]

  v(2cm)

  [
    ausgeführt am #info.department

    der #info.faculty der #info.university
  ]

  if info.cooperation != none {
    v(0.5em)
    [#info.cooperation]
  }

  v(1cm)

  [Betreuung

    Betreuer/in: #info.supervisor]

  if info.co-supervisor != none {
    [

      Mitwirkung: #info.co-supervisor]
  }

  v(1.5cm)

  grid(
    columns: (1fr, 5cm, 1cm, 5cm),
    align(left + horizon)[#info.location, #date-str],
    align(
      center,
      stack(
        spacing: 2pt,
        line(length: 100%),
        text(size: 9pt)[(Unterschrift Verfasser/in)],
      ),
    ),
    [],
    align(
      center,
      stack(
        spacing: 2pt,
        line(length: 100%),
        text(size: 9pt)[(Unterschrift Betreuer/in)],
      ),
    ),
  )

  pagebreak()
}

/// Generate bilingual declaration of authorship (German + English).
///
/// -> content
#let make-declaration(
  /// - info (dictionary): Thesis metadata. Needs `location`, `date`, `author`.
  /// -> content
  info,
) = {
  let date-str = info.date.display("[day].[month].[year]")

  set heading(numbering: none, outlined: false)

  [= Erklärung zur Verfassung der Arbeit]

  [Hiermit erkläre ich, dass ich diese Arbeit selbständig verfasst habe, dass
    ich die verwendeten Quellen und Hilfsmittel vollständig angegeben habe und
    dass ich die Stellen der Arbeit -- einschließlich Tabellen, Karten und
    Abbildungen --, die anderen Werken oder dem Internet im Wortlaut oder dem
    Sinn nach entnommen sind, auf jeden Fall unter Angabe der Quelle als
    Entlehnung kenntlich gemacht habe. Ich erkläre weiters, dass ich mich
    generativer KI-Tools lediglich als Hilfsmittel bedient habe. Im Kapitel „AI
    usage" habe ich alle generativen KI-Tools gelistet, die verwendet wurden,
    und angegeben, wo, wie und wann sie verwendet wurden.]

  [= Declaration of Authorship]

  [I hereby declare that I have authored this thesis independently, that I have
    fully cited all sources and resources used, and that I have clearly
    identified as borrowings all parts of the work -- including tables, maps,
    and figures -- that have been taken from other works or the internet,
    whether in wording or in substance, in each case indicating the source. I
    further declare that I have used generative AI tools solely for revising
    text that I have written myself. In the chapter 'AI usage,' I have listed
    all generative AI tools used and specified where, how and when they were
    applied.]

  v(2cm)

  grid(
    columns: (1fr, 5cm),
    align(left + horizon)[#info.location, #date-str],
    align(
      right,
      stack(
        spacing: 2pt,
        line(length: 100%),
        info.author,
        text(size: 9pt)[(Unterschrift Verfasser/in)],
      ),
    ),
  )

  pagebreak()
}

/// Generate abstract pages (English Abstract + German Kurzfassung).
///
/// -> content
#let make-abstract(
  /// - en (content): English abstract body.
  /// -> content
  en: [],
  /// - de (content): German Kurzfassung body.
  de: [],
  /// -> content
) = {
  set heading(numbering: none, outlined: false)

  [= Abstract]
  en

  pagebreak()

  [= Kurzfassung]
  de

  pagebreak()
}

/// Generate an optional acknowledgements page.
///
/// -> content
#let make-acknowledgements(
  /// - body (content): Acknowledgements text.
  /// -> content
  body,
) = {
  set heading(numbering: none, outlined: false)

  [= Acknowledgements]
  body

  pagebreak()
}

/// Main thesis show rule. Apply with `#show: thesis.with(info: info)`.
#let thesis(
  /// - info (dictionary): Thesis metadata. Use `default-info` as base.
  /// -> dict
  info: default-info,
  /// - lang (str): Document language (`"de"` or `"en"`).
  /// -> str
  lang: "de",
  /// - eq-numbering (str or none): Equation numbering pattern, e.g. `"(1)"`.
  /// -> str
  eq-numbering: none,
  /// - main-font (array): Ordered font fallback list.
  /// -> array
  main-font: (
    "New Computer Modern Sans",
    "PT Sans",
    "Liberation Sans",
    "DejaVu Sans",
    "Latin Modern Sans",
  ),
  /// - page-paper (str): Paper size string, default `"a4"`.
  /// -> str
  page-paper: "a4",
  /// - page-margins (dictionary): Margin dict with keys `top`, `bottom`, `left`, `right`.
  /// -> dict
  page-margins: (top: 22mm, bottom: 22mm, left: 24mm, right: 24mm),
  doc,
) = {
  set page(
    paper: page-paper,
    margin: page-margins,
    header: context {
      let hs = query(heading.where(level: 1, outlined: true).before(here()))
      if hs.len() > 0 {
        set text(size: 9pt, fill: tu-blue)
        align(right, hs.last().body)
        v(-6pt)
        line(length: 100%, stroke: 0.5pt + tu-blue)
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.5pt)
      v(2pt)
      set text(size: 9pt)
      align(
        right,
        [#counter(page).display() | #counter(page).final().first()],
      )
    },
  )

  set text(font: main-font, lang: lang)
  set heading(numbering: "1.1 ")
  set math.equation(numbering: eq-numbering)

  show outline.entry.where(level: 1): it => strong(it)
  show outline: set text(fill: tu-blue)
  show link: set text(fill: tu-blue)
  show cite: set text(fill: forrest-green)

  set enum(spacing: 5pt, indent: 1.5em)
  set list(spacing: 5pt, indent: 1.5em)

  doc
}
