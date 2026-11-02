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
INSERT INTO PARTY VALUES (1, 16, 17, -1, 18, 19, 0, 20);
INSERT INTO PARTY VALUES (0, 16, 17, -1, 18, 19, 0, 20);
INSERT INTO ELECTION VALUES (0, 1, 0, 0, 0, 0, 0);
INSERT INTO ELECTION VALUES (1, 1, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT attorney_general AS governor FROM (SELECT LHS.attorney_general AS attorney_general, LHS.n AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT attorney_general, COUNT(*) AS n FROM party GROUP BY attorney_general)) AS RHS ON (LHS.n = RHS.n)) ORDER BY governor;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/