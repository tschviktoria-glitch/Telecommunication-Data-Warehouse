USE DWH_Telekom
-- Lösche Dim_KUNDE Tabelle
--Drop TABLE DWH_Telekom.dbo.DIM_TARIF ;
--GO
CREATE TABLE DIM_TARIFF (
    Tarif_id       INT PRIMARY KEY IDENTITY(1,1),
    Tarif_name     VARCHAR(100),
    Tarif_typ      VARCHAR(50),
    Monatspreis    DECIMAL(10,2),
    Internet_GB    INT,
    SMS_Paket      INT,
    Minuten_Paket  INT
);
GO

INSERT INTO DIM_TARIFF (
    Tarif_name, Tarif_typ, Monatspreis,
    Internet_GB, SMS_Paket, Minuten_Paket
)
SELECT
    tarif_name,
    tarif_typ,
    monatspreis,
    Internet_GB,
    SMS_Paket,
    Minuten_Paket
FROM Telekom.dbo.TARIF;