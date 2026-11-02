-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests multiple count tiers (1, 1, 2, 3), DISTINCT elimination (count 3 matches against both 1 and 2, and twice against the two 1s), and inverse correlation between college name and count to catch ORDER BY mistakes.
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Lakers');
-- 'Alpha' has count 3 (highest count, alphabetically first)
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 1, 1, 'P1', 'G', 1, '2001', 'Alpha');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 1, 1, 'P2', 'G', 2, '2002', 'Alpha');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 1, 1, 'P3', 'F', 3, '2003', 'Alpha');
-- 'Beta' has count 2 (middle count, alphabetically second)
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 1, 1, 'P4', 'F', 4, '2004', 'Beta');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2005.0, 1, 1, 'P5', 'C', 5, '2005', 'Beta');
-- 'Gamma' and 'Delta' have count 1 (lowest count)
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2006.0, 1, 1, 'P6', 'C', 6, '2006', 'Gamma');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2007.0, 1, 1, 'P7', 'G', 7, '2007', 'Delta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT college_other AS college FROM (SELECT LHS.college AS college, LHS.n AS n, RHS.college AS college_other, RHS.n AS n_other FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS LHS CROSS JOIN (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS RHS) WHERE (n < n_other) ORDER BY college;

/*
Gold Result:
('Alpha',)
('Beta',)
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 3;

/*
Prediction Result:
('Alpha',)
('Beta',)
('Delta',)
*/