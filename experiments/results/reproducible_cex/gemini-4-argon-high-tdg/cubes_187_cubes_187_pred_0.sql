-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Zoran', 'Petrovic', 'R', '1990-05-14', 'SRB');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Alex', 'Middle', 'L', '1988-11-20', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Alex', 'Zebra', 'R', '1995-02-10', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Alex', 'Alpha', 'L', '1992-07-04', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Carlos', 'Silva', 'R', '1985-01-30', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Carlos', 'Silva', 'L', '1999-09-09', 'BRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'Aaron', 'Brown', 'R', '2001-03-15', 'CAN');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-06', 10, 2500, 18);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-13', 9, 2600, 19);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2020-01-06', 25, 1200, 15);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (1, 2, 3, 32, 31.1, 'WC', 'L', 185, 'USA', 'Alex Middle', 25, 1200, 5, 101, 95, 'R32', '6-4 6-3', 'Hard', '2020-01-06', '2020-001', 'A', 'Doha', 29.6, 'DA', 'R', 188, 'SRB', 'Zoran Petrovic', 10, 2500, 2, 2020);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (1, 3, 3, 32, 24.9, 'Q', 'R', 180, 'GBR', 'Alex Zebra', 50, 800, 8, 102, 110, 'R16', '7-6 6-4', 'Hard', '2020-01-07', '2020-001', 'A', 'Doha', 29.6, 'DA', 'R', 188, 'SRB', 'Zoran Petrovic', 10, 2500, 2, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM players ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Aaron', 'Brown')
('Alex', 'Middle')
('Alex', 'Zebra')
('Alex', 'Alpha')
('Carlos', 'Silva')
('Carlos', 'Silva')
('Zoran', 'Petrovic')
*/

-- Prediction Query
SELECT first_name, last_name FROM players ORDER BY birth_date, players.player_id NULLS LAST;

/*
Prediction Result:
('Carlos', 'Silva')
('Alex', 'Middle')
('Zoran', 'Petrovic')
('Alex', 'Alpha')
('Alex', 'Zebra')
('Carlos', 'Silva')
('Aaron', 'Brown')
*/