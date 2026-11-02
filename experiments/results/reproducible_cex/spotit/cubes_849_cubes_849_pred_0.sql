-- Schema DDL
CREATE TABLE "PERPETRATOR" (
    "PERPETRATOR_ID" INT,
    "PEOPLE_ID" INT,
    "DATE" TEXT,
    "YEAR" FLOAT,
    "LOCATION" TEXT,
    "COUNTRY" TEXT,
    "KILLED" INT,
    "INJURED" INT,
    PRIMARY KEY ("PERPETRATOR_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "HOME_TOWN" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERPETRATOR VALUES (-1, 0, 25, 26, 27, 28, 0, NULL);
INSERT INTO PERPETRATOR VALUES (0, 0, 32, 33, 34, 35, 0, NULL);
INSERT INTO PEOPLE VALUES (-1, 22, 0, 23, 24);
INSERT INTO PEOPLE VALUES (0, 29, -1, 30, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY height;

/*
Gold Result:
(-1.0,)
*/

-- Prediction Query
SELECT T1.Height FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Injured DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
(-1.0,)
(-1.0,)
*/