USE DWH_Telekom
-- Lösche Dim_KUNDE Tabelle
Drop TABLE DWH_Telekom.dbo.DIM_MARKETING_AKTION ;
GO
CREATE TABLE DIM_MARKETING_AKTION (
    Kampagne_id     INT PRIMARY KEY IDENTITY(1,1),
    Kampagnenname   VARCHAR(100),
    Kampagnentyp    VARCHAR(50),
    Rabatt          DECIMAL(5,2),
    Startdatum      DATE,
    Enddatum        DATE,
    Zielgruppe      VARCHAR(100)
);

INSERT INTO DIM_MARKETING_AKTION (
    Kampagnenname,
    Kampagnentyp,
    Rabatt,
    Startdatum,
    Enddatum,
    Zielgruppe
)
SELECT
    kampagnenname,
    kampagnentyp,
    rabatt,
    startdatum,
    enddatum,
    'Nicht definiert'
FROM Telekom.dbo.MARKETING_AKTION;
