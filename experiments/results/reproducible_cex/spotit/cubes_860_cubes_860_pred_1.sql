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
INSERT INTO PERPETRATOR VALUES (0, 0, 12, 13, 14, 15, 0, 0);
INSERT INTO PERPETRATOR VALUES (1, -1, 20, 21, 22, 23, 0, 0);
INSERT INTO PEOPLE VALUES (0, 8, 9, 10, 11);
INSERT INTO PEOPLE VALUES (-1, 16, 17, 18, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('16',)
('8',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('8',)
('16',)
*/