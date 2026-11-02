-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'New York', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'Boston', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Chicago', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 28, 'Seattle', 'M', 'Lawyer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 22, 'Austin', 'F', 'Student');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'David', 2010);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Charlie', NULL);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Eve', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "personfriend" WHERE ("friend" = 'Alice') ORDER BY name, personfriend.friend NULLS LAST, personfriend.year NULLS LAST;

/*
Gold Result:
('Bob',)
('Charlie',)
('David',)
*/

-- Prediction Query
SELECT name FROM PersonFriend WHERE friend = 'Alice' AND YEAR = (SELECT MIN(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('David',)
*/