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
INSERT INTO POKER_PLAYER VALUES (-2147483648, -2147483648, 16, 17, 18, 300000);
INSERT INTO POKER_PLAYER VALUES (-2147483647, -2147483648, 19, 20, 21, 299999);
INSERT INTO PEOPLE VALUES (-2147483648, 6, 0, 7, NULL);
INSERT INTO PEOPLE VALUES (-2147483647, 9, 10, 11, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.nationality AS nationality, LHS.name AS name, LHS.birth_date AS birth_date, LHS.height AS height, RHS.poker_player_id AS poker_player_id, RHS.final_table_made AS final_table_made, RHS.best_finish AS best_finish, RHS.money_rank AS money_rank, RHS.earnings AS earnings FROM people AS LHS INNER JOIN (SELECT * FROM poker_player WHERE (earnings >= 300000.0)) AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000;

/*
Prediction Result:
*/