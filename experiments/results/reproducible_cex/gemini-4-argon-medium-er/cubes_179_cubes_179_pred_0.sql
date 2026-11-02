-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, country_code) VALUES (1, 'USA');
INSERT INTO players (player_id, country_code) VALUES (2, 'USA');
INSERT INTO players (player_id, country_code) VALUES (3, 'FRA');
INSERT INTO players (player_id, country_code) VALUES (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) ORDER BY count___, country_code NULLS LAST;

/*
Gold Result:
(1, 'FRA')
(1, None)
(2, 'USA')
*/

-- Prediction Query
SELECT COUNT(*), country_code FROM players GROUP BY country_code;

/*
Prediction Result:
(1, None)
(1, 'FRA')
(2, 'USA')
*/