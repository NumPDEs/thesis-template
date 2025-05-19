# Change Log

Alle nennenswerten Änderungen an diesen Templates werden in dieser Datei dokumentiert.

## 19.05.2025

* **Fehler:** Fehlendes `\cleardoublepage` in Frontmatter hinzugefügt. Ohne diesen Befehl beginnen die Kapitel auf der linken Seite, wenn die Arbeit beidseitig gedruckt wird. Falls Sie das Template vorher heruntergeladen haben, fügen Sie bitte den Befehl `\cleardoublepage` ganz unten in der Datei `frontmatter.tex` hinzu.
* **Fehler:** `\selectlanguage`-Befehl im `main.tex` unterhalb von frontmatter verschoben. Davor hat das Setzen der Sprache auf Englisch nicht funktioniert.
* Unterschriften-Felder bei Diplomarbeits-Template hinzugefügt
* Eidesstattliche Erklärung in Bezug auf AI-Nutzung angepasst
* `revision`-Befehl angepasst (macht Strich am Rand wenn `\revision` verwendet wird)
* Hypersetup-Befehl für Druckversion geändert
* Metadaten für PDF-Dokument hinzugefügt
* Änderung des Layouts für Bild- und Tabellenunterschriften
