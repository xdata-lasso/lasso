-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Ordering by count___ ASC vs YEAR ASC (when count increases as year decreases).
-- 2. Secondary sorting by YEAR ASC when count___ is tied (including NULLS LAST for YEAR).
-- 3. COUNT(*) vs COUNT(year) vs COUNT(DISTINCT ...).
-- 4. Unreferenced players (kills INNER JOIN with players table if mutant unnecessarily joins).
INSERT INTO players (player_id, first_name, last_name) VALUES (1, 'Roger', 'Federer');
INSERT INTO players (player_id, first_name, last_name) VALUES (2, 'Rafael', 'Nadal');
INSERT INTO players (player_id, first_name, last_name) VALUES (3, 'Novak', 'Djokovic');
-- Year 2022: count = 1
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, 2022, 1);
-- Year 2020: count = 2 (tied with 2021 and NULL)
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, 2020, 1);
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, 2020, 1);
-- Year 2021: count = 2 (tied with 2020 and NULL, inserted before 2020 to test sorting)
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (2, 1, 2021, 1);
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, 2021, 2);
-- Year NULL: count = 2 (tied with 2020 and 2021, tests NULLS LAST and COUNT(*) vs COUNT(year))
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, NULL, 1);
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (2, 1, NULL, 2);
-- Year 2019: count = 3
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, 2019, 1);
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (2, 1, 2019, 2);
INSERT INTO matches (winner_id, loser_id, year, match_num) VALUES (1, 2, 2019, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, YEAR FROM (SELECT YEAR, COUNT(*) AS n FROM matches GROUP BY YEAR) ORDER BY count___, YEAR NULLS LAST;

/*
Gold Result:
(1, 2022)
(2, 2020)
(2, 2021)
(2, None)
(3, 2019)
*/

-- Prediction Query
SELECT COUNT(*), YEAR FROM matches GROUP BY YEAR;

/*
Prediction Result:
(2, None)
(3, 2019)
(2, 2020)
(2, 2021)
(1, 2022)
*/