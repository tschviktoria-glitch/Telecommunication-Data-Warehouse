CREATE TABLE FAKTOR_KOMMUNIKATION (
    Fakt_id INT PRIMARY KEY IDENTITY(1,1),

    Kunde_SK INT NOT NULL,
    Tarif_id INT NOT NULL,
    Zeit_id INT NOT NULL,
    Kampagne_id INT NULL,

    anzahl_sms INT DEFAULT 0,
    anzahl_anrufe INT DEFAULT 0,
    Gespraechsdauer INT DEFAULT 0,
    umsatz DECIMAL(10,2),

    FOREIGN KEY (Kunde_SK)
        REFERENCES DIM_KUNDE(Kunde_SK),

    FOREIGN KEY (Tarif_id)
        REFERENCES DIM_TARIFF(Tarif_id),

    FOREIGN KEY (Zeit_id)
        REFERENCES DIM_ZEIT(Zeit_id),

    FOREIGN KEY (Kampagne_id)
        REFERENCES DIM_MARKETING_AKTION(Kampagne_id)
);
GO

INSERT INTO FAKTOR_KOMMUNIKATION
(
    Kunde_SK,
    Tarif_id,
    Zeit_id,
    Kampagne_id,
    anzahl_sms,
    anzahl_anrufe,
    Gespraechsdauer,
    umsatz
)
SELECT
    dk.Kunde_SK,
    dt.Tarif_id,
    dz.Zeit_id,
    dma.Kampagne_id,

    COUNT(DISTINCT s.sms_id),
    COUNT(DISTINCT a.anruf_id),

    ISNULL(SUM(a.dauer_sekunden),0),

    dt.Monatspreis

FROM Telekom.dbo.VERTRAG v

JOIN Telekom.dbo.KUNDE k
    ON v.kunde_id = k.kunde_id

JOIN Telekom.dbo.TARIF t
    ON v.tarif_id = t.tarif_id

LEFT JOIN Telekom.dbo.ANRUF a
    ON v.vertrag_id = a.vertrag_id

LEFT JOIN Telekom.dbo.SMS s
    ON v.vertrag_id = s.vertrag_id

LEFT JOIN Telekom.dbo.MARKETING_AKTION ma
    ON v.kampagne_id = ma.kampagne_id

JOIN DIM_KUNDE dk
    ON dk.Quelle_Kunde_id = k.kunde_id
   AND dk.ist_aktuell = 1

JOIN DIM_TARIFF dt
    ON dt.Tarif_id = t.tarif_id

JOIN DIM_ZEIT dz
    ON dz.Datum = CAST(
        ISNULL(a.anruf_datum, s.sms_datum)
        AS DATE
    )

LEFT JOIN DIM_MARKETING_AKTION dma
    ON dma.Kampagne_id = ma.kampagne_id

GROUP BY
    dk.Kunde_SK,
    dt.Tarif_id,
    dz.Zeit_id,
    dma.Kampagne_id,
    dt.Monatspreis;
GO