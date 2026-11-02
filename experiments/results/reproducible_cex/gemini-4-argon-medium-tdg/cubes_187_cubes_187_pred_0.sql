-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by first_name, secondary ordering by player_id (inversely correlated with last_name to catch ORDER BY first_name, last_name mutants), and duplicate rows (to catch SELECT DISTINCT mutants). Also leaves matches and rankings empty to catch unwanted INNER JOIN mutants.
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (10, 'John', 'Zebra', 'R', '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (20, 'John', 'Apple', 'L', '1992-05-15', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (30, 'John', 'Apple', 'R', '1988-11-20', 'CAN');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Alice', 'Smith', 'R', '1995-03-10', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Bob', 'Jones', 'U', '1985-07-07', 'FRA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM players ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Alice', 'Smith')
('Bob', 'Jones')
('John', 'Zebra')
('John', 'Apple')
('John', 'Apple')
*/

-- Prediction Query
SELECT first_name, last_name FROM players ORDER BY birth_date, players.player_id NULLS LAST;

/*
Prediction Result:
('Bob', 'Jones')
('John', 'Apple')
('John', 'Zebra')
('John', 'Apple')
('Alice', 'Smith')
*/