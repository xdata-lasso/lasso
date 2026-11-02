-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1001, 'Danielle', 'Jackson', 'seven', '1970-01-01', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1002, 'Angel', 'Daniel', 'type', '1970-01-02', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1003, 'Joshua', 'Martin', 'serve', '1970-01-03', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1004, 'Jeffrey', 'Gray', 'everyone', '1970-01-04', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1005, 'Jill', 'Mayo', 'month', '1970-01-05', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1006, 'Erica', 'Bowman', 'sound', '1970-01-06', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1007, 'Patricia', 'Hawkins', 'could', '1970-01-07', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1008, 'Christopher', 'Cohen', 'movement', '1970-01-08', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1009, 'Robert', 'Cameron', 'while', '1970-01-09', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1010, 'Anthony', 'Parsons', 'born', '1970-01-10', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1011, 'Jeffery', 'Perez', 'truth', '1970-01-11', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1012, 'William', 'Johnson', 'process', '1970-01-12', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1013, 'James', 'Stewart', 'fire', '1970-01-13', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1014, 'Debra', 'Adams', 'thought', '1970-01-14', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1015, 'Amy', 'Clark', 'purpose', '1970-01-15', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1016, 'Bridget', 'Hahn', 'politics', '1970-01-16', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1017, 'Lisa', 'Walter', 'decide', '1970-01-17', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1018, 'Adam', 'Edwards', 'claim', '1970-01-18', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1019, 'Linda', 'Rios', 'hour', '1970-01-19', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1020, 'Helen', 'Foster', 'color', '1970-01-20', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1021, 'Matthew', 'Rocha', 'notice', '1970-01-21', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1022, 'Eric', 'Ellis', 'start', '1970-01-22', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1023, 'Susan', 'Baker', 'win', '1970-01-23', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1024, 'Colin', 'Wright', 'nice', '1970-01-24', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1025, 'Melanie', 'Hoffman', 'why', '1970-01-25', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1026, 'Cassandra', 'Richards', 'a', '1970-01-26', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1027, 'Lindsay', 'Hurst', 'place', '1970-01-27', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1028, 'Jessica', 'Ross', 'game', '1970-01-28', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1029, 'Amanda', 'Robinson', 'middle', '1970-01-29', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1030, 'Teresa', 'Bright', 'after', '1970-01-30', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1031, 'Nicholas', 'Hicks', 'brother', '1970-01-31', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1032, 'Andrea', 'Davis', 'woman', '1970-02-01', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1033, 'Maria', 'Williams', 'him', '1970-02-02', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1034, 'Christine', 'Rodriguez', 'unit', '1970-02-03', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1035, 'Michelle', 'Burton', 'theory', '1970-02-04', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1036, 'Barbara', 'Conner', 'surface', '1970-02-05', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1037, 'Janet', 'Henderson', 'food', '1970-02-06', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1038, 'Brandon', 'Brown', 'education', '1970-02-07', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1039, 'Jeremy', 'James', 'article', '1970-02-08', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1040, 'Keith', 'Ferrell', 'effect', '1970-02-09', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1041, 'Jesse', 'Rice', 'our', '1970-02-10', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1042, 'Craig', 'Maddox', 'your', '1970-02-11', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1043, 'Cynthia', 'Valencia', 'bar', '1970-02-12', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1044, 'Michael', 'Smith', 'bed', '1970-02-13', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1045, 'Mitchell', 'Le', 'sign', '1970-02-14', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1046, 'Jason', 'Maldonado', 'mention', '1970-02-15', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1047, 'Joseph', 'Herrera', 'team', '1970-02-16', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1048, 'Sharon', 'Davidson', 'authority', '1970-02-17', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1049, 'Deborah', 'Graham', 'soon', '1970-02-18', 'Seychelles');
INSERT INTO "players" ("player_id", "first_name", "last_name", "hand", "birth_date", "country_code") VALUES (1050, 'Chelsea', 'Chavez', 'no', '1970-02-19', 'Seychelles');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) WHERE (n >= 50) ORDER BY country_code;

/*
Gold Result:
('Seychelles',)
*/

-- Prediction Query
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50;

/*
Prediction Result:
*/