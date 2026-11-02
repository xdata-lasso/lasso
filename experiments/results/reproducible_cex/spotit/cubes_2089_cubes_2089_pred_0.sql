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
INSERT INTO ROUTES VALUES (0, 0, -1, -1, 0, 0, 0, 0);
INSERT INTO ROUTES VALUES (-1, 0, 0, -1, 0, 0, 0, 0);
INSERT INTO AIRPORTS VALUES (-1, 8, 0, 0, 0, 0, -50, 0, 0);
INSERT INTO AIRPORTS VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO AIRLINES VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO AIRLINES VALUES (1, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM airports WHERE (elevation > -50 AND elevation <= 50) ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50;

/*
Prediction Result:
('8',)
('0',)
*/