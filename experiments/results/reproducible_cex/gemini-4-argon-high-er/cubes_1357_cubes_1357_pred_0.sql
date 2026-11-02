-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 25, 'NY', 'F', 'Eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 26, 'NY', 'M', 'Eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 27, 'NY', 'M', 'Eng');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 1);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Charlie', 2);
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