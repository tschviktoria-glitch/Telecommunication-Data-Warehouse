USE DWH_Telekom;
GO

SELECT
    dt.Tarif_name,
    dt.Tarif_typ,
    dt.Monatspreis,
    COUNT(fk.Kunde_SK) AS anzahl_kunden,
    SUM(fk.umsatz) AS Gesamtumsatz
FROM FAKTOR_KOMMUNIKATION fk
JOIN DIM_TARIFF dt
    ON fk.Tarif_id = dt.Tarif_id
GROUP BY
    dt.Tarif_name,
    dt.Tarif_typ,
    dt.Monatspreis
ORDER BY Gesamtumsatz DESC;
