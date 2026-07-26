USE DWH_Telekom;
GO

DROP TABLE IF EXISTS DIM_KUNDE;
GO

CREATE TABLE DIM_KUNDE (
    Kunde_SK INT PRIMARY KEY IDENTITY(1,1),
    Quelle_Kunde_id INT NOT NULL,

    Alter_ INT,
    Geschlecht VARCHAR(10),
    Beruf VARCHAR(100),
    Anmeldedatum DATE,

    gueltig_von DATE,
    gueltig_bis DATE,
    ist_aktuell BIT DEFAULT 1
);
GO

INSERT INTO DIM_KUNDE (
    Quelle_Kunde_id,
    Alter_,
    Geschlecht,
    Beruf,
    Anmeldedatum,
    gueltig_von,
    gueltig_bis,
    ist_aktuell
)
SELECT
    kunde_id,
    DATEDIFF(YEAR, geburtsdatum, GETDATE()),
    geschlecht,
    beruf,
    anmeldedatum,
    GETDATE(),
    NULL,
    1
FROM Telekom.dbo.KUNDE;
GO