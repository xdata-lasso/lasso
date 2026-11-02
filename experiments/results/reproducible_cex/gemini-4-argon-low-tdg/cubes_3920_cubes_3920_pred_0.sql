-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, DISTINCT requirement, and ORDER BY college vs ORDER BY count.
-- Counts: Duke (1), Stanford (2), UCLA (2), MIT (3), Harvard (4).
-- Minimum count is 1 (Duke). Expected result: Harvard, MIT, Stanford, UCLA (in alphabetical order).
-- Notice that alphabetical order (Harvard, MIT, Stanford, UCLA) differs from count order (Stanford/UCLA: 2, MIT: 3, Harvard: 4).
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Lakers');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 1, 1, 'P1', 'G', 1, '2001', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 1, 1, 'P2', 'G', 2, '2002', 'Stanford');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 1, 1, 'P3', 'F', 3, '2003', 'Stanford');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 1, 1, 'P4', 'F', 4, '2004', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2005.0, 1, 1, 'P5', 'C', 5, '2005', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2006.0, 1, 1, 'P6', 'C', 6, '2006', 'MIT');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2007.0, 1, 1, 'P7', 'G', 7, '2007', 'MIT');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2008.0, 1, 1, 'P8', 'F', 8, '2008', 'MIT');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2009.0, 1, 1, 'P9', 'C', 9, '2009', 'Harvard');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2010.0, 1, 1, 'P10', 'G', 10, '2010', 'Harvard');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2011.0, 1, 1, 'P11', 'F', 11, '2011', 'Harvard');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2012.0, 1, 1, 'P12', 'C', 12, '2012', 'Harvard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT college_other AS college FROM (SELECT LHS.college AS college, LHS.n AS n, RHS.college AS college_other, RHS.n AS n_other FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS LHS CROSS JOIN (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS RHS) WHERE (n < n_other) ORDER BY college;

/*
Gold Result:
('Harvard',)
('MIT',)
('Stanford',)
('UCLA',)
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 3;

/*
Prediction Result:
('Harvard',)
('MIT',)
('Stanford',)
*/