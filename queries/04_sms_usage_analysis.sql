SELECT
    dz.Jahr,
    dz.Monat,
    SUM(fk.anzahl_sms)              AS Gesamt_SMS,
    AVG(fk.anzahl_sms)              AS Durchschnitt_SMS,
    SUM(fk.anzahl_sms) 
    - LAG(SUM(fk.anzahl_sms)) 
      OVER (ORDER BY dz.Jahr, dz.Monat) AS Veraenderung_Vormonat
FROM FAKTOR_KOMMUNIKATION fk
JOIN DIM_ZEIT dz ON fk.Zeit_id = dz.Zeit_id
GROUP BY dz.Jahr, dz.Monat
ORDER BY dz.Jahr, dz.Monat;