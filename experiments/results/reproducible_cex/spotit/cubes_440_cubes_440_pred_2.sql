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
INSERT INTO POKER_PLAYER VALUES (-1, 1, 12, 13, 14, 15);
INSERT INTO POKER_PLAYER VALUES (0, 0, 20, 21, 22, 23);
INSERT INTO PEOPLE VALUES (1, 8, 9, 10, 11);
INSERT INTO PEOPLE VALUES (0, 16, 17, 18, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('17',)
('9',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('9',)
('17',)
*/