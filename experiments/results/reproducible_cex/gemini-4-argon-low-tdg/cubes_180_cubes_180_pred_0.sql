-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE predicate: hand = 'L' vs 'R', 'U', 'l' (case sensitivity), and NULL.
-- 2. SELECT DISTINCT vs SELECT ALL: identical (first_name, last_name) pairs for two distinct players.
-- 3. ORDER BY first_name ASC, player_id ASC: ties on first_name where player_id order is inverse to last_name order.
-- 4. Unnecessary JOIN elimination: some matching players have no records in matches or rankings.
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (2, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (3, 'John', 'McEnroe', 'L', '1959-02-16', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (4, 'John', 'McEnroe', 'L', '1990-01-01', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (5, 'Novak', 'Djokovic', NULL, '1987-05-22', 'SRB');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (6, 'Andy', 'Murray', 'l', '1987-05-15', 'GBR');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (7, 'Jimmy', 'Connors', 'U', '1952-09-02', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (10, 'Albert', 'Zeballos', 'L', '1985-05-05', 'ARG');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (20, 'Albert', 'Costa', 'L', '1975-06-25', 'ESP');
INSERT INTO "matches" ("winner_id", "loser_id", "best_of", "draw_size", "winner_hand", "loser_hand", "winner_name", "loser_name", "tourney_id", "match_num") VALUES (2, 1, 3, 32, 'L', 'R', 'Roger Federer', 'Rafael Nadal', '2020-001', 1);
INSERT INTO "rankings" ("player_id", "ranking_date", "ranking", "ranking_points", "tours") VALUES (1, '2020-01-01', 1, 10000, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "last_name" FROM "players" WHERE ("hand" = 'L') ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Albert', 'Zeballos')
('Albert', 'Costa')
('John', 'McEnroe')
('John', 'McEnroe')
('Rafael', 'Nadal')
*/

-- Prediction Query
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date, players.player_id NULLS LAST;

/*
Prediction Result:
('John', 'McEnroe')
('Albert', 'Costa')
('Albert', 'Zeballos')
('Rafael', 'Nadal')
('John', 'McEnroe')
*/