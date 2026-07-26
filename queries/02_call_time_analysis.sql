USE DWH_Telekom;
GO

SELECT
    dz.Tageszeit,
    SUM(fk.anzahl_anrufe)           AS Gesamt_Anrufe,
    SUM(fk.Gespraechsdauer) / 60    AS Gesamt_Minuten
FROM FAKTOR_KOMMUNIKATION fk
JOIN DIM_ZEIT dz ON fk.Zeit_id = dz.Zeit_id
GROUP BY dz.Tageszeit
ORDER BY Gesamt_Anrufe DESC;