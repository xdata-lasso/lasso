-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'John', 'Doe', 'R', '1990-01-01', 'USA');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-01', 1, 100, 20);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-02', 1, 100, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumtours AS sum_tours_, ranking_date FROM (SELECT ranking_date, SUM(tours) AS sumtours FROM rankings GROUP BY ranking_date) ORDER BY sum_tours_, ranking_date NULLS LAST;

/*
Gold Result:
(10, '2020-01-02')
(20, '2020-01-01')
*/

-- Prediction Query
SELECT SUM(tours), ranking_date FROM rankings GROUP BY ranking_date;

/*
Prediction Result:
(20, '2020-01-01')
(10, '2020-01-02')
*/