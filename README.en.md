# tmlthesis — LaTeX class for master's theses and doctoral dissertations

A thesis class for TML Lab (Kumoi Lab), Nagaoka University of Technology.
One class covers both an English mode (`en`) and a Japanese mode (`ja`).

日本語: [README.md](README.md)

## Requirements

- **LuaLaTeX only** (pLaTeX, upLaTeX and pdfLaTeX are not supported)
- TeX Live 2024 or later. Tested with the Docker image `texlive/texlive:TL2024-historic`
- Bibliography is processed with `upbibtex` (already set in `latexmkrc`)

You do not need to write any Japanese in English mode.

## Build

```bash
latexmk sample-en.tex          # English mode sample (doctoral dissertation)
latexmk sample-ja.tex          # Japanese mode sample (master's thesis)
```

With the lab's latex-devkit:

```bash
cd ~/Projects/latex-devkit
make build-local PROJ=<project name> MAIN=sample-en.tex LATEX_PROJECTS_DIR=<parent of this folder>
```

The PDF is written to `build/`.

## Usage

```latex
\documentclass[en,master]{tmlthesis}

\etitle{Your Thesis Title}
\eauthor{Firstname LASTNAME}
\studentid{24000000}
\esupervisor{Assoc.\ Prof.\ Gendo KUMOI}
\efield{Information and Management Systems Engineering}

\begin{document}
\frontmatter
\maketitle
\begin{abstract} ... \end{abstract}
\tableofcontents
\mainmatter
\chapter{Introduction} ...
\backmatter
\begin{acknowledgements} ... \end{acknowledgements}
\bibliographystyle{jIEEEtran}
\bibliography{references}
\end{document}
```

### Class options

| Option | Meaning |
|---|---|
| `en` / `ja` | Language of the thesis (default: `ja`, so write `en` explicitly) |
| `master` / `doctor` | Master's thesis / doctoral dissertation (default: `master`) |
| `print` | Two-sided layout for printing (binding offset, chapters start on odd pages, black links). The default is one-sided for PDF submission |
| `draft` | Line numbers and a version/build-time line at the top of every page |
| `nolineno` | No line numbers in `draft` mode |
| `showyear` | Print the academic year on the cover, computed from the build date (January–March counts as the previous year). Override with `\thesisyear{2025}` |
| `officialcolor` | Use the NUT VI blue `#00A4E5` as is for the cover bands |
| `notheorems` | Do not define theorem environments (if you define your own) |
| `10pt` / `11pt` / `12pt` | Body font size (default: `11pt`) |

### Cover fields

In English mode, `\etitle` and `\eauthor` are required. Everything else is
optional and is left off the cover when not given.

| Command | Meaning | Default |
|---|---|---|
| `\etitle` | Thesis title | — |
| `\eauthor` | Your name | — |
| `\studentid` | Student ID | (not shown) |
| `\esupervisor` | Supervisor | (not shown) |
| `\efield` | Field | (not shown) |
| `\emajor` | Major | (empty) |
| `\eschool` | Graduate school | Graduate School of Engineering |
| `\euniversity` | University | Nagaoka University of Technology |
| `\jtitle`, `\jauthor` | Japanese title and name (optional; shown small under the English ones) | (not shown) |

Check the university's official English names for your major and field.

### Cover colors

```latex
\tmlthesissetup{maincolor=2F3E46, accentcolor=84A98C}   % hex RGB
```

Defaults: bands `#005B80` (the NUT VI blue, darkened), accent `#00A4E5` (the NUT VI blue).

### Front and back matter environments

| Environment | Content |
|---|---|
| `abstract` | Abstract, with the title and your name at the top |
| `acknowledgements` | Acknowledgements |
| `publications` | List of publications (for doctoral dissertations) |
| `dedication` | Dedication |

### Theorems

`theorem`, `proposition`, `lemma`, `corollary`, `definition`, `assumption`,
`example`, `remark` (numbered per chapter, sharing one counter) and `proof`.

### Bibliography

`natbib` is loaded with numeric, sorted and compressed citations. We
recommend **`jIEEEtran`** (used in the samples). It is the IEEEtran style
with Japanese support and ships with TeX Live: English entries look exactly
like IEEEtran, and Japanese entries, if you cite any, keep full names instead
of being abbreviated.

## Notes

- The build time printed in `draft` mode is the clock of the build
  environment (UTC inside Docker).
- To send only some chapters to your supervisor, use `\includeonly{...}`.

## License

MIT License. The option design and draft mode follow
[kks32/phd-thesis-template](https://github.com/kks32/phd-thesis-template) (MIT).
See [LICENSE](LICENSE).
