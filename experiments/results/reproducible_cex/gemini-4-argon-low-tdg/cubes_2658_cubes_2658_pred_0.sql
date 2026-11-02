-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Club One', 'West', '2005');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Club Two', 'East', '1998');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (3, 'Club Three', 'East', '2001');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (4, 'Club Four', 'North', '2010');
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (1.0, 1, 5.0, 2.0, 1.0, 8.0);
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (2.0, 1, 3.0, 1.0, 0.0, 4.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (101, 2, 'John Doe', 'Forward', 15.0, 5.0, '2', 24.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (102, 2, 'Jane Roe', 'Back', 20.0, 10.0, '5', 50.0);
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (10, 2020.0, 'League', 'UK');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (10, 1, 2, '24-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region FROM club ORDER BY region, club.club_id NULLS LAST;

/*
Gold Result:
('East',)
('East',)
('North',)
('West',)
*/

-- Prediction Query
SELECT DISTINCT Region FROM club ORDER BY Region ASC;

/*
Prediction Result:
('East',)
('North',)
('West',)
*/