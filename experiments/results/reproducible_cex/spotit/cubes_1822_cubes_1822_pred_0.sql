-- Schema DDL
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "DISTRICT" TEXT,
    "NAME" TEXT,
    "PARTY" TEXT,
    "AGE" INT,
    PRIMARY KEY ("PEOPLE_ID")
);
CREATE TABLE "DEBATE" (
    "DEBATE_ID" INT,
    "DATE" TEXT,
    "VENUE" TEXT,
    "NUM_OF_AUDIENCE" INT,
    PRIMARY KEY ("DEBATE_ID")
);
CREATE TABLE "DEBATE_PEOPLE" (
    "DEBATE_ID" INT,
    "AFFIRMATIVE" INT,
    "NEGATIVE" INT,
    "IF_AFFIRMATIVE_WIN" INT,
    PRIMARY KEY ("DEBATE_ID", "AFFIRMATIVE", "NEGATIVE"),
    FOREIGN KEY ("NEGATIVE") REFERENCES "PEOPLE"("PEOPLE_ID"),
    FOREIGN KEY ("AFFIRMATIVE") REFERENCES "PEOPLE"("PEOPLE_ID"),
    FOREIGN KEY ("DEBATE_ID") REFERENCES "DEBATE"("DEBATE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PEOPLE VALUES (1, 16, 0, 17, 0);
INSERT INTO PEOPLE VALUES (0, 18, 0, 19, 0);
INSERT INTO DEBATE VALUES (0, 0, 0, 0);
INSERT INTO DEBATE VALUES (-1, 0, 0, 0);
INSERT INTO DEBATE_PEOPLE VALUES (-1, 0, 1, 0);
INSERT INTO DEBATE_PEOPLE VALUES (0, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.people_id AS people_id, LHS.district AS district, LHS.name AS name, LHS.party AS party, LHS.age AS age, RHS.n AS n FROM people AS LHS INNER JOIN (SELECT affirmative, COUNT(*) AS n FROM debate_people GROUP BY affirmative) AS RHS ON (LHS.people_id = RHS.affirmative)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('0', 1)
('0', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM debate_people AS T1 JOIN people AS T2 ON T1.Affirmative = T2.People_ID GROUP BY T2.Name;

/*
Prediction Result:
('0', 2)
*/