-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, country_code) VALUES (1, 'USA');
INSERT INTO players (player_id, country_code) VALUES (2, 'USA');
INSERT INTO players (player_id, country_code) VALUES (3, 'USA');
INSERT INTO players (player_id, country_code) VALUES (4, 'USA');
INSERT INTO players (player_id, country_code) VALUES (5, 'USA');
INSERT INTO players (player_id, country_code) VALUES (6, 'USA');
INSERT INTO players (player_id, country_code) VALUES (7, 'USA');
INSERT INTO players (player_id, country_code) VALUES (8, 'USA');
INSERT INTO players (player_id, country_code) VALUES (9, 'USA');
INSERT INTO players (player_id, country_code) VALUES (10, 'USA');
INSERT INTO players (player_id, country_code) VALUES (11, 'USA');
INSERT INTO players (player_id, country_code) VALUES (12, 'USA');
INSERT INTO players (player_id, country_code) VALUES (13, 'USA');
INSERT INTO players (player_id, country_code) VALUES (14, 'USA');
INSERT INTO players (player_id, country_code) VALUES (15, 'USA');
INSERT INTO players (player_id, country_code) VALUES (16, 'USA');
INSERT INTO players (player_id, country_code) VALUES (17, 'USA');
INSERT INTO players (player_id, country_code) VALUES (18, 'USA');
INSERT INTO players (player_id, country_code) VALUES (19, 'USA');
INSERT INTO players (player_id, country_code) VALUES (20, 'USA');
INSERT INTO players (player_id, country_code) VALUES (21, 'USA');
INSERT INTO players (player_id, country_code) VALUES (22, 'USA');
INSERT INTO players (player_id, country_code) VALUES (23, 'USA');
INSERT INTO players (player_id, country_code) VALUES (24, 'USA');
INSERT INTO players (player_id, country_code) VALUES (25, 'USA');
INSERT INTO players (player_id, country_code) VALUES (26, 'USA');
INSERT INTO players (player_id, country_code) VALUES (27, 'USA');
INSERT INTO players (player_id, country_code) VALUES (28, 'USA');
INSERT INTO players (player_id, country_code) VALUES (29, 'USA');
INSERT INTO players (player_id, country_code) VALUES (30, 'USA');
INSERT INTO players (player_id, country_code) VALUES (31, 'USA');
INSERT INTO players (player_id, country_code) VALUES (32, 'USA');
INSERT INTO players (player_id, country_code) VALUES (33, 'USA');
INSERT INTO players (player_id, country_code) VALUES (34, 'USA');
INSERT INTO players (player_id, country_code) VALUES (35, 'USA');
INSERT INTO players (player_id, country_code) VALUES (36, 'USA');
INSERT INTO players (player_id, country_code) VALUES (37, 'USA');
INSERT INTO players (player_id, country_code) VALUES (38, 'USA');
INSERT INTO players (player_id, country_code) VALUES (39, 'USA');
INSERT INTO players (player_id, country_code) VALUES (40, 'USA');
INSERT INTO players (player_id, country_code) VALUES (41, 'USA');
INSERT INTO players (player_id, country_code) VALUES (42, 'USA');
INSERT INTO players (player_id, country_code) VALUES (43, 'USA');
INSERT INTO players (player_id, country_code) VALUES (44, 'USA');
INSERT INTO players (player_id, country_code) VALUES (45, 'USA');
INSERT INTO players (player_id, country_code) VALUES (46, 'USA');
INSERT INTO players (player_id, country_code) VALUES (47, 'USA');
INSERT INTO players (player_id, country_code) VALUES (48, 'USA');
INSERT INTO players (player_id, country_code) VALUES (49, 'USA');
INSERT INTO players (player_id, country_code) VALUES (50, 'USA');
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