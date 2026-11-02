-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate rows in projection (same Name and Country, different Member_ID) to kill mutants using SELECT DISTINCT or GROUP BY.
-- Also tests rows with NULL College_ID and members without round entries (kills INNER JOIN mutants).
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (1, 'Beta College', 'Dr. Jones', 'Boston');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 1, 'Charlie', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, NULL, 'Charlie', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 1, 'Anna', 'UK');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (101, 1, 'Modern', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country FROM member ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Anna', 'UK')
('Charlie', 'Canada')
('Charlie', 'Canada')
*/

-- Prediction Query
SELECT Name, Country FROM member;

/*
Prediction Result:
('Charlie', 'Canada')
('Charlie', 'Canada')
('Anna', 'UK')
*/