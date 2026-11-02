-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: competition --
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (1, 1.0, 'Friendly', 'com_5e4a55');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483647, 1.0, 'Friendly', 'com_b68873');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (3, 582.588439, 'Friendly', '5k5swwqcgsk');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (2, 572.766956, 'Friendly', '8c4p');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483644, 935.695299, 'u7vfe4hria2y', 'q_2_c4771c');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483643, 797.015047, 'uzhs', 'q_2_c4771c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "competition" WHERE ("competition_type" = 'Friendly' OR "competition_type" = 'Tournament')) ORDER BY competition_type DESC) LIMIT 1);

/*
Gold Result:
('com_b68873',)
*/

-- Prediction Query
SELECT country FROM competition WHERE competition_type = 'Friendly' INTERSECT SELECT country FROM competition WHERE competition_type = 'Tournament';

/*
Prediction Result:
*/