-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by first_name, secondary ordering by player_id when first_name ties (in inversely correlated order with last_name), and DISTINCT vs ALL with identical (first_name, last_name) pairs.
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (10, 'Bob', 'Smith', 'R', '1990-01-01', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (20, 'Alice', 'Zimmerman', 'L', '1992-05-10', 'GBR');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (30, 'Alice', 'Adams', 'R', '1988-11-20', 'CAN');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (40, 'Alice', 'Adams', 'R', '1995-03-15', 'AUS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM players ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmerman')
('Alice', 'Adams')
('Alice', 'Adams')
('Bob', 'Smith')
*/

-- Prediction Query
SELECT first_name, last_name FROM players ORDER BY birth_date, players.player_id NULLS LAST;

/*
Prediction Result:
('Alice', 'Adams')
('Bob', 'Smith')
('Alice', 'Zimmerman')
('Alice', 'Adams')
*/