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
INSERT INTO ELECTION VALUES (2, -1, 24, -1, 25, 26, 27);
INSERT INTO ELECTION VALUES (3, 0, 32, 0, 33, 34, 35);
INSERT INTO REPRESENTATIVE VALUES (0, 28, 29, 30, 31);
INSERT INTO REPRESENTATIVE VALUES (-1, 36, 37, 38, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('28',)
('36',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('28',)
('36',)
*/