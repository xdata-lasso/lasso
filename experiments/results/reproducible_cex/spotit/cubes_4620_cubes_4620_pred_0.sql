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
INSERT INTO ROUTES VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ROUTES VALUES (0, 0, 0, -1, 0, 0, 0, 0);
INSERT INTO AIRPORTS VALUES (0, 24, 25, 2, 26, 27, 1, 28, 29);
INSERT INTO AIRPORTS VALUES (-1, 30, 31, 1, 32, 33, 1, 34, 35);
INSERT INTO AIRLINES VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO AIRLINES VALUES (0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT LHS.elevation AS elevation, RHS.apid AS apid, RHS.name AS name, RHS.city AS city, RHS.country AS country, RHS.x AS x, RHS.y AS y, RHS.iata AS iata, RHS.icao AS icao FROM (SELECT MAX(elevation) AS elevation FROM airports) AS LHS LEFT JOIN airports AS RHS ON (LHS.elevation = RHS.elevation)) ORDER BY country;

/*
Gold Result:
('1',)
('2',)
*/

-- Prediction Query
SELECT country FROM airports ORDER BY elevation DESC, airports.apid NULLS LAST LIMIT 1;

/*
Prediction Result:
('1',)
*/