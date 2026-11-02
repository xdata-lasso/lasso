-- Schema DDL
CREATE TABLE "COUNTY" (
    "COUNTY_ID" INT,
    "COUNTY_NAME" TEXT,
    "POPULATION" FLOAT,
    "ZIP_CODE" TEXT,
    PRIMARY KEY ("COUNTY_ID")
);
CREATE TABLE "PARTY" (
    "PARTY_ID" INT,
    "YEAR" FLOAT,
    "PARTY" TEXT,
    "GOVERNOR" TEXT,
    "LIEUTENANT_GOVERNOR" TEXT,
    "COMPTROLLER" TEXT,
    "ATTORNEY_GENERAL" TEXT,
    "US_SENATE" TEXT,
    PRIMARY KEY ("PARTY_ID")
);
CREATE TABLE "ELECTION" (
    "ELECTION_ID" INT,
    "DISTRICT" INT,
    "PARTY" INT,
    "COUNTIES_REPRESENTED" TEXT,
    "DELEGATE" TEXT,
    "FIRST_ELECTED" FLOAT,
    "COMMITTEE" TEXT,
    PRIMARY KEY ("ELECTION_ID"),
    FOREIGN KEY ("DISTRICT") REFERENCES "COUNTY"("COUNTY_ID"),
    FOREIGN KEY ("PARTY") REFERENCES "PARTY"("PARTY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COUNTY VALUES (1, 0, 0, 0);
INSERT INTO COUNTY VALUES (0, 0, 0, 0);
INSERT INTO PARTY VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PARTY VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ELECTION VALUES (1, 0, 0, 0, 11, 0, 12);
INSERT INTO ELECTION VALUES (0, 1, 1, 0, 11, 0, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT election_id, counties_represented, district, delegate, party, first_elected, committee FROM election ORDER BY election_id;

/*
Gold Result:
(0, '0', 1, '11', 1, 0.0, '13')
(1, '0', 0, '11', 0, 0.0, '12')
*/

-- Prediction Query
SELECT * FROM election;

/*
Prediction Result:
(1, 0, 0, '0', '11', 0.0, '12')
(0, 1, 1, '0', '11', 0.0, '13')
*/