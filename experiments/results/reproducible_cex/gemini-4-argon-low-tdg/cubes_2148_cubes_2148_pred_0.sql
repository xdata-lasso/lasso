-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'College_Alpha', 'Leader_A', 'Loc_A');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'College_Beta', 'Leader_B', 'Loc_B');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 1, 'Zack', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (20, 1, 'Alice', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (30, 2, 'Alice', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (40, NULL, 'Bob', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (50, 2, 'Charlie', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (60, 1, 'David', 'Canada');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 50, 'Theme_X', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 50, 'Theme_Y', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (10, 60, 'Theme_Z', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM round AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM member WHERE NOT Member_ID IN (SELECT Member_ID FROM round);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
('Bob',)
*/