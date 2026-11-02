-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Oakridge College', 'Dr. Smith', 'Boston');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Pinecrest Institute', 'Dr. Jones', 'Seattle');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Maplewood University', 'Dr. Brown', 'Austin');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 10, 'Zoe', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 1, 'Charlie', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 2, 'Alice', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (100, 2, 'Bob', 'Australia');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (100, 1, 'Rustic', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (101, 1, 'Modern', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM round AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM member WHERE NOT Member_ID IN (SELECT Member_ID FROM round);

/*
Prediction Result:
('Charlie',)
('Alice',)
('Bob',)
*/