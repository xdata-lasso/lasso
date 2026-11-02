-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (10, NULL, 'Canada15', 'United States14');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (9, NULL, 'Canada9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "member" WHERE ("country" <> 'United States' OR "country" <> 'Canada') ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Canada15',)
*/

-- Prediction Query
SELECT Name FROM member WHERE Country = 'United States' OR Country = 'Canada';

/*
Prediction Result:
*/