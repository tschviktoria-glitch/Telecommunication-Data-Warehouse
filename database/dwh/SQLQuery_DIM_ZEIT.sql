USE DWH_Telekom;
GO

DROP TABLE IF EXISTS DIM_ZEIT;
GO

SET LANGUAGE German;
CREATE TABLE DIM_ZEIT (
    Zeit_id INT IDENTITY(1,1) PRIMARY KEY,
    Datum DATE NOT NULL,
    Tageszeit VARCHAR(20),
    Wochentag VARCHAR(20),
    Monat INT,
    Jahr INT
);
GO

INSERT INTO DIM_ZEIT (
    Datum,
    Tageszeit,
    Wochentag,
    Monat,
    Jahr
)

SELECT DISTINCT
    CAST(anruf_datum AS DATE),

    CASE
        WHEN DATEPART(HOUR, anruf_uhrzeit) BETWEEN 0 AND 5 THEN 'Nacht'
        WHEN DATEPART(HOUR, anruf_uhrzeit) BETWEEN 6 AND 11 THEN 'Morgen'
        WHEN DATEPART(HOUR, anruf_uhrzeit) BETWEEN 12 AND 17 THEN 'Mittag'
        ELSE 'Abend'
    END,

    DATENAME(WEEKDAY, anruf_datum),

    MONTH(anruf_datum),
    YEAR(anruf_datum)

FROM Telekom.dbo.ANRUF

UNION

SELECT DISTINCT
    CAST(sms_datum AS DATE),

    CASE
        WHEN DATEPART(HOUR, sms_uhrzeit) BETWEEN 0 AND 5 THEN 'Nacht'
        WHEN DATEPART(HOUR, sms_uhrzeit) BETWEEN 6 AND 11 THEN 'Morgen'
        WHEN DATEPART(HOUR, sms_uhrzeit) BETWEEN 12 AND 17 THEN 'Mittag'
        ELSE 'Abend'
    END,

    DATENAME(WEEKDAY, sms_datum),

    MONTH(sms_datum),
    YEAR(sms_datum)

FROM Telekom.dbo.SMS;
GO