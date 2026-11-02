-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 30, 'Austin', 'M', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'Boston', 'F', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 28, 'Chicago', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Denver', 'M', 'Lawyer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Zach', 2022);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Zach', 2022);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Zach', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Zach', 'Alice', 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT "name", "friend", "year", MAX("year") OVER () AS "maxyear" FROM "personfriend") WHERE ("name" = 'Zach' AND maxyear = YEAR) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT friend FROM PersonFriend WHERE name = 'Zach' AND YEAR = (SELECT MAX(YEAR) FROM PersonFriend WHERE name = 'Zach');

/*
Prediction Result:
('Bob',)
('Alice',)
*/