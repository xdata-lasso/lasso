-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (1, 'MIT', 'Sally Kornbluth', 'United States');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (2, 'University of Toronto', 'Meric Gertler', 'Canada');
INSERT INTO "college" ("College_ID", "Name", "Leader_Name", "College_Location") VALUES (3, 'Oxford', 'Irene Tracey', 'United Kingdom');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (1, 1, 'Zack', 'United States');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (2, 2, 'Yasmin', 'Canada');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (3, 3, 'Xavier', 'France');
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (4, 1, 'William', NULL);
INSERT INTO "member" ("Member_ID", "College_ID", "Name", "Country") VALUES (5, 2, 'Alice', 'Mexico');
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 1, 'Modern', 1);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 2, 'Classic', 2);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 3, 'Rustic', 3);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 4, 'Minimalist', 4);
INSERT INTO "round" ("Round_ID", "Member_ID", "Decoration_Theme", "Rank_in_Round") VALUES (1, 5, 'Vintage', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "member" WHERE ("country" <> 'United States' OR "country" <> 'Canada') ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Xavier',)
('Yasmin',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM member WHERE Country = 'United States' OR Country = 'Canada';

/*
Prediction Result:
('Zack',)
('Yasmin',)
*/