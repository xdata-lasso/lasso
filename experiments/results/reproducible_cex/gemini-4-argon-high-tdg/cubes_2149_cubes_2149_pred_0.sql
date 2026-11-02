-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Oakridge', 'Dr. Smith', 'New York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (20, 'Pinecrest', 'Dr. Jones', 'Chicago');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (30, 'Mapleleaf', 'Dr. Adams', 'Seattle');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 10, 'Charlie', 'Australia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 30, 'Bob', 'Brazil');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, 20, 'Alice', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 30, 'Alice', 'Denmark');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (5, 10, 'Bob', 'Brazil');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 1, 'Spring', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country FROM member ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Alice', 'Denmark')
('Alice', 'Canada')
('Bob', 'Brazil')
('Bob', 'Brazil')
('Charlie', 'Australia')
*/

-- Prediction Query
SELECT Name, Country FROM member;

/*
Prediction Result:
('Bob', 'Brazil')
('Alice', 'Denmark')
('Charlie', 'Australia')
('Alice', 'Canada')
('Bob', 'Brazil')
*/