-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: club --
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: club_rank --
INSERT INTO "club_rank" ("rank", "club_id", "gold", "silver", "bronze", "total") VALUES (249.706432, -2147483648, 99.523333, 314.813297, 328.996339, 9.99);

INSERT INTO "club_rank" ("rank", "club_id", "gold", "silver", "bronze", "total") VALUES (483.665643, -2147483648, 818.685402, 804.971537, 119.752245, 10.0);

INSERT INTO "club_rank" ("rank", "club_id", "gold", "silver", "bronze", "total") VALUES (710.998147, -2147483648, 945.642658, 795.366812, 378.476082, 9.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT bronze, COUNT(*) AS n FROM (SELECT * FROM club_rank WHERE (total < 10.0)) GROUP BY bronze) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM club_rank WHERE Total < 10;

/*
Prediction Result:
(2,)
*/