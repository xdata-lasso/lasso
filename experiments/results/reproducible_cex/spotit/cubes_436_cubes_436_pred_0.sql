-- Schema DDL
CREATE TABLE "POKER_PLAYER" (
    "POKER_PLAYER_ID" INT,
    "PEOPLE_ID" INT,
    "FINAL_TABLE_MADE" FLOAT,
    "BEST_FINISH" FLOAT,
    "MONEY_RANK" FLOAT,
    "EARNINGS" FLOAT,
    PRIMARY KEY ("POKER_PLAYER_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NATIONALITY" TEXT,
    "NAME" TEXT,
    "BIRTH_DATE" TEXT,
    "HEIGHT" FLOAT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO POKER_PLAYER VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO POKER_PLAYER VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 7, 8, 9, 10);
INSERT INTO PEOPLE VALUES (1, 7, 8, 9, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT nationality, COUNT(*) AS n FROM people GROUP BY nationality) WHERE (n > 2) ORDER BY nationality;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;

/*
Prediction Result:
('7',)
*/