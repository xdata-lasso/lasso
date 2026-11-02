-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Alpha FC', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Beta United', 'South', '1995');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'Gamma Rovers', 'East', '2000');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (4, 'Delta City', 'West', '2005');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (5, 'Epsilon Town', 'Central', '2010');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (6, 'Zeta Athletic', 'North', '2012');
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 1, 2.0, 3.0, 1.0, 6.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (2.0, 1, 2.0, 3.0, 1.0, 6.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 2, 4.0, 4.0, 1.0, 9.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (3.0, 3, 5.0, 4.0, 1.0, 10.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (4.0, 4, 8.0, 6.0, 1.0, 15.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (5.0, 2, 1.0, 2.0, 2.0, 5.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (6.0, 3, 2.0, 2.0, 3.0, 7.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (7.0, 4, 1.0, 4.0, 3.0, 8.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (8.0, 5, 1.0, 1.0, 4.0, 6.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (9.0, 5, 3.0, 2.0, 5.0, 10.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (101, 1, 'John Doe', 'Forward', 10.0, 2.0, '3', 14.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (102, 1, 'Jane Roe', 'Back', 12.0, 5.0, '1', 22.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (103, 3, 'Sam Smith', 'Halfback', 8.0, 1.0, '4', 12.0);
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (201, 2020.0, 'League', 'UK');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (201, 1, 2, '24-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT bronze, COUNT(*) AS n FROM (SELECT * FROM club_rank WHERE (total < 10.0)) GROUP BY bronze) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM club_rank WHERE Total < 10;

/*
Prediction Result:
(7,)
*/