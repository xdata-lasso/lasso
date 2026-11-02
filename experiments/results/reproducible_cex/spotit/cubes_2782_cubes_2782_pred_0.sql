-- Schema DDL
CREATE TABLE "ENTREPRENEUR" (
    "ENTREPRENEUR_ID" INT,
    "PEOPLE_ID" INT,
    "COMPANY" TEXT,
    "MONEY_REQUESTED" FLOAT,
    "INVESTOR" TEXT,
    PRIMARY KEY ("ENTREPRENEUR_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "DATE_OF_BIRTH" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ENTREPRENEUR VALUES (0, 0, 0, 140000, 0);
INSERT INTO ENTREPRENEUR VALUES (1, -1, 0, 0, 6);
INSERT INTO PEOPLE VALUES (-1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor FROM entrepreneur WHERE (money_requested >= 140000.0 AND money_requested <> 120000.0) ORDER BY investor, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur WHERE Money_Requested > 140000 INTERSECT SELECT Investor FROM entrepreneur WHERE Money_Requested < 120000;

/*
Prediction Result:
*/