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
INSERT INTO POKER_PLAYER VALUES (1, 0, 25, 26, 27, 0);
INSERT INTO POKER_PLAYER VALUES (0, 0, 31, 32, 33, 0);
INSERT INTO PEOPLE VALUES (1, 22, 0, 23, 24);
INSERT INTO PEOPLE VALUES (0, 28, NULL, 29, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings DESC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST;

/*
Prediction Result:
(None,)
(None,)
*/