# Telecommunication Data Warehouse

## Projektübersicht

Dieses Projekt demonstriert die vollständige Entwicklung eines **Data Warehouse (DWH)** für ein Telekommunikationsunternehmen mit **Microsoft SQL Server**.

Ziel des Projekts ist die Entwicklung einer zentralen Datenbasis für analytische Auswertungen und Business Intelligence. Das Data Warehouse ermöglicht datenbasierte Entscheidungen in den Bereichen Marketing, Kundenmanagement und Produktentwicklung.

Der gesamte Entwicklungsprozess wurde umgesetzt – von der Modellierung einer relationalen Business-Datenbank über den Import von CSV-Daten und die Implementierung eines ETL-Prozesses bis hin zum Aufbau eines multidimensionalen Data Warehouse mit **Galaxy Schema** und **Slowly Changing Dimension (SCD Type 2)**.

---

# Projektziele

Das Data Warehouse unterstützt unter anderem folgende Analysen:

- Analyse der Umsatzentwicklung verschiedener Tarife
- Analyse des Kommunikationsverhaltens (Anrufe und SMS)
- Churn Analysis (Kundenabwanderung)
- Bewertung von Marketingkampagnen
- Zeitbezogene Analysen (Tageszeit, Monat, Jahr)
- Analyse verschiedener Kundengruppen

---

# Verwendete Technologien

- Microsoft SQL Server
- SQL
- ETL
- Data Warehouse
- OLTP & OLAP
- Galaxy Schema
- Multidimensionales ER-Modell (mER)
- Slowly Changing Dimension Type 2 (SCD Typ 2)
- CSV-Dateien
- Draw.io

---

# Projektstruktur

```text
Telecommunication-Data-Warehouse/

├── README.md
│
├── data/
│   ├── kunde.csv
│   ├── vertrag.csv
│   ├── tarif.csv
│   ├── sms.csv
│   ├── anruf.csv
│   └── marketing_aktion.csv
│
├── database/
│   ├── create_database.sql
│   ├── create_dwh.sql
│   └── dwh/
│
├── docs/
│   ├── calculations/
│   ├── diagrams/
│   └── documentation/
│
└── queries/
    ├── 01_umsatzanalyse.sql
    ├── 02_anrufe_nach_tageszeit.sql
    ├── 03_churn_analyse.sql
    └── 04_sms_nutzung_monatsverlauf.sql
```

---

# Projektarchitektur

Das Projekt besteht aus vier Hauptkomponenten:

## 1. Business-Datenbank (OLTP)

Die Business-Datenbank bildet die operative Datenbasis des Projekts.

Folgende Entitäten wurden modelliert:

- Kunde
- Vertrag
- Tarif
- SMS
- Anruf
- Marketing_Aktion

Die Datenbank wurde vollständig normalisiert und erfüllt die Anforderungen der:

- Erste Normalform (1NF)
- Zweite Normalform (2NF)
- Dritte Normalform (3NF)

---

## 2. ETL-Prozess

Der ETL-Prozess übernimmt die Daten aus der Business-Datenbank in das Data Warehouse.

Dabei werden folgende Schritte durchgeführt:

- Import der CSV-Dateien
- Datenbereinigung
- Datentransformation
- Auflösung der Fremdschlüssel
- Berechnung von Kennzahlen
- Befüllung der Dimensionstabellen
- Befüllung der Faktentabellen
- Historisierung der Kundendaten mittels SCD Typ 2

---

## 3. Data Warehouse

Das Data Warehouse wurde als **Galaxy Schema** modelliert.

### Faktentabellen

- FAKTOR_KOMMUNIKATION
- FAKTOR_KUNDENABWANDERUNG

### Gemeinsame Dimensionen

- DIM_KUNDE
- DIM_TARIF
- DIM_ZEIT

### Zusätzliche Dimension

- DIM_MARKETING_AKTION

Durch gemeinsam genutzte Dimensionen werden Redundanzen reduziert und verschiedene Geschäftsprozesse können gleichzeitig analysiert werden.

---

## 4. Business Intelligence

Das Data Warehouse dient als Grundlage für analytische Auswertungen und unterstützt strategische Entscheidungen des Unternehmens.

---

# Slowly Changing Dimension (SCD Typ 2)

Für die Dimension **DIM_KUNDE** wurde **Slowly Changing Dimension Type 2** implementiert.

Bei Änderungen von Kundendaten werden bestehende Datensätze nicht überschrieben.

Stattdessen wird:

- der alte Datensatz historisiert,
- ein neuer Datensatz erzeugt,
- der Gültigkeitszeitraum gespeichert.

Verwendete Attribute:

- gueltig_von
- gueltig_bis
- ist_aktuell

Dadurch bleiben historische Informationen vollständig erhalten und können für zeitbezogene Analysen genutzt werden.

---

# Business-Fragen

Im Rahmen des Projekts wurden folgende analytische Fragestellungen umgesetzt.

## 1. Welche Tarife erzielen den höchsten Umsatz?

SQL-Datei:

```
queries/01_umsatzanalyse.sql
```

---

## 2. Zu welcher Tageszeit werden die meisten Anrufe getätigt?

SQL-Datei:

```
queries/02_anrufe_nach_tageszeit.sql
```

---

## 3. Welche Kundengruppen weisen die höchste Churn Rate auf?

SQL-Datei:

```
queries/03_churn_analyse.sql
```

---

## 4. Wie verändert sich die SMS-Nutzung im Verlauf der Monate?

SQL-Datei:

```
queries/04_sms_nutzung_monatsverlauf.sql
```

---

# Datenquelle

Für das Projekt wurden synthetische Testdaten verwendet, welche eine typische Telekommunikationsumgebung simulieren.

Die Daten wurden als CSV-Dateien bereitgestellt und anschließend in die Business-Datenbank importiert.

Der Datenbestand umfasst ungefähr:

- 1.000 Kunden
- 1.000 Verträge
- 5.000 Anrufe
- 3.000 SMS
- 5 Tarifmodelle
- 5 Marketingkampagnen

---

# Dokumentation

Das Repository enthält eine vollständige Projektdokumentation.

## Dokumentation

- Projektbeschreibung
- Import der Daten in die Business-Datenbank
- Relationales Datenmodell
- Überprüfung der Normalformen
- Relationen
- Speicherplatzberechnung
- Multidimensionales ER-Modell
- Galaxy Schema
- Mapping-Tabelle
- ETL-Dokumentation
- SCD Typ 2
- Business-Fragen

## Diagramme

- ER-Modell
- Multidimensionales ER-Modell
- Galaxy Schema
- Datenbankarchitektur

---

# Projektinhalte

Dieses Projekt demonstriert praktische Kenntnisse in folgenden Bereichen:

- Relationale Datenbanken
- Datenmodellierung
- Datenbanknormalisierung
- SQL
- ETL-Prozesse
- Data Warehouse
- Dimensionale Modellierung
- Galaxy Schema
- Slowly Changing Dimensions
- Business Intelligence
- Analytische SQL-Abfragen

---

# Autor

**Viktoria Tschuchmann**

Junior Data Analyst | Junior Data Engineer

GitHub: https://github.com/DEIN_GITHUB

LinkedIn: https://linkedin.com/in/DEIN_LINKEDIN
