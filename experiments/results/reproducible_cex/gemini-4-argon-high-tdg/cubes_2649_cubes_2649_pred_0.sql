-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Arsenal', 'London', '1886');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Chelsea', 'London', '1905');
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (1.0, 1, 10.0, 5.0, 2.0, 17.0);
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (2.0, 2, 8.0, 4.0, 3.0, 15.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (1, 1, 'John Doe', 'Forward', 50.0, 10.0, '12', 64.0);
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (1, 2018.0, 'Cup', 'UK');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (2, 2004.0, 'World Cup', 'Germany');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (3, 2018.0, 'League', 'Spain');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (4, 2018.0, 'Cup', 'France');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (5, 2010.0, 'Cup', 'Italy');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (6, 1999.0, 'Tournament', 'USA');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (7, 2010.0, 'Tournament', 'Brazil');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (1, 1, 2, '2-1');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (6, 1, 2, '0-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "year" FROM "competition" WHERE ("competition_type" <> 'Tournament') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(2004.0,)
(2010.0,)
(2018.0,)
*/

-- Prediction Query
SELECT DISTINCT YEAR FROM competition WHERE Competition_type <> 'Tournament';

/*
Prediction Result:
(2018.0,)
(2004.0,)
(2010.0,)
*/