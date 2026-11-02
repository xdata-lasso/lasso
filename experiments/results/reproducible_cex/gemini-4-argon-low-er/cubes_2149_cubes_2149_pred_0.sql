-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (1, 'College A', 'Leader A', 'Location A');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (1, 1, 'Zack', 'USA');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (2, 1, 'Alice', 'UK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country FROM member ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Alice', 'UK')
('Zack', 'USA')
*/

-- Prediction Query
SELECT Name, Country FROM member;

/*
Prediction Result:
('Zack', 'USA')
('Alice', 'UK')
*/