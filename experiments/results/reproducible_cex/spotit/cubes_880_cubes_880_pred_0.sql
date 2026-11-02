-- Schema DDL
CREATE TABLE "STORM" (
    "STORM_ID" INT,
    "NAME" TEXT,
    "DATES_ACTIVE" TEXT,
    "MAX_SPEED" INT,
    "DAMAGE_MILLIONS_USD" FLOAT,
    "NUMBER_DEATHS" INT,
    PRIMARY KEY ("STORM_ID")
);
CREATE TABLE "REGION" (
    "REGION_ID" INT,
    "REGION_CODE" TEXT,
    "REGION_NAME" TEXT,
    PRIMARY KEY ("REGION_ID")
);
CREATE TABLE "AFFECTED_REGION" (
    "REGION_ID" INT,
    "STORM_ID" INT,
    "NUMBER_CITY_AFFECTED" FLOAT,
    PRIMARY KEY ("REGION_ID", "STORM_ID"),
    FOREIGN KEY ("STORM_ID") REFERENCES "STORM"("STORM_ID"),
    FOREIGN KEY ("REGION_ID") REFERENCES "REGION"("REGION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STORM VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO STORM VALUES (1, 0, 0, 0, 0, 1);
INSERT INTO REGION VALUES (1, 0, 0);
INSERT INTO REGION VALUES (0, 0, 0);
INSERT INTO AFFECTED_REGION VALUES (0, 1, 0);
INSERT INTO AFFECTED_REGION VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, dates_active, number_deaths FROM storm WHERE (number_deaths > 1) ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name, dates_active, number_deaths FROM storm WHERE number_deaths >= 1;

/*
Prediction Result:
('0', '0', 1)
*/