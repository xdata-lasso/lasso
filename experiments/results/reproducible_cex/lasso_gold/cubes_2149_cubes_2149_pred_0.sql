-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1006, 'Dr. Sharon James', 'Roy Martin', '192 Frank Light Suite 835
East Lydiamouth, MO 35594');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1008, 'Matthew Foster', 'Judy Baker', '969 Cox Dam Suite 101
Lake Ernest, TX 55834');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1007, 1006, 'Tricia Valencia', 'Lao People''s Democratic Republic');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1009, 1008, 'Thomas Bradley', 'Saint Barthelemy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country FROM member ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
('Thomas Bradley', 'Saint Barthelemy')
('Tricia Valencia', "Lao People's Democratic Republic")
*/

-- Prediction Query
SELECT Name, Country FROM member;

/*
Prediction Result:
('Tricia Valencia', "Lao People's Democratic Republic")
('Thomas Bradley', 'Saint Barthelemy')
*/