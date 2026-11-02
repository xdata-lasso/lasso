-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Taylor', 'Fritz', 'R', '1997-10-28', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Andre', 'Agassi', 'R', '1970-04-29', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'John', 'Zoom', 'L', '1995-02-16', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'John', 'Adams', 'R', '1985-04-26', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Novak', 'Djokovic', 'R', '1987-05-22', 'SRB');
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (1, 3, 3, 32, 35.8, 'DA', 'L', 185, 'ESP', 'Rafael Nadal', 4, 5000, 2, 101, 125, 'F', '6-3 7-6', 'Hard', '2022-03-20', '2022-404', 'M', 'Indian Wells', 24.4, 'DA', 'R', 196, 'USA', 'Taylor Fritz', 20, 2000, 20, 2022);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (1, 6, 3, 32, 35.0, 'DA', 'R', 188, 'SRB', 'Novak Djokovic', 1, 8000, 1, 102, 140, 'SF', '6-4 6-4', 'Hard', '2022-03-19', '2022-404', 'M', 'Indian Wells', 24.4, 'DA', 'R', 196, 'USA', 'Taylor Fritz', 20, 2000, 20, 2022);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2022-03-21', 8, 3500, 22);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2022-03-28', 9, 3450, 22);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2022-03-21', 3, 6000, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "birth_date" FROM "players" WHERE ("country_code" = 'USA') ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Andre', '1970-04-29')
('John', '1995-02-16')
('John', '1985-04-26')
('Taylor', '1997-10-28')
*/

-- Prediction Query
SELECT first_name, birth_date FROM players WHERE country_code = 'USA';

/*
Prediction Result:
('Taylor', '1997-10-28')
('Andre', '1970-04-29')
('John', '1995-02-16')
('John', '1985-04-26')
*/