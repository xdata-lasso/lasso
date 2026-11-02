-- Schema DDL
CREATE TABLE "ROUTES" (
    "RID" INT,
    "ALID" INT,
    "SRC_APID" INT,
    "DST_APID" INT,
    "DST_AP" TEXT,
    "SRC_AP" TEXT,
    "AIRLINE" TEXT,
    "CODESHARE" TEXT,
    PRIMARY KEY ("RID"),
    FOREIGN KEY ("ALID") REFERENCES "AIRLINES"("ALID"),
    FOREIGN KEY ("SRC_APID") REFERENCES "AIRPORTS"("APID"),
    FOREIGN KEY ("DST_APID") REFERENCES "AIRPORTS"("APID")
);
CREATE TABLE "AIRPORTS" (
    "APID" INT,
    "NAME" TEXT,
    "CITY" TEXT,
    "COUNTRY" TEXT,
    "X" FLOAT,
    "Y" FLOAT,
    "ELEVATION" INT,
    "IATA" TEXT,
    "ICAO" TEXT,
    PRIMARY KEY ("APID")
);
CREATE TABLE "AIRLINES" (
    "ALID" INT,
    "NAME" TEXT,
    "IATA" TEXT,
    "ICAO" TEXT,
    "CALLSIGN" TEXT,
    "COUNTRY" TEXT,
    "ACTIVE" TEXT,
    PRIMARY KEY ("ALID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ROUTES VALUES (0, 0, -1, 0, 0, 0, 0, 0);
INSERT INTO ROUTES VALUES (1, 0, -1, -1, 0, 0, 0, 0);
INSERT INTO AIRPORTS VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO AIRPORTS VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO AIRLINES VALUES (0, 11, 10, 10, 11, -4, 18);
INSERT INTO AIRLINES VALUES (-1, 11, 10, 10, 11, -3, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_other AS country FROM (SELECT alid, callsign AS name, iata, icao, callsign, country, active, alid_other, icao_other, callsign_other, country_other, active_other FROM (SELECT alid, name, icao AS iata, icao, callsign, country, active, alid_other, icao_other, callsign_other, country_other, active_other FROM (SELECT LHS.alid AS alid, LHS.name AS name, LHS.iata AS iata, LHS.icao AS icao, LHS.callsign AS callsign, LHS.country AS country, LHS.active AS active, RHS.alid AS alid_other, RHS.icao AS icao_other, RHS.callsign AS callsign_other, RHS.country AS country_other, RHS.active AS active_other FROM airlines AS LHS INNER JOIN airlines AS RHS ON (LHS.icao = RHS.iata AND LHS.callsign = RHS.name)))) ORDER BY country;

/*
Gold Result:
('-3',)
('-3',)
('-4',)
('-4',)
*/

-- Prediction Query
SELECT country FROM airlines GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('-3',)
*/