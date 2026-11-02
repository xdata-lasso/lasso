-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (1, 'USA', 'Alice', '1990-01-01', 170.0);
INSERT INTO "people" ("People_ID", "Nationality", "Name", "Birth_Date", "Height") VALUES (2, 'USA', 'Bob', '1990-01-02', 190.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (1, 1, 1.0, 1.0, 10.0, 1000.0);
INSERT INTO "poker_player" ("Poker_Player_ID", "People_ID", "Final_Table_Made", "Best_Finish", "Money_Rank", "Earnings") VALUES (2, 2, 1.0, 1.0, 20.0, 2000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT money_rank FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.poker_player_id AS poker_player_id, LHS.people_id AS people_id, LHS.final_table_made AS final_table_made, LHS.best_finish AS best_finish, LHS.money_rank AS money_rank, LHS.earnings AS earnings, RHS.nationality AS nationality, RHS.name AS name, RHS.birth_date AS birth_date, RHS.height AS height FROM poker_player AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY poker_player_id) LIMIT 1);

/*
Gold Result:
(10.0,)
*/

-- Prediction Query
SELECT T2.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Height DESC, T1.people_id NULLS LAST, T2.poker_player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(20.0,)
*/