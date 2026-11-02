-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering on 'hand' ('L', 'R', 'U', NULL), primary sorting on 'first_name', and secondary tie-breaker sorting on 'player_id' versus 'last_name'.
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (10, 'Alice', 'Smith', 'L', '1990-05-15', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (5, 'Alice', 'Zebra', 'L', '1992-08-20', 'GBR');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (20, 'Bob', 'Jones', 'R', '1988-11-30', 'CAN');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (15, 'Charlie', 'Brown', 'L', '1995-02-10', 'AUS');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (25, 'David', 'Lee', NULL, '1991-07-04', 'KOR');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (30, 'Eve', 'Adams', 'U', '1993-12-12', 'FRA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "last_name" FROM "players" WHERE ("hand" = 'L') ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zebra')
('Alice', 'Smith')
('Charlie', 'Brown')
*/

-- Prediction Query
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date, players.player_id NULLS LAST;

/*
Prediction Result:
('Alice', 'Smith')
('Alice', 'Zebra')
('Charlie', 'Brown')
*/