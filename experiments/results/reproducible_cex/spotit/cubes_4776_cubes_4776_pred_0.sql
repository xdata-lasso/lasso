-- Schema DDL
CREATE TABLE "CITY" (
    "CITY_ID" INT,
    "CITY" TEXT,
    "HANZI" TEXT,
    "HANYU_PINYIN" TEXT,
    "REGIONAL_POPULATION" INT,
    "GDP" FLOAT,
    PRIMARY KEY ("CITY_ID")
);
CREATE TABLE "MATCH" (
    "MATCH_ID" INT,
    "DATE" TEXT,
    "VENUE" TEXT,
    "SCORE" TEXT,
    "RESULT" TEXT,
    "COMPETITION" TEXT,
    PRIMARY KEY ("MATCH_ID")
);
CREATE TABLE "TEMPERATURE" (
    "CITY_ID" INT,
    "JAN" FLOAT,
    "FEB" FLOAT,
    "MAR" FLOAT,
    "APR" FLOAT,
    "JUN" FLOAT,
    "JUL" FLOAT,
    "AUG" FLOAT,
    "SEP" FLOAT,
    "OCT" FLOAT,
    "NOV" FLOAT,
    "DEC" FLOAT,
    PRIMARY KEY ("CITY_ID"),
    FOREIGN KEY ("CITY_ID") REFERENCES "CITY"("CITY_ID")
);
CREATE TABLE "HOSTING_CITY" (
    "YEAR" INT,
    "MATCH_ID" INT,
    "HOST_CITY" TEXT,
    PRIMARY KEY ("YEAR"),
    FOREIGN KEY ("MATCH_ID") REFERENCES "MATCH"("MATCH_ID"),
    FOREIGN KEY ("HOST_CITY") REFERENCES "CITY"("CITY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CITY VALUES (1, 20, 21, 22, -2147461993, 16);
INSERT INTO CITY VALUES (0, 13, 14, 15, -2147461993, 12);
INSERT INTO MATCH VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO MATCH VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO TEMPERATURE VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO TEMPERATURE VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO HOSTING_CITY VALUES (-1, 1, 1);
INSERT INTO HOSTING_CITY VALUES (0, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gdp FROM (SELECT * FROM (SELECT * FROM (SELECT gdp, regional_population, MAX(regional_population) AS maxregional_population FROM city GROUP BY gdp, regional_population) ORDER BY regional_population DESC) LIMIT 1);

/*
Gold Result:
(12.0,)
*/

-- Prediction Query
SELECT gdp FROM city ORDER BY Regional_Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(12.0,)
*/