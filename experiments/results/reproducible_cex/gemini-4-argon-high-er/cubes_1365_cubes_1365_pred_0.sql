-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zach', 25, 'NYC', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'LA', 'F', 'Doctor');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Zach', 2010);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Zach', 'Alice', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT "name", "friend", "year", MAX("year") OVER () AS "maxyear" FROM "personfriend") WHERE ("name" = 'Zach' AND maxyear = YEAR) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT friend FROM PersonFriend WHERE name = 'Zach' AND YEAR = (SELECT MAX(YEAR) FROM PersonFriend WHERE name = 'Zach');

/*
Prediction Result:
('Alice',)
*/