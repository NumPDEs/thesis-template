# LaTeX Vorlagen

Dieses Repository enhält LaTeX-Vorlagen für diverse Arbeiten.
Alle Vorlagen beinhalten Beispiele für oft verwendete Elemente wie Abbildungen, Tabellen, Plots, Literaturverweise und mehr.
Weiters enthalten sie eine Anleitung zur Verwendung der Vorlagen und allgemeine Tipps zum Schreiben von wissenschaftlichen Arbeiten.
Sollte nur Interesse an den Tipps bestehen, kann auch nur die PDF-Vorschau der jeweiligen Vorlage heruntergeladen werden.

| Vorlage        | PDF                                                                                    | ZIP                                                                                  |
| -------------- | :------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------: |
| Seminararbeit  | [Vorschau (PDF)](https://numpdes.github.io/thesis-template/pdfs/template_seminar.pdf)  | [Download (ZIP)](https://numpdes.github.io/thesis-template/dl/template_seminar.zip)  |
| Bachelorarbeit | [Vorschau (PDF)](https://numpdes.github.io/thesis-template/pdfs/template_bachelor.pdf) | [Download (ZIP)](https://numpdes.github.io/thesis-template/dl/template_bachelor.zip) |
| Masterarbeit   | [Vorschau (PDF)](https://numpdes.github.io/thesis-template/pdfs/template_diplom.pdf)   | [Download (ZIP)](https://numpdes.github.io/thesis-template/dl/template_diplom.zip)   |
| Dissertation   | [Vorschau (PDF)](https://numpdes.github.io/thesis-template/pdfs/template_diss.pdf)     | [Download (ZIP)](https://numpdes.github.io/thesis-template/dl/template_diss.zip)     |

**Update 19.05.2025:**
Es wurden einige Änderungen am Template vorgenommen, u.a. auch Fehler behoben.
Falls Sie das Template bereits davor heruntergeladen haben, müssen Sie die Fehler manuell beheben.
Im [Changelog](CHANGELOG.md) finden Sie eine Liste aller Änderungen.

## Wie verwende ich die Vorlagen?

Die ZIP-Dateien enthalten alle notwendigen Dateien, um die Vorlagen zu verwenden. Falls Sie [Overleaf](https://www.overleaf.com/) verwenden, können Sie die ZIP-Datei direkt importieren (unter `New Project > Upload Project`). Die Vorlagen wurden mit [TeX Live](https://tug.org/texlive/) 2025 getestet. Sollten Probleme auftreten, wird empfohlen, die aktuellste Version von TeX Live zu verwenden.

Jedes Template enthält eine `main.tex`-Datei, die als Einstiegspunkt dient und jene Datei ist, die kompiliert wird.
In `main.tex` werden die Dokumentenklasse eingebunden, die BibTeX-Datei mit der Literatur geladen,
zusätzliche Pakete geladen (standardmäßig ist das die Datei `NumPDEsMacros.sty`), und die einzelnen Kapitel aus dem Ordner `chapters` eingebunden.
Bis auf das Ändern von Einstellungen (wie Sprache) und dem Einfügen von zusätzlichen Kapiteln oder Paketen sollte keine Änderung an `main.tex` notwendig sein.
Den Inhalt der Arbeit schreiben Sie idealerweise in kapitelweise getrennten Dateien im Ordner `chapters`.
Im Template sind auch Abbildungen und Tabellen in separate Dateien (in den Ordnern `figures`, `plots` und `tables`) ausgelagert, um die Übersichtlichkeit zu erhöhen.
Falls ein Ordner nicht benötigt wird, kann er natürlich auch entfernt werden.
Die Datei `NumPDEsThesis.cls` definiert die Dokumentklasse, also im Wesentlichen das Layout der Arbeit.
Daher muss diese Datei in der Regel nicht verändert werden, außer Sie möchten das Layout anpassen.
Die Datei `NumPDEsMacros.sty` enthält nützliche Befehle, die in der Arbeit verwendet werden können.
Bei Bedarf macht es Sinn, diese Datei mit eigenen Befehlen zu erweitern.
Literaturquellen werden in der Datei `literature.bib` gespeichert (siehe PDF-Vorschau für mehr Informationen).

## Wie funktioniert dieses Repository?

Das ist nur für jene relevant, die Änderungen an diesem Repository vornehmen wollen.
Bei jedem Push wird eine GitHub Action ausgeführt, die die folgenden Schritte für jedes der Templates `seminar`, `bachelor`, `diplom` und `diss` durchführt:

* Zunächst werden alle Dateien von der Bauart `name.{type}.tex`, wobei `{type}` der Name des aktuellen Templates ist, zu `name.tex` umbenannt.
* Alle anderen Dateien von dieser Bauart, wo `{type}` nicht dem aktuellen Template entspricht, werden gelöscht.
* Alle übrigen Dateien werden gezippt (Dateiname `template_{type}.zip`)
* Im Anschluss wird das `main.tex`-File des Templates kompiliert und als PDF gespeichert (Dateiname `template_{type}.pdf`)
* Die ZIP-Datei und die PDF-Datei werden dann sowohl als [Artifact](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/storing-and-sharing-data-from-a-workflow) als auch unter folgenden URLs bereitgestellt:
  * `https://numpdes.github.io/thesis-template/dl/template_{type}.zip`
  * `https://numpdes.github.io/thesis-template/pdfs/template_{type}.pdf`

Falls Änderungen lokal getestet werden sollen, müssen daher alle Dateien `name.{type}.tex` entsprechend umbenannt werden.
