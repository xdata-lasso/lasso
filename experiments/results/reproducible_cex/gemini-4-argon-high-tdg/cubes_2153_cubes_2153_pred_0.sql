-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (10, 'Alpha College', 'Dr. Smith', 'New York');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (20, 'Beta College', 'Dr. Jones', 'London');
INSERT INTO college (College_ID, Name, Leader_Name, College_Location) VALUES (30, 'Gamma College', 'Dr. Brown', 'Tokyo');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (1, 10, 'Alice', 'Zambia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (2, 10, 'Bob', 'Zambia');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (3, 20, 'Charlie', 'Canada');
INSERT INTO member (Member_ID, College_ID, Name, Country) VALUES (4, NULL, 'David', 'Brazil');
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (100, 1, 'Modern', 2);
INSERT INTO round (Round_ID, Member_ID, Decoration_Theme, Rank_in_Round) VALUES (100, 2, 'Classic', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.name AS name_other, RHS.country AS country_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id AND LHS.member_id = RHS.member_id)) ORDER BY country;

/*
Gold Result:
('Canada',)
('Zambia',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country HAVING COUNT(*) > 2;

/*
Prediction Result:
*/