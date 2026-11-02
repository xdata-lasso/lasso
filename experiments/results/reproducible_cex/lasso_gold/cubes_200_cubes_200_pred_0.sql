-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1203, 'Angela', 'Higgins', 'clear', '1994-03-02', 'Comoros');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1220, 'Joe', 'Wilson', 'voice', '1996-05-04', 'Montenegro');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1237, 'Shari', 'Smith', 'pretty', '1998-07-06', 'Mongolia');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1204, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1221, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1238, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "matches" ("winner_id", "loser_id", "best_of", "draw_size", "loser_age", "loser_entry", "loser_hand", "loser_ht", "loser_ioc", "loser_name", "loser_rank", "loser_rank_points", "loser_seed", "match_num", "minutes", "round", "score", "surface", "tourney_date", "tourney_id", "tourney_level", "tourney_name", "winner_age", "winner_entry", "winner_hand", "winner_ht", "winner_ioc", "winner_name", "winner_rank", "winner_rank_points", "winner_seed", "year") VALUES (1203, 1204, 1205, 1206, 1207.5, 'fine', 'director', 1208, 'article', 'Kimberly Adkins', 1209, 1210, 1211, 1212, 1213, 'art', 'apply', 'pattern', '1995-04-03', 'me', 'morning', 'Kim Brown', 1214.5, 'movie', 'be', 1215, 'today', 'Kurt Leonard', 1216, 1217, 1218, 1219);
INSERT INTO "matches" ("winner_id", "loser_id", "best_of", "draw_size", "loser_age", "loser_entry", "loser_hand", "loser_ht", "loser_ioc", "loser_name", "loser_rank", "loser_rank_points", "loser_seed", "match_num", "minutes", "round", "score", "surface", "tourney_date", "tourney_id", "tourney_level", "tourney_name", "winner_age", "winner_entry", "winner_hand", "winner_ht", "winner_ioc", "winner_name", "winner_rank", "winner_rank_points", "winner_seed", "year") VALUES (1220, 1221, 1222, 1223, 1224.5, 'employee', 'particular', 1225, 'phone', 'Bradley Sandoval', 1226, 1227, 1228, 1229, 1230, 'other', 'necessary', 'four', '1997-06-05', 'worry', 'every', 'Mike Allen', 1231.5, 'individual', 'catch', 1232, 'remain', 'Joyce Hickman', 1233, 1234, 1235, 1219);
INSERT INTO "matches" ("winner_id", "loser_id", "best_of", "draw_size", "loser_age", "loser_entry", "loser_hand", "loser_ht", "loser_ioc", "loser_name", "loser_rank", "loser_rank_points", "loser_seed", "match_num", "minutes", "round", "score", "surface", "tourney_date", "tourney_id", "tourney_level", "tourney_name", "winner_age", "winner_entry", "winner_hand", "winner_ht", "winner_ioc", "winner_name", "winner_rank", "winner_rank_points", "winner_seed", "year") VALUES (1237, 1238, 1239, 1240, 1241.5, 'black', 'back', 1242, 'note', 'Derek Mahoney', 1243, 1244, 1245, 1246, 1247, 'upon', 'authority', 'until', '1970-08-07', 'election', 'hope', 'Jeffrey Daniels', 1248.5, 'five', 'population', 1249, 'surface', 'Aimee Montoya', 1250, 1251, 1252, 1220);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, YEAR FROM (SELECT YEAR, COUNT(*) AS n FROM matches GROUP BY YEAR) ORDER BY count___, YEAR NULLS LAST;

/*
Gold Result:
(1, 1220)
(2, 1219)
*/

-- Prediction Query
SELECT COUNT(*), YEAR FROM matches GROUP BY YEAR;

/*
Prediction Result:
(2, 1219)
(1, 1220)
*/