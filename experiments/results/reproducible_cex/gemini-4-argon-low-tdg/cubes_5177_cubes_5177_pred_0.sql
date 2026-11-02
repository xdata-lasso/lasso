-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Club Alpha', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Club Beta', 'South', '1995');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'Club Gamma', 'East', '2000');
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 1, 2.0, 3.0, 1.0, 6.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (2.0, 1, 1.0, 2.0, 1.0, 4.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (3.0, 2, 1.0, 1.0, 1.0, 3.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (4.0, 2, 0.0, 2.0, 5.0, 7.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (5.0, 3, 2.0, 2.0, 5.0, 9.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (6.0, 3, 3.0, 3.0, 3.0, 9.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (7.0, 1, 4.0, 3.0, 3.0, 10.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (8.0, 2, 5.0, 5.0, 1.0, 11.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT bronze, COUNT(*) AS n FROM (SELECT * FROM club_rank WHERE (total < 10.0)) GROUP BY bronze) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM club_rank WHERE Total < 10;

/*
Prediction Result:
(6,)
*/