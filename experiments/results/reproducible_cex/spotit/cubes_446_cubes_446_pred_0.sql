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
INSERT INTO POKER_PLAYER VALUES (1, 0, 24, 25, 26, 27);
INSERT INTO POKER_PLAYER VALUES (0, 0, 31, 32, 33, 34);
INSERT INTO PEOPLE VALUES (-1, 20, 21, 22, 23);
INSERT INTO PEOPLE VALUES (0, 28, 29, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.poker_player_id AS poker_player_id, LHS.people_id AS people_id, LHS.final_table_made AS final_table_made, LHS.best_finish AS best_finish, LHS.money_rank AS money_rank, LHS.earnings AS earnings, RHS.nationality AS nationality, RHS.name AS name, RHS.birth_date AS birth_date, RHS.height AS height FROM poker_player AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY poker_player_id) LIMIT 1);

/*
Gold Result:
(33.0,)
*/

-- Prediction Query
SELECT T2.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Height DESC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(33.0,)
*/