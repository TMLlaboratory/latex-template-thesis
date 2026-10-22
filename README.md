# tmlthesis — 修士論文・博士論文 LaTeX テンプレート

長岡技術科学大学 雲居研究室（TML Lab）の学位論文用クラスです。
日本語モード（`ja`）と英語モード（`en`）を1つのクラスで切り替えられます。

English: [README.en.md](README.en.md)

## 必要な環境

- **LuaLaTeX 専用**です（pLaTeX / upLaTeX / pdfLaTeX では動きません）
- TeX Live 2024 以降。研究室では Docker イメージ `texlive/texlive:TL2024-historic` で動作確認しています
- 参考文献は `upbibtex`（`latexmkrc` で設定済み）

## ビルド

```bash
latexmk sample-ja.tex          # 日本語モードのサンプル（修士論文）
latexmk sample-en.tex          # 英語モードのサンプル（博士論文）
```

研究室の latex-devkit を使う場合:

```bash
cd ~/Projects/latex-devkit
make build-local PROJ=<プロジェクト名> MAIN=sample-ja.tex LATEX_PROJECTS_DIR=<このフォルダの親>
```

PDF は `build/` に出力されます。

## 使い方

```latex
\documentclass[ja,master]{tmlthesis}

\jtitle{和文題目}
\etitle{English Title}
\jauthor{長岡 太郎}
\eauthor{Taro NAGAOKA}
\studentid{24000000}
\jsupervisor{雲居 玄道 准教授}
\jfield{情報・経営システム工学分野}
\efield{Information and Management Systems Engineering}

\begin{document}
\frontmatter
\maketitle
\begin{abstract} ... \end{abstract}
\tableofcontents
\mainmatter
\chapter{序論} ...
\backmatter
\begin{acknowledgements} ... \end{acknowledgements}
\bibliographystyle{junsrt}
\bibliography{references}
\end{document}
```

### クラスオプション

| オプション | 内容 |
|---|---|
| `ja` / `en` | 本文の言語（既定 `ja`） |
| `master` / `doctor` | 修士論文 / 博士論文（既定 `master`） |
| `print` | 両面印刷用（綴じ代つき、章は奇数ページから、リンクは黒）。既定は PDF 提出向けの片面 |
| `draft` | 下書き。行番号と、各ページ上部にバージョンとビルド日時を表示 |
| `nolineno` | `draft` のとき行番号を出さない |
| `showyear` | 表紙に年度を表示。年度はビルド日から自動計算（1〜3月は前年度）。`\thesisyear{2025}` で上書き可 |
| `officialcolor` | 表紙の帯を技大 VI の青 `#00A4E5` そのものにする |
| `notheorems` | 定理環境を定義しない（自分で定義する場合） |
| `10pt` / `11pt` / `12pt` | 本文の文字サイズ（既定 `11pt`） |

### 表紙の項目

日本語モードでは `\jtitle` と `\jauthor`、英語モードでは `\etitle` と `\eauthor` が必須です。
それ以外は任意で、指定しなければ表紙に出ません。
英語モードでは和文題目・和文氏名を書かなくても完結します（書けば小さく併記されます）。

| コマンド | 内容 | 既定値 |
|---|---|---|
| `\jtitle` / `\etitle` | 和文 / 英文の題目 | — |
| `\jauthor` / `\eauthor` | 和文 / 英文の氏名 | — |
| `\studentid` | 学籍番号 | （表示しない） |
| `\jsupervisor` / `\esupervisor` | 指導教員 | （表示しない） |
| `\jfield` / `\efield` | 分野 | （表示しない） |
| `\juniversity` / `\euniversity` | 大学名 | 長岡技術科学大学大学院 / Nagaoka University of Technology |
| `\jschool` / `\eschool` | 研究科 | 工学研究科 / Graduate School of Engineering |
| `\jmajor` / `\emajor` | 専攻 | 工学専攻 / （空） |

`\emajor` と `\efield` の英語の正式名称は、大学の英文表記を確認してください。

### 表紙の色

```latex
\tmlthesissetup{maincolor=2F3E46, accentcolor=84A98C}   % 16進のRGB
```

既定値は、帯が `#005B80`（技大 VI の青を暗くした色）、アクセントが `#00A4E5`（技大 VI の青）です。

### 前付け・後付けの環境

| 環境 | 内容 |
|---|---|
| `abstract` | 英文 Abstract（英文題目と氏名が上に入る）。両モード共通 |
| `jabstract` | 和文概要（本文に入れる場合のみ） |
| `acknowledgements` | 謝辞（日本語モードでは「謝辞」） |
| `publications` | 研究業績（博士論文向け） |
| `dedication` | 献辞 |

### 定理環境

`theorem`、`proposition`、`lemma`、`corollary`、`definition`、`assumption`、`example`、`remark`
（章ごとの通し番号）と `proof` が使えます。見出しはモードに合わせて「定理」/ Theorem になります。

### 参考文献

`natbib`（番号順・圧縮）を読み込んでいます。日本語モードは `junsrt`、英語モードは `IEEEtran` などを使ってください。
英語モードの論文で日本語文献を引く場合は、`IEEEtran` が日本語の名前を正しく略せないため、英語表記で書いてください。

## 既知の注意点

- `draft` のビルド日時は、ビルド環境の時刻（Docker では UTC）になります
- 下書きの章だけを先生に送るときは、`\includeonly{...}` を使ってください

## ライセンス

MIT License。オプション設計と下書きモードは [kks32/phd-thesis-template](https://github.com/kks32/phd-thesis-template)（MIT）を参考にしています。詳細は [LICENSE](LICENSE) を参照してください。
