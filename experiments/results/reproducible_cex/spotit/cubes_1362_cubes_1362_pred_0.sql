-- Schema DDL
CREATE TABLE "PERSON" (
    "NAME" TEXT,
    "AGE" INT,
    "CITY" TEXT,
    "GENDER" TEXT,
    "JOB" TEXT,
    PRIMARY KEY ("NAME")
);
CREATE TABLE "PERSONFRIEND" (
    "FRIEND" TEXT,
    "NAME" TEXT,
    "YEAR" INT,
    FOREIGN KEY ("FRIEND") REFERENCES "PERSON"("NAME"),
    FOREIGN KEY ("NAME") REFERENCES "PERSON"("NAME")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERSON VALUES (2, 0, 0, 0, 0);
INSERT INTO PERSON VALUES (3, 0, 0, 0, 0);
INSERT INTO PERSONFRIEND VALUES (2, 2, 0);
INSERT INTO PERSONFRIEND VALUES (2, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM person AS LHS WHERE NOT EXISTS(SELECT 1 FROM personfriend AS RHS WHERE (LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
('3',)
*/

-- Prediction Query
SELECT name FROM person EXCEPT SELECT name FROM PersonFriend;

/*
Prediction Result:
('3',)
*/