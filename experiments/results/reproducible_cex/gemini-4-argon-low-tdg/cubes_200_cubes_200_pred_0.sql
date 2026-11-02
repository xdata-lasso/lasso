-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Primary ordering by count___ ASC vs ordering by YEAR first
-- 2. Secondary tie-breaker ordering by YEAR ASC vs DESC
-- 3. NULLS LAST behavior when tied on count___
-- 4. COUNT(*) vs COUNT(year) or COUNT(winner_id) when columns contain NULLs
-- 5. Unreferenced players (kills mutants that INNER JOIN or LEFT JOIN players)
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Novak', 'Djokovic', 'R', '1987-05-22', 'SRB');
-- Year NULL: 2 matches (1 with NULL winner_id/loser_id to test COUNT(*) vs COUNT(col))
INSERT INTO matches (winner_id, loser_id, year) VALUES (1, 2, NULL);
INSERT INTO matches (winner_id, loser_id, year) VALUES (NULL, NULL, NULL);
-- Year 2022: 2 matches (tied with Year 2018 and Year NULL on count=2, tests secondary sort and NULLS LAST)
INSERT INTO matches (winner_id, loser_id, year) VALUES (1, 2, 2022);
INSERT INTO matches (winner_id, loser_id, year) VALUES (2, 1, 2022);
-- Year 2018: 2 matches
INSERT INTO matches (winner_id, loser_id, year) VALUES (1, 2, 2018);
INSERT INTO matches (winner_id, loser_id, year) VALUES (NULL, 2, 2018);
-- Year 2020: 1 match (lowest count=1, but middle year, tests primary sort priority count___ over YEAR)
INSERT INTO matches (winner_id, loser_id, year) VALUES (2, 1, 2020);
-- Year 2015: 3 matches (highest count=3, lowest year, tests primary sort ASC vs DESC)
INSERT INTO matches (winner_id, loser_id, year) VALUES (1, 2, 2015);
INSERT INTO matches (winner_id, loser_id, year) VALUES (1, 2, 2015);
INSERT INTO matches (winner_id, loser_id, year) VALUES (1, 2, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, YEAR FROM (SELECT YEAR, COUNT(*) AS n FROM matches GROUP BY YEAR) ORDER BY count___, YEAR NULLS LAST;

/*
Gold Result:
(1, 2020)
(2, 2018)
(2, 2022)
(2, None)
(3, 2015)
*/

-- Prediction Query
SELECT COUNT(*), YEAR FROM matches GROUP BY YEAR;

/*
Prediction Result:
(2, None)
(3, 2015)
(2, 2018)
(1, 2020)
(2, 2022)
*/