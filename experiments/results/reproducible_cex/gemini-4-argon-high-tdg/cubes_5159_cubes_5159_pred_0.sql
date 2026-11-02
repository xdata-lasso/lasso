-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Alpha FC', 'Europe', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Beta United', 'Asia', '1995');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (1, 2005.0, 'All-Star', 'Argentina');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (2, 2010.0, 'Friendly', 'Australia');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (3, 2012.0, 'League', 'Belgium');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (4, 2015.0, 'Tournament', 'Brazil');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (5, 2025.0, 'World Cup', 'Denmark');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (6, 2020.0, 'Friendly', 'Canada');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (7, 2030.0, NULL, 'Egypt');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (2, 1, 2, '2-1');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (3, 2, 1, '0-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "competition" WHERE ("competition_type" = 'Friendly' OR "competition_type" = 'Tournament')) ORDER BY competition_type DESC) LIMIT 1);

/*
Gold Result:
('Brazil',)
*/

-- Prediction Query
SELECT country FROM competition WHERE competition_type = 'Friendly' INTERSECT SELECT country FROM competition WHERE competition_type = 'Tournament';

/*
Prediction Result:
*/