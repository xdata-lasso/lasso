-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, country_code) VALUES
(1, 'USA'), (2, 'USA'), (3, 'USA'), (4, 'USA'), (5, 'USA'),
(6, 'USA'), (7, 'USA'), (8, 'USA'), (9, 'USA'), (10, 'USA'),
(11, 'USA'), (12, 'USA'), (13, 'USA'), (14, 'USA'), (15, 'USA'),
(16, 'USA'), (17, 'USA'), (18, 'USA'), (19, 'USA'), (20, 'USA'),
(21, 'USA'), (22, 'USA'), (23, 'USA'), (24, 'USA'), (25, 'USA'),
(26, 'USA'), (27, 'USA'), (28, 'USA'), (29, 'USA'), (30, 'USA'),
(31, 'USA'), (32, 'USA'), (33, 'USA'), (34, 'USA'), (35, 'USA'),
(36, 'USA'), (37, 'USA'), (38, 'USA'), (39, 'USA'), (40, 'USA'),
(41, 'USA'), (42, 'USA'), (43, 'USA'), (44, 'USA'), (45, 'USA'),
(46, 'USA'), (47, 'USA'), (48, 'USA'), (49, 'USA'), (50, 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) WHERE (n >= 50) ORDER BY country_code;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50;

/*
Prediction Result:
*/