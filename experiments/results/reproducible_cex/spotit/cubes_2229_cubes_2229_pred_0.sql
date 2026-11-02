-- Schema DDL
CREATE TABLE "ELECTION" (
    "ELECTION_ID" INT,
    "REPRESENTATIVE_ID" INT,
    "DATE" TEXT,
    "VOTES" FLOAT,
    "VOTE_PERCENT" FLOAT,
    "SEATS" FLOAT,
    "PLACE" FLOAT,
    PRIMARY KEY ("ELECTION_ID"),
    FOREIGN KEY ("REPRESENTATIVE_ID") REFERENCES "REPRESENTATIVE"("REPRESENTATIVE_ID")
);
CREATE TABLE "REPRESENTATIVE" (
    "REPRESENTATIVE_ID" INT,
    "NAME" TEXT,
    "STATE" TEXT,
    "PARTY" TEXT,
    "LIFESPAN" TEXT,
    PRIMARY KEY ("REPRESENTATIVE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ELECTION VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO ELECTION VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO REPRESENTATIVE VALUES (1, 0, 0, 0, 0);
INSERT INTO REPRESENTATIVE VALUES (0, -1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE NOT EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Name FROM representative WHERE NOT Representative_ID IN (SELECT Representative_ID FROM election);

/*
Prediction Result:
('0',)
*/