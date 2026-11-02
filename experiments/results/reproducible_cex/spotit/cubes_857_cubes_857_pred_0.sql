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
INSERT INTO PERPETRATOR VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PERPETRATOR VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, -1, 0, 0, 0);
INSERT INTO PEOPLE VALUES (-1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM perpetrator);

/*
Prediction Result:
('0',)
*/