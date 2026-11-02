-- Schema DDL
CREATE TABLE "INSTRUCTOR" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "TEACHES" (
    "ID" INT,
    "YEAR" INT,
    PRIMARY KEY ("ID", "YEAR"),
    FOREIGN KEY ("ID") REFERENCES "INSTRUCTOR"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO INSTRUCTOR VALUES (-1, 7);
INSERT INTO INSTRUCTOR VALUES (0, 7);
INSERT INTO TEACHES VALUES (0, 2009);
INSERT INTO TEACHES VALUES (-1, 2009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM instructor WHERE NOT EXISTS(SELECT * FROM teaches WHERE year = 2009);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM instructor;

/*
Prediction Result:
('7',)
('7',)
*/