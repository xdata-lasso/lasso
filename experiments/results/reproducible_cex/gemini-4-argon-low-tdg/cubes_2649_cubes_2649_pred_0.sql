-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Club A', 'North', '1999');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Club B', 'South', '1998');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (1, 2020.0, 'League', 'UK');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (2, 2020.0, 'League', 'US');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (3, 2018.0, 'Cup', 'UK');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (4, 2019.0, 'Tournament', 'FR');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (5, NULL, 'Friendly', 'DE');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (6, 2021.0, NULL, 'ES');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (1, 1, 2, '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "year" FROM "competition" WHERE ("competition_type" <> 'Tournament') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(None,)
(2018.0,)
(2020.0,)
*/

-- Prediction Query
SELECT DISTINCT YEAR FROM competition WHERE Competition_type <> 'Tournament';

/*
Prediction Result:
(2020.0,)
(2018.0,)
(None,)
*/