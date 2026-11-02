-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (1, 'San Siro', 19, 55000.0, 1045000.0, 80.5);
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (2, 'Stadio Olimpico', 19, 45000.0, 855000.0, 70.0);
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (10, 1, 2010, '2010-11-06', 'Inter', 'Brescia', '1-1', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (20, 2, 2008, '2008-10-19', 'Roma', 'Inter', '0-4', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (30, NULL, NULL, '2012-05-01', 'Inter', 'Parma', '3-1', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (40, 1, 2011, '2011-09-20', 'Novara', 'Inter', '3-1', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (50, 2, 2009, '2009-04-05', 'Udinese', 'Inter', '0-1', 'Serie A');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (1, 10, 'Walter Samuel', 'Knee ligament tear', '30', 'Gazzetta');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (2, 10, 'Walter Samuel', 'Meniscus', '15', 'Corriere');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (3, 20, 'Walter Samuel', 'Hamstring strain', '3', 'Sky Sport');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (4, 30, 'Walter Samuel', 'Calf injury', '2', 'Official Site');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (5, 40, 'Javier Zanetti', 'Achilles tendon', '20', 'Gazzetta');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (6, NULL, 'Walter Samuel', 'Training knock', '1', 'Inter Channel');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "season" FROM (SELECT "stadium_id", "id", "season", "date", "home_team", "away_team", "score", "competition", "id_other", "player", "injury", "number_of_matches", "source", "id" AS "game_id" FROM (SELECT "LHS"."stadium_id" AS "stadium_id", "LHS"."id" AS "id", "LHS"."season" AS "season", "LHS"."date" AS "date", "LHS"."home_team" AS "home_team", "LHS"."away_team" AS "away_team", "LHS"."score" AS "score", "LHS"."competition" AS "competition", "RHS"."id" AS "id_other", "RHS"."player" AS "player", "RHS"."injury" AS "injury", "RHS"."number_of_matches" AS "number_of_matches", "RHS"."source" AS "source" FROM "game" AS "LHS" INNER JOIN "injury_accident" AS "RHS" ON ("LHS"."id" = "RHS"."game_id"))) WHERE ("player" = 'Walter Samuel') ORDER BY season, "season" NULLS LAST;

/*
Gold Result:
(None,)
(2008,)
(2010,)
(2010,)
*/

-- Prediction Query
SELECT T1.season FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id WHERE T2.player = 'Walter Samuel';

/*
Prediction Result:
(2010,)
(2010,)
(2008,)
(None,)
*/