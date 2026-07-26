USE DWH_Telekom;
GO

SELECT
    CASE
        WHEN dk.Alter_ BETWEEN 18 AND 25 THEN '18-25'
        WHEN dk.Alter_ BETWEEN 26 AND 35 THEN '26-35'
        WHEN dk.Alter_ BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END                                         AS Altersgruppe,
    dk.Geschlecht,
    dt.Tarif_typ,
    COUNT(*)                                    AS Gesamt_Kunden,
    SUM(CAST(fka.ist_gekuendigt AS INT))        AS Gekuendigte,
    ROUND(
        SUM(CAST(fka.ist_gekuendigt AS INT)) * 100.0 
        / COUNT(*), 2
    )                                           AS Churn_Rate_Prozent
FROM FAKTOR_KUNDENABWANDERUNG fka
JOIN DIM_KUNDE  dk ON fka.Kunde_SK = dk.Kunde_SK
JOIN DIM_TARIFF dt ON fka.Tarif_id = dt.Tarif_id
GROUP BY
    CASE
        WHEN dk.Alter_ BETWEEN 18 AND 25 THEN '18-25'
        WHEN dk.Alter_ BETWEEN 26 AND 35 THEN '26-35'
        WHEN dk.Alter_ BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END,
    dk.Geschlecht,
    dt.Tarif_typ
ORDER BY Churn_Rate_Prozent DESC;