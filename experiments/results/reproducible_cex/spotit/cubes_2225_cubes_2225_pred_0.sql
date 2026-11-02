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
INSERT INTO ELECTION VALUES (1, 0, 23, 24, 0, 25, 26);
INSERT INTO ELECTION VALUES (2, 1, 31, 32, 1, 33, 34);
INSERT INTO REPRESENTATIVE VALUES (1, 27, 28, 29, 30);
INSERT INTO REPRESENTATIVE VALUES (0, 35, 36, 37, 38);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lifespan FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY lifespan;

/*
Gold Result:
('30',)
('38',)
*/

-- Prediction Query
SELECT T2.Lifespan FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY Vote_Percent DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('30',)
('38',)
*/