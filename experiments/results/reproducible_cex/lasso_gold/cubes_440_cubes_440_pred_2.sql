-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1017, 'Jamaica', 'Brandon Hall', 'play', 1018.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1031, 'Cyprus', 'Donald Booth', 'song', 1032.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1019, 1017, 1020.5, 1021.5, 1022.5, 1023.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1026, 1017, 1027.5, 1028.5, 1029.5, 1030.5);
INSERT INTO "poker_player" ("poker_player_id", "people_id", "final_table_made", "best_finish", "money_rank", "earnings") VALUES (1033, 1031, 1034.5, 1035.5, 1036.5, 1037.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM poker_player AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Brandon Hall',)
('Donald Booth',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('Brandon Hall',)
('Brandon Hall',)
('Donald Booth',)
*/