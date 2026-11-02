-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY first_name ASC, and tie-breaking with player_id ASC (coupled with conflicting birth_date and last_name orderings)
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (30, 'Pete', 'Sampras', 'R', '1971-08-12', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (10, 'Andre', 'Agassi', 'R', '1970-04-29', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (25, 'Jim', 'Courier', 'R', '1970-08-17', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (5, 'Jim', 'Pugh', 'R', '1980-02-05', 'USA');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (15, 'Jim', 'Grabb', 'R', '1964-04-14', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "birth_date" FROM "players" WHERE ("country_code" = 'USA') ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Andre', '1970-04-29')
('Jim', '1980-02-05')
('Jim', '1964-04-14')
('Jim', '1970-08-17')
('Pete', '1971-08-12')
*/

-- Prediction Query
SELECT first_name, birth_date FROM players WHERE country_code = 'USA';

/*
Prediction Result:
('Jim', '1980-02-05')
('Andre', '1970-04-29')
('Jim', '1964-04-14')
('Jim', '1970-08-17')
('Pete', '1971-08-12')
*/