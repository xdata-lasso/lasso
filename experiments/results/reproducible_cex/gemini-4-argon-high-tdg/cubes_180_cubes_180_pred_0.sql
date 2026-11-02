-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Charlie', 'Brown', 'L', '1990-05-10', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (10, 'Alex', 'Zimmer', 'L', '1995-08-20', 'GER');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (20, 'Alex', 'Adams', 'L', '1988-01-15', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (30, 'Alex', 'Adams', 'L', '1992-03-12', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (40, 'Bob', 'Smith', 'R', '1991-07-07', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (50, 'David', 'Jones', 'U', '1993-11-30', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (60, 'Evan', 'Davis', NULL, '1994-02-28', 'ITA');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (10, '2020-01-01', 1, 5000, 20);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (10, '2020-02-01', 2, 4800, 19);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (40, '2020-01-01', 3, 4000, 18);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (10, 40, 3, 32, 28.5, 'WC', 'R', 185, 'FRA', 'Bob Smith', 3, 4000, 2, 1, 120, 'F', '6-4 6-4', 'Hard', '2020-01-15', '2020-001', 'A', 'Open', 24.4, 'DA', 'L', 188, 'GER', 'Alex Zimmer', 1, 5000, 1, 2020);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (10, 40, 3, 32, 28.6, 'WC', 'R', 185, 'FRA', 'Bob Smith', 3, 4000, 2, 2, 95, 'F', '6-2 6-3', 'Clay', '2020-02-15', '2020-002', 'A', 'Clay Open', 24.5, 'DA', 'L', 188, 'GER', 'Alex Zimmer', 2, 4800, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "last_name" FROM "players" WHERE ("hand" = 'L') ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Alex', 'Zimmer')
('Alex', 'Adams')
('Alex', 'Adams')
('Charlie', 'Brown')
*/

-- Prediction Query
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date, players.player_id NULLS LAST;

/*
Prediction Result:
('Alex', 'Adams')
('Charlie', 'Brown')
('Alex', 'Adams')
('Alex', 'Zimmer')
*/