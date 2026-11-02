-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (10, 'San Siro', 19, 55000.0, 1045000.0, 68.5);
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (20, 'Stadio Olimpico', 19, 45000.0, 855000.0, 62.0);
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (1, 10, 2010, '2010-01-10', 'Inter', 'Siena', '4-3', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (2, 20, 2005, '2012-05-01', 'Roma', 'Lazio', '0-0', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (3, 10, 2005, '2005-11-20', 'Inter', 'Parma', '2-0', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (4, 20, 2008, '2008-03-15', 'Inter', 'Palermo', '2-1', 'Serie A');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (5, 10, 2015, '2015-09-20', 'Inter', 'Milan', '1-0', 'Serie A');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (101, 1, 'Walter Samuel', 'Knee injury', '15', 'Official');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (102, 2, 'Walter Samuel', 'Hamstring', '3', 'Medical');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (103, 2, 'Walter Samuel', 'Ankle sprain', '2', 'Medical');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (4, 3, 'Walter Samuel', 'Fractured nose', '1', 'Press');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (105, 4, 'Walter', 'Calf strain', '4', 'Official');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (106, 4, 'walter samuel', 'Bruised rib', '1', 'Official');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (107, 4, 'Javier Zanetti', 'Achilles tendon', '20', 'Official');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "season" FROM (SELECT "stadium_id", "id", "season", "date", "home_team", "away_team", "score", "competition", "id_other", "player", "injury", "number_of_matches", "source", "id" AS "game_id" FROM (SELECT "LHS"."stadium_id" AS "stadium_id", "LHS"."id" AS "id", "LHS"."season" AS "season", "LHS"."date" AS "date", "LHS"."home_team" AS "home_team", "LHS"."away_team" AS "away_team", "LHS"."score" AS "score", "LHS"."competition" AS "competition", "RHS"."id" AS "id_other", "RHS"."player" AS "player", "RHS"."injury" AS "injury", "RHS"."number_of_matches" AS "number_of_matches", "RHS"."source" AS "source" FROM "game" AS "LHS" INNER JOIN "injury_accident" AS "RHS" ON ("LHS"."id" = "RHS"."game_id"))) WHERE ("player" = 'Walter Samuel') ORDER BY season, "season" NULLS LAST;

/*
Gold Result:
(2005,)
(2005,)
(2005,)
(2010,)
*/

-- Prediction Query
SELECT T1.season FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id WHERE T2.player = 'Walter Samuel';

/*
Prediction Result:
(2005,)
(2010,)
(2005,)
(2005,)
*/