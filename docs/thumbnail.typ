#import "@preview/tuwien-geo-masterthesis:0.1.0": *
#import "@preview/rubber-article:0.5.2": ctable
#import "../template/utils.typ": *

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
  eq-numbering: "(1)",
  // degree: "Master",             // "Diplomarbeit" | "Master" | "Bachelor"
  // thesis-type-label: "CUSTOM",  // override computed degree label
)

#show: thesis.with(info: info)
#register-glossary(entry-list)
#show: make-glossary

// --- Front matter ---
#make-title-page(info)
