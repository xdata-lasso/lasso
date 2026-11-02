-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, home_games, average_attendance, total_attendance, capacity_percentage) VALUES (1, NULL, NULL, 101.0, 1.0, 100.0), (100, 'default2', 1, 1.0, 1.0, NULL), (99, 'default1', 1, 101.0, 100.0, 101.0), (101, NULL, 99, NULL, 99.0, 0.0), (0, 'default2', NULL, 0.0, 100.0, NULL), (2, NULL, 101, 1.0, 100.0, 101.0), (3, 'default2', 101, 99.0, 0.0, 101.0), (4, NULL, 0, 101.0, 0.0, 0.0), (5, NULL, 0, NULL, 100.0, 99.0), (6, 'default1', 100, NULL, NULL, 101.0), (7, 'default2', 0, 1.0, 99.0, 100.0), (8, 'default1', 1, 99.0, 99.0, 1.0), (9, 'default2', NULL, NULL, 1.0, 0.0), (10, NULL, 1, 1.0, 100.0, 101.0), (11, 'default2', 100, 99.0, 101.0, 100.0), (12, 'default1', 99, NULL, 100.0, 1.0), (13, 'default1', 99, 101.0, 99.0, 1.0), (14, 'default1', 1, NULL, 0.0, 1.0), (15, NULL, NULL, 100.0, NULL, 1.0), (16, NULL, 99, NULL, 99.0, 101.0), (17, NULL, 100, 99.0, 101.0, NULL), (18, NULL, 101, 100.0, 1.0, 101.0), (19, NULL, NULL, 100.0, 101.0, 0.0), (20, 'default2', NULL, 100.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT average_attendance FROM stadium WHERE (capacity_percentage > 100.0) ORDER BY average_attendance, stadium.id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(1.0,)
(1.0,)
(99.0,)
(100.0,)
(101.0,)
*/

-- Prediction Query
SELECT average_attendance FROM stadium WHERE capacity_percentage > 100;

/*
Prediction Result:
(1.0,)
(99.0,)
(None,)
(1.0,)
(None,)
(100.0,)
(101.0,)
*/