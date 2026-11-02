-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Alpha College', 'Dr. Smith', 'USA');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (2, 'Beta College', 'Dr. Jones', 'UK');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (10, 1, 'Charlie', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (20, 2, 'Alice', 'Australia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (5, 1, 'Alice', 'Austria');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (15, 2, 'Bob', 'Brazil');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (1, 10, 'Modern', 1);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (2, 10, 'Rustic', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country FROM member ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Alice', 'Austria')
('Alice', 'Australia')
('Bob', 'Brazil')
('Charlie', 'Canada')
*/

-- Prediction Query
SELECT Name, Country FROM member;

/*
Prediction Result:
('Alice', 'Austria')
('Charlie', 'Canada')
('Bob', 'Brazil')
('Alice', 'Australia')
*/