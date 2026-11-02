-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'New York', 'Female', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'Boston', 'Male', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 22, 'Chicago', 'Male', 'Student');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 35, 'Seattle', 'Male', 'Teacher');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Charlie', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('David', 'Charlie', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "personfriend" WHERE ("friend" = 'Alice') ORDER BY name, personfriend.friend NULLS LAST, personfriend.year NULLS LAST;

/*
Gold Result:
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM PersonFriend WHERE friend = 'Alice' AND YEAR = (SELECT MIN(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('Bob',)
*/