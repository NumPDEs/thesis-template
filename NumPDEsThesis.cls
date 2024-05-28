%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Diese Klasse dient als Vorlage für Abschlussarbeiten
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NumPDEsThesis}[2024/05/13 Class template for theses in the NumPDEs group]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grundlegendes Erscheinungsbild

% Weitergabe der Optionen an die KOMA-Klasse scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass{scrbook}

% Dokumentenstil
\KOMAoptions{footinclude=false} % Fusszeile wird nicht zu Satzspiegel gezaehlt
\KOMAoptions{headsepline=true} % Trennlinie zwischen Kopfzeile und Text
\KOMAoptions{DIV=12} % beeinflusst Satzspiegel
\KOMAoptions{BCOR=8mm} % Bindekorrektur
\pagestyle{headings} % mit Kopfzeilen

\recalctypearea % berechne Satzspiegel neu


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lade alle benötigten Pakete

\RequirePackage[english,ngerman]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{csquotes}
\RequirePackage{amsthm,amsmath,amssymb,amsfonts}
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{hyperref}
\RequirePackage{microtype}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\RequirePackage{colortbl}
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hyperlinks verschönern

% das kann in dem eigentlichen Dokument überschrieben werden, falls gewünscht
\hypersetup{
	colorlinks= true,
	citecolor = ForestGreen,
	linkcolor = BrickRed,
	urlcolor  = NavyBlue
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Laden nützlicher TikZ-Bibliotheken
\usetikzlibrary{arrows, positioning, shapes, matrix, calc, fit, backgrounds}
\tikzset{reference/.style={thick,dashed}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Einstellungen für pgfplots
\pgfplotsset{%
	compat=newest,%
	every axis/.style={scale only axis},%
	grid style={densely dotted, semithick},%
}

% Definiere Referenzgerade adaptiert von:
%https://tex.stackexchange.com/questions/245509/dimension-too-large-in-loglogaxis-plot/245685#245685
\newcommand{\logLogSlope}[6][]{
	% #1. Plot options, default = [].
	% #2. Relative offset in x direction.
	% #3. Relative offset in y direction.
	% #4. Width in x direction, so xA-xB.
	% #5. Slope d(y)/d(log10(x)).
	% #6. Label placement.
	\pgfplotsextra{
		\pgfkeysgetvalue{/pgfplots/xmin}{\xmin}
		\pgfkeysgetvalue{/pgfplots/xmax}{\xmax}
		\pgfkeysgetvalue{/pgfplots/ymin}{\ymin}
		\pgfkeysgetvalue{/pgfplots/ymax}{\ymax}

		% Calculate auxilliary quantities, in relative sense.
		\pgfmathsetmacro{\xArel}{#2}
		\pgfmathsetmacro{\yArel}{#3}
		\pgfmathsetmacro{\xBrel}{#2+#4}

		\pgfmathsetmacro{\lnxA}{\xmin*(1-\xArel)+\xmax*\xArel} % in [xmin,xmax].
		\pgfmathsetmacro{\lnyA}{\ymin*(1-\yArel)+\ymax*\yArel} % in [ymin,ymax].
		\pgfmathsetmacro{\lnxB}{\xmin*(1-\xBrel)+\xmax*\xBrel} % in [xmin,xmax].
		\pgfmathsetmacro{\lnyB}{\lnyA+#5*(\lnxB-\lnxA)}
		\pgfmathsetmacro{\yBrel}{\lnyB-\ymin)/(\ymax-\ymin)}

		% Define coordinates for \draw. MIND THE 'rel axis cs' as opposed to the 'axis cs'.
		\coordinate (A) at (rel axis cs:\xArel,\yArel);
		\coordinate (B) at (rel axis cs:\xBrel,\yBrel);

		% Draw slope.
		\draw[#1] (A)-- node[above=#6,anchor=center,sloped] {\small $r = #5$} (B);
	}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Farbe für Änderungen
\definecolor{change}{rgb}{0,.55,.55}

% TU-Farben
\definecolor{TUBlue}{HTML}{006699}
\definecolor{TUGreen}{HTML}{007E71}
\definecolor{TUGrey}{HTML}{646363}
\definecolor{TUMagenta}{HTML}{BA4682}
\definecolor{TUYellow}{HTML}{E18922}

% Matplotlib-Farben
\definecolor{pyBlue}{HTML}{1f77b4}
\definecolor{pyRed}{HTML}{d62728}
\definecolor{pyGreen}{HTML}{2ca02c}
\definecolor{pyOrange}{HTML}{ff7f0e}
\definecolor{pyPurple}{HTML}{9467bd}
\definecolor{pyYellow}{HTML}{bcbd22}
\definecolor{pyGrey}{HTML}{7f7f7f}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verwende BibLaTeX für Literaturverzeichnis

\RequirePackage[backend=biber,style=trad-alpha,safeinputenc]{biblatex}
	
\ExecuteBibliographyOptions{
  maxnames=20,%
  maxalphanames=4,%
  minalphanames=3,%
  giveninits=true,%
  useprefix=false,%
}

% die Groß- und Kleinschreibung im Satz deaktivieren, 
% so dass einzelne Großbuchstaben in geschweiften Klammern nicht erhalten bleiben
\DeclareFieldFormat{titlecase}{#1}

% Entfernen einiger überflüssiger Felder aus Literaturangaben
% general: language, urldate (=urlyear), month, note
% article: issn, issue, url
% book: volume, isbn, series, pages
% inproceedings: series, editor, pages
\AtEveryBibitem{
  \clearlist{language}%
  \clearfield{urlyear}%
  \clearfield{note}%
  \clearfield{month}%
  \ifentrytype{article}{%
    \clearfield{issn}%
    \clearfield{issue}%
    \clearfield{url}}{}%
  \ifentrytype{book}{%
    \clearfield{volume}%
    \clearfield{isbn}%
    \clearfield{series}%
    \clearfield{pages}}{}%
  \ifentrytype{inproceedings}{%
    \clearfield{series}%
    \clearname{editor}%
    \clearfield{pages}}{}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Änderung der Überschrift des Literaturverzeichnisses

\pretocmd{\@bibtitlestyle}{\vskip1em}{}{}
\pretocmd{\refname}{\large}{}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Umgebung für Algorithmen

\newtheorem{algorithm}{Algorithm}
\renewcommand*{\thealgorithm}{\Alph{algorithm}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mathematische Umgebungen

\theoremstyle{plain}
\newtheorem{satz}{Satz}[chapter]
\newtheorem{lemma}[satz]{Lemma}
\newtheorem{korollar}[satz]{Korollar}
\newtheorem{proposition}[satz]{Proposition}
\newtheorem{definition}[satz]{Definition}
\newtheorem{bemerkung}[satz]{Bemerkung}

\theoremstyle{definition}
\newtheorem{beispiel}[satz]{Beispiel}

% Englische Version

% \theoremstyle{plain}
% \newtheorem{theorem}{Theorem}[chapter]
% \newtheorem{lemma}[theorem]{Lemma}
% \newtheorem{corollary}[theorem]{Corollary}
% \newtheorem{proposition}[theorem]{Proposition}
% \newtheorem{definition}[theorem]{Definition}
% \newtheorem{remark}[theorem]{Remark}

% \theoremstyle{definition}
% \newtheorem{example}[theorem]{example}
