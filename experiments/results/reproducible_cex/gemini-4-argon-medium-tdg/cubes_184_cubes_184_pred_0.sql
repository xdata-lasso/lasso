-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Novak', 'Djokovic', 'R', '1987-05-22', 'SRB');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-01', 1, 1000, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2020-01-01', 2, 900, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2020-01-01', 3, 800, 5);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-08', 1, 1050, 20);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2020-01-15', 2, 950, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2020-01-15', 3, 850, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumtours AS sum_tours_, ranking_date FROM (SELECT ranking_date, SUM(tours) AS sumtours FROM rankings GROUP BY ranking_date) ORDER BY sum_tours_, ranking_date NULLS LAST;

/*
Gold Result:
(20, '2020-01-08')
(25, '2020-01-01')
(25, '2020-01-15')
*/

-- Prediction Query
SELECT SUM(tours), ranking_date FROM rankings GROUP BY ranking_date;

/*
Prediction Result:
(25, '2020-01-01')
(20, '2020-01-08')
(25, '2020-01-15')
*/