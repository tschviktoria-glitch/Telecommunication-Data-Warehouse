USE DWH_Telekom;
GO

DROP TABLE IF EXISTS FAKTOR_KUNDENABWANDERUNG;
GO

CREATE TABLE FAKTOR_KUNDENABWANDERUNG (
    Fakt_id INT PRIMARY KEY IDENTITY(1,1),

    Kunde_SK INT NOT NULL,
    Tarif_id INT NOT NULL,
    Zeit_id INT NOT NULL,

    ist_gekuendigt BIT DEFAULT 0,
    Kuendigungsgrund VARCHAR(200),

    FOREIGN KEY (Kunde_SK)
        REFERENCES DIM_KUNDE(Kunde_SK),

    FOREIGN KEY (Tarif_id)
        REFERENCES DIM_TARIFF(Tarif_id),

    FOREIGN KEY (Zeit_id)
        REFERENCES DIM_ZEIT(Zeit_id)
);
GO

INSERT INTO FAKTOR_KUNDENABWANDERUNG (
    Kunde_SK,
    Tarif_id,
    Zeit_id,
    ist_gekuendigt,
    Kuendigungsgrund
)
SELECT
    dk.Kunde_SK,
    dt.Tarif_id,
    dz.Zeit_id,
    v.ist_gekuendigt,
    ISNULL(v.kuendigungsgrund, 'Kein Grund angegeben')

FROM Telekom.dbo.VERTRAG v

JOIN Telekom.dbo.KUNDE k
    ON v.kunde_id = k.kunde_id

JOIN Telekom.dbo.TARIF t
    ON v.tarif_id = t.tarif_id

JOIN DIM_KUNDE dk
    ON dk.Quelle_Kunde_id = k.kunde_id
   AND dk.ist_aktuell = 1

JOIN DIM_TARIFF dt
    ON dt.Tarif_id = t.tarif_id

JOIN DIM_ZEIT dz
    ON dz.Datum = CAST(v.kuendigungsdatum AS DATE)

WHERE v.ist_gekuendigt = 1;
GO