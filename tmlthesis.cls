%% tmlthesis.cls
%% Master's / doctoral thesis class for TML Laboratory,
%% Nagaoka University of Technology. Japanese and English modes.
%%
%% Engine: LuaLaTeX only.
%% Base:   ltjsbook (Japanese mode) / ltjsbook[english] (English mode).
%% Option design and draft mode follow kks32/phd-thesis-template (MIT).
%% See LICENSE.

\NeedsTeXFormat{LaTeX2e}[2022/11/01]
\ProvidesClass{tmlthesis}[2026/10/23 v0.1 TML Lab thesis class]

\RequirePackage{iftex}
\RequireLuaTeX
\RequirePackage{fix-cm}

% ******************************** Options *************************************

\newif\iftml@english    \tml@englishfalse
\newif\iftml@doctor     \tml@doctorfalse
\newif\iftml@print      \tml@printfalse
\newif\iftml@draft      \tml@draftfalse
\newif\iftml@lineno     \tml@linenotrue
\newif\iftml@showyear   \tml@showyearfalse
\newif\iftml@official   \tml@officialfalse
\newif\iftml@theorems   \tml@theoremstrue

\def\tml@fontsize{11pt}

\DeclareOption{ja}{\tml@englishfalse}
\DeclareOption{en}{\tml@englishtrue}
\DeclareOption{master}{\tml@doctorfalse}
\DeclareOption{doctor}{\tml@doctortrue}
% print: two-sided layout with chapters on odd pages, plain black links
\DeclareOption{print}{\tml@printtrue}
\DeclareOption{online}{\tml@printfalse}
% draft: line numbers and a version/timestamp line on every page
\DeclareOption{draft}{\tml@drafttrue}
\DeclareOption{final}{\tml@draftfalse}
\DeclareOption{nolineno}{\tml@linenofalse}
\DeclareOption{showyear}{\tml@showyeartrue}
% officialcolor: use the NUT VI blue (#00A4E5) as is for the cover bands
\DeclareOption{officialcolor}{\tml@officialtrue}
\DeclareOption{notheorems}{\tml@theoremsfalse}
\DeclareOption{10pt}{\def\tml@fontsize{10pt}}
\DeclareOption{11pt}{\def\tml@fontsize{11pt}}
\DeclareOption{12pt}{\def\tml@fontsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ltjsbook}}
\ProcessOptions\relax

\iftml@english \PassOptionsToClass{english}{ltjsbook}\fi
\iftml@print
  \PassOptionsToClass{twoside,openright}{ltjsbook}
\else
  \PassOptionsToClass{oneside,openany}{ltjsbook}
\fi
\LoadClass[a4paper,\tml@fontsize]{ltjsbook}

% ********************************* Fonts **************************************
% deluxe gives multiple Japanese weights and avoids the font errors that
% ltjs* classes raise for bold/italic in mixed Japanese-English text.

% Both warnings below come from luatexja-preset itself and are harmless:
% the scale is the jsclasses design ratio of Japanese to Latin text, and the
% ignored feature is the preset's Kerning=Off on the class's default font.
\ExplSyntaxOn
\msg_redirect_name:nnn { luatexja-preset } { scale } { info }
\msg_redirect_name:nnn { luatexja-fontspec } { addjfontfeatures-ignored } { info }
\ExplSyntaxOff
\RequirePackage[haranoaji,deluxe]{luatexja-preset}
\newfontfamily\tml@coverfont{TeX Gyre Heros}
\newfontfamily\tml@coverfontwide{TeX Gyre Heros}[LetterSpace=12]

% ******************************** Packages ************************************

\RequirePackage{amsmath,amssymb}
\RequirePackage{amsthm}
\RequirePackage{bm}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\usetikzlibrary{positioning}
\RequirePackage[numbers,sort&compress]{natbib}

% ********************************* Colors *************************************
% Main: NUT VI blue (hue 197) darkened to 25% lightness, so white text on the
% cover bands stays readable (contrast 7.5). Accent: the VI blue itself.

\definecolor{tml@main}{HTML}{005B80}
\definecolor{tml@accent}{HTML}{00A4E5}
\definecolor{tml@sub}{HTML}{4A5560}
\iftml@official \definecolor{tml@main}{HTML}{00A4E5}\fi

% ******************************** Layout **************************************

\RequirePackage{geometry}
\iftml@english
  % about 75 characters per line at 11pt
  \geometry{textwidth=140mm,top=30mm,bottom=30mm,headsep=10mm,footskip=12mm}
  \linespread{1.15}
\else
  % 40 full-width characters per line
  \geometry{textwidth=40\zw,top=30mm,bottom=30mm,headsep=10mm,footskip=12mm}
\fi
\iftml@print
  \geometry{bindingoffset=8mm}
\fi

% ****************************** Metadata **************************************
% j* = Japanese, e* = English. Japanese mode needs \jtitle and \jauthor,
% English mode needs \etitle and \eauthor; everything else is optional.

\def\tml@jtitle{}       \def\tml@etitle{}
\def\tml@jauthor{}      \def\tml@eauthor{}
\def\tml@studentid{}
\def\tml@jsupervisor{}  \def\tml@esupervisor{}
\def\tml@juniversity{長岡技術科学大学大学院}
\def\tml@euniversity{Nagaoka University of Technology}
\def\tml@jschool{工学研究科}
\def\tml@eschool{Graduate School of Engineering}
\def\tml@jmajor{工学専攻}
\def\tml@emajor{}
\def\tml@jfield{}       \def\tml@efield{}
\def\tml@year{}

\newcommand\jtitle[1]{\def\tml@jtitle{#1}}
\newcommand\etitle[1]{\def\tml@etitle{#1}}
\newcommand\jauthor[1]{\def\tml@jauthor{#1}}
\newcommand\eauthor[1]{\def\tml@eauthor{#1}}
\newcommand\studentid[1]{\def\tml@studentid{#1}}
\newcommand\jsupervisor[1]{\def\tml@jsupervisor{#1}}
\newcommand\esupervisor[1]{\def\tml@esupervisor{#1}}
\newcommand\juniversity[1]{\def\tml@juniversity{#1}}
\newcommand\euniversity[1]{\def\tml@euniversity{#1}}
\newcommand\jschool[1]{\def\tml@jschool{#1}}
\newcommand\eschool[1]{\def\tml@eschool{#1}}
\newcommand\jmajor[1]{\def\tml@jmajor{#1}}
\newcommand\emajor[1]{\def\tml@emajor{#1}}
\newcommand\jfield[1]{\def\tml@jfield{#1}}
\newcommand\efield[1]{\def\tml@efield{#1}}
% override the academic year printed with the showyear option
\newcommand\thesisyear[1]{\def\tml@year{#1}}

% Academic year from the build date: January-March belongs to the previous year.
\newcount\tml@ay
\tml@ay=\year
\ifnum\month<4 \advance\tml@ay by -1 \fi

\ExplSyntaxOn
\keys_define:nn { tmlthesis }
  {
    maincolor   .code:n = \definecolor{tml@main}{HTML}{#1} ,
    accentcolor .code:n = \definecolor{tml@accent}{HTML}{#1} ,
    subcolor    .code:n = \definecolor{tml@sub}{HTML}{#1} ,
  }
\NewDocumentCommand \tmlthesissetup { m } { \keys_set:nn { tmlthesis } {#1} }
\ExplSyntaxOff

% Primary-language and secondary-language accessors.
\iftml@english
  \def\tml@n@title{etitle}   \def\tml@n@subtitle{jtitle}
  \def\tml@n@author{eauthor}  \def\tml@n@subauthor{jauthor}
  \def\tml@n@supervisor{esupervisor}
  \def\tml@degree{\iftml@doctor Doctoral Dissertation\else Master's Thesis\fi}
  \def\tml@subdegree{\iftml@doctor 博士論文\else 修士論文\fi}
  \def\tml@idlabel{Student ID}
  \def\tml@supervisorlabel{Supervisor}
  \def\tml@yeartext{Academic Year \ifx\tml@year\@empty\the\tml@ay\else\tml@year\fi}
\else
  \def\tml@n@title{jtitle}   \def\tml@n@subtitle{etitle}
  \def\tml@n@author{jauthor}  \def\tml@n@subauthor{eauthor}
  \def\tml@n@supervisor{jsupervisor}
  \def\tml@degree{\iftml@doctor 博士論文\else 修士論文\fi}
  \def\tml@subdegree{\iftml@doctor DOCTORAL DISSERTATION\else MASTER'S THESIS\fi}
  \def\tml@idlabel{学籍番号}
  \def\tml@supervisorlabel{指導教員}
  \def\tml@yeartext{\ifx\tml@year\@empty\the\tml@ay\else\tml@year\fi 年度}
\fi

\def\tml@title{\csname tml@\tml@n@title\endcsname}
\def\tml@subtitle{\csname tml@\tml@n@subtitle\endcsname}
\def\tml@author{\csname tml@\tml@n@author\endcsname}
\def\tml@subauthor{\csname tml@\tml@n@subauthor\endcsname}
\def\tml@supervisor{\csname tml@\tml@n@supervisor\endcsname}

% ******************************** Cover ***************************************

\newcommand\tml@ifset[2]{\expandafter\ifx\csname tml@#1\endcsname\@empty\else#2\fi}

\newcommand\tml@coverrow[2]{%
  \makebox[7em][l]{\color{tml@sub}#1}#2\par}

\renewcommand\maketitle{%
  \pagenumbering{Alph}%
  \begin{titlepage}
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (TL) at (current page.north west);
    % top band
    \fill[tml@main] (TL) rectangle ++(\paperwidth,-62mm);
    \fill[tml@accent] ([yshift=-62mm]TL) rectangle ++(\paperwidth,-1.6mm);
    \node[anchor=south west,inner sep=0pt,text=white]
      at ([xshift=25mm,yshift=-38mm]TL)
      {\iftml@english\gtfamily\bfseries\fontsize{10.5}{12}\selectfont\tml@subdegree
       \else\tml@coverfontwide\fontsize{10.5}{12}\selectfont\tml@subdegree\fi};
    \node[anchor=north west,inner sep=0pt,text=white]
      at ([xshift=25mm,yshift=-42mm]TL)
      {\iftml@english\tml@coverfont\bfseries\fontsize{24}{28}\selectfont\tml@degree
       \else\gtfamily\bfseries\fontsize{24}{28}\selectfont\tml@degree\fi};
    % titles
    \node[anchor=north west,inner sep=0pt,text width=160mm,align=left,
          font=\tml@coverfont]
      at ([xshift=25mm,yshift=-92mm]TL)
      {\color{tml@main}\hyphenpenalty=10000 \exhyphenpenalty=10000
       \iftml@english\bfseries\fontsize{22}{30}\selectfont
       \else\gtfamily\bfseries\fontsize{21}{32}\selectfont\fi
       \tml@title\par
       \tml@ifset{\tml@n@subtitle}{%
         \vspace{7mm}\color{tml@sub}\mdseries\mcfamily\fontsize{13}{19}\selectfont
         \tml@subtitle\par}%
       \vspace{8mm}{\color{tml@accent}\rule{40mm}{1.2pt}}\par};
    % author block
    \node[anchor=south west,inner sep=0pt,text width=160mm,align=left]
      at ([xshift=25mm,yshift=-238mm]TL)
      {\tml@coverfont\fontsize{16}{22}\selectfont\tml@author
       \tml@ifset{\tml@n@subauthor}{\hspace{1em}{\color{tml@sub}\fontsize{12}{22}\selectfont\tml@subauthor}}\par
       \vspace{5mm}\fontsize{11}{18}\selectfont
       \tml@ifset{studentid}{\tml@coverrow{\tml@idlabel}{\tml@studentid}}%
       \tml@ifset{\tml@n@supervisor}{\tml@coverrow{\tml@supervisorlabel}{\tml@supervisor}}};
    % bottom band
    \fill[tml@main] ([yshift=-255mm]TL) rectangle (current page.south east);
    \node[anchor=north west,inner sep=0pt,text=white,align=left,
          font=\tml@coverfont\fontsize{11}{17}\selectfont]
      at ([xshift=25mm,yshift=-265mm]TL)
      {\iftml@english
         \tml@eschool, \tml@euniversity\\
         \ifx\tml@emajor\@empty\else\tml@emajor\fi
         \ifx\tml@emajor\@empty\else\ifx\tml@efield\@empty\else, \fi\fi
         \tml@efield
       \else
         \gtfamily\tml@juniversity\hspace{.5em}\tml@jschool\\
         \tml@jmajor\ifx\tml@jfield\@empty\else（\tml@jfield）\fi
       \fi};
    \iftml@showyear
      \node[anchor=north east,inner sep=0pt,text=white]
        at ([xshift=-25mm,yshift=-265mm]current page.north east)
        {\tml@coverfont\fontsize{11}{17}\selectfont\tml@yeartext};
    \fi
  \end{tikzpicture}
  \end{titlepage}%
  \pagenumbering{roman}}

% PDF metadata
\AtEndPreamble{%
  \RequirePackage{hyperref}%
  \pdfstringdefDisableCommands{\def\\{ }}%
  \hypersetup{pdftitle={\tml@title},pdfauthor={\tml@author},
    bookmarksnumbered=true,linktoc=page}%
  \iftml@print
    \hypersetup{hidelinks}%
  \else
    \hypersetup{colorlinks=true,linkcolor=tml@main,citecolor=tml@main,
      urlcolor=tml@main}%
  \fi}

% ******************************* Headings *************************************

\def\@makechapterhead#1{%
  \vspace*{1\baselineskip}%
  {\parindent\z@\raggedright\normalfont
   \ifnum\c@secnumdepth>\m@ne
     \if@mainmatter
       {\headfont\large\color{tml@main}\@chapapp\thechapter\@chappos}\par\nobreak
       \vskip .6\baselineskip
     \fi
   \fi
   {\headfont\bfseries\huge #1}\par\nobreak
   \vskip .5\baselineskip
   {\color{tml@accent}\rule{\linewidth}{.8pt}}\par\nobreak
   \vskip 2\baselineskip}}
\def\@makeschapterhead#1{%
  \vspace*{1\baselineskip}%
  {\parindent\z@\raggedright\normalfont
   {\headfont\bfseries\huge #1}\par\nobreak
   \vskip .5\baselineskip
   {\color{tml@accent}\rule{\linewidth}{.8pt}}\par\nobreak
   \vskip 2\baselineskip}}

% ****************************** Front matter **********************************

\iftml@english
  \def\tml@abstractname{Abstract}
  \def\tml@jabstractname{概要}
  \def\tml@ackname{Acknowledgements}
  \def\tml@pubname{List of Publications}
\else
  \def\tml@abstractname{Abstract}
  \def\tml@jabstractname{概要}
  \def\tml@ackname{謝辞}
  \def\tml@pubname{研究業績}
\fi

% Title and author repeated at the top, so the page can be read on its own.
\newcommand\tml@abstracthead[2]{%
  \begin{center}
    {\Large\bfseries #1\par}\vspace{.8\baselineskip}
    {\large #2\par}
  \end{center}\vspace{\baselineskip}}

% English abstract (both modes)
\let\abstract\relax \let\endabstract\relax
\newenvironment{abstract}{%
  \chapter*{\tml@abstractname}%
  \tml@ifset{etitle}{\tml@abstracthead{\tml@etitle}{\tml@eauthor}}}{}

% Japanese abstract (optional; for theses that include one)
\newenvironment{jabstract}{%
  \chapter*{\tml@jabstractname}%
  \tml@ifset{jtitle}{\tml@abstracthead{\gtfamily\tml@jtitle}{\tml@jauthor}}}{}

\newenvironment{acknowledgements}{%
  \chapter*{\tml@ackname}\phantomsection%
  \addcontentsline{toc}{chapter}{\tml@ackname}}{}

\newenvironment{publications}{%
  \chapter*{\tml@pubname}\phantomsection%
  \addcontentsline{toc}{chapter}{\tml@pubname}}{}

\newenvironment{dedication}{%
  \clearpage\thispagestyle{empty}\vspace*{.25\textheight}\centering\itshape}
  {\par\clearpage}

% Plain numbered footnotes in English mode (jsclasses default is *1)
\iftml@english \renewcommand\thefootnote{\arabic{footnote}}\fi

% ******************************** Theorems ************************************

\iftml@theorems
  \theoremstyle{definition}
  \iftml@english
    \newtheorem{theorem}{Theorem}[chapter]
    \newtheorem{proposition}[theorem]{Proposition}
    \newtheorem{lemma}[theorem]{Lemma}
    \newtheorem{corollary}[theorem]{Corollary}
    \newtheorem{definition}[theorem]{Definition}
    \newtheorem{assumption}[theorem]{Assumption}
    \newtheorem{example}[theorem]{Example}
    \newtheorem{remark}[theorem]{Remark}
  \else
    \newtheorem{theorem}{定理}[chapter]
    \newtheorem{proposition}[theorem]{命題}
    \newtheorem{lemma}[theorem]{補題}
    \newtheorem{corollary}[theorem]{系}
    \newtheorem{definition}[theorem]{定義}
    \newtheorem{assumption}[theorem]{仮定}
    \newtheorem{example}[theorem]{例}
    \newtheorem{remark}[theorem]{注意}
    \renewcommand\proofname{証明}
  \fi
\fi

% ****************************** Bibliography **********************************

\iftml@english\else\renewcommand\bibname{参考文献}\fi
\let\tml@thebibliography\thebibliography
\renewcommand\thebibliography[1]{%
  \tml@thebibliography{#1}\phantomsection\addcontentsline{toc}{chapter}{\bibname}}

% ******************************* Draft mode ***********************************
% Version and build time on every page, line numbers in the main matter.

\def\tml@draftversion{}
\newcommand\draftversion[1]{\def\tml@draftversion{#1}}

\iftml@draft
  \newcount\tml@hh \newcount\tml@mm
  \tml@hh=\time \divide\tml@hh by 60
  \tml@mm=\time \count@=\tml@hh \multiply\count@ by -60 \advance\tml@mm by \count@
  \edef\tml@buildtime{\the\year-\two@digits{\month}-\two@digits{\day}
    \two@digits{\tml@hh}:\two@digits{\tml@mm}}
  \AddToHook{shipout/foreground}{%
    \put(0,-12mm){\makebox[\paperwidth]{\color{gray}\tml@coverfont\footnotesize
      DRAFT\ifx\tml@draftversion\@empty\else\ \tml@draftversion\fi
      \ --\ \tml@buildtime}}}
  \iftml@lineno
    \RequirePackage[pagewise,mathlines]{lineno}
    \renewcommand\linenumberfont{\normalfont\tiny\color{gray}}
    \g@addto@macro\mainmatter{\linenumbers}
    \g@addto@macro\backmatter{\nolinenumbers}
  \fi
\fi

\endinput
