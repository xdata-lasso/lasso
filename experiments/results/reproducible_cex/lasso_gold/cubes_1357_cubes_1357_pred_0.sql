-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 1023, 'Thomasberg', 'employee', 'Surveyor, mining');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Rebecca Henderson', NULL, NULL, NULL, NULL);
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Nicole Patterson', NULL, NULL, NULL, NULL);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'Rebecca Henderson', 1024);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'Nicole Patterson', 1025);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "personfriend" WHERE ("friend" = 'Alice') ORDER BY name, personfriend.friend NULLS LAST, personfriend.year NULLS LAST;

/*
Gold Result:
('Nicole Patterson',)
('Rebecca Henderson',)
*/

-- Prediction Query
SELECT name FROM PersonFriend WHERE friend = 'Alice' AND YEAR = (SELECT MIN(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('Rebecca Henderson',)
*/