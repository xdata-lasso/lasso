-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1013, 'Anthony', 'Robinson', 'mouth', '1976-07-07', 'Netherlands');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1017, 'James', 'Santos', 'offer', '1978-09-09', 'Italy');
INSERT INTO "rankings" ("player_id", "ranking_date", "ranking", "ranking_points", "tours") VALUES (1013, '1977-08-08', 1014, 1015, 1016);
INSERT INTO "rankings" ("player_id", "ranking_date", "ranking", "ranking_points", "tours") VALUES (1017, '1979-10-10', 1018, NULL, 1020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumranking_points AS sum_ranking_points_, first_name FROM (SELECT first_name, SUM(ranking_points) AS sumranking_points FROM (SELECT LHS.player_id AS player_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.hand AS hand, LHS.birth_date AS birth_date, LHS.country_code AS country_code, RHS.ranking_date AS ranking_date, RHS.ranking AS ranking, RHS.ranking_points AS ranking_points, RHS.tours AS tours FROM players AS LHS INNER JOIN rankings AS RHS ON (LHS.player_id = RHS.player_id)) GROUP BY first_name) ORDER BY sum_ranking_points_, first_name NULLS LAST;

/*
Gold Result:
(None, 'James')
(1015, 'Anthony')
*/

-- Prediction Query
SELECT SUM(ranking_points), T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;

/*
Prediction Result:
(1015, 'Anthony')
(None, 'James')
*/