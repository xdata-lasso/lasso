-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Alpha College', 'Dr. Smith', 'New York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (20, 'Beta College', 'Dr. Jones', 'Boston');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 10, 'Zack', 'USA');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 10, 'Alice', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 20, 'Bob', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, NULL, 'Charlie', 'Australia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (5, 20, 'Alice', 'USA');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 3, 'Retro', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 3, 'Modern', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM round AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM member WHERE NOT Member_ID IN (SELECT Member_ID FROM round);

/*
Prediction Result:
('Zack',)
('Alice',)
('Charlie',)
('Alice',)
*/