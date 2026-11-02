-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Allison Hill', 1001, 'New Jamesside', 'fall', 'Legal secretary');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Noah Rhodes', 1006.0, 'Robinsonshire', 'clearly', 'Civil engineer, consulting');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Angie Henderson', 1011.0, 'Lisatown', 'dinner', 'Chief Executive Officer');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Daniel Wagner', 1016.0, 'Lake Roberto', 'source', 'Museum/gallery conservator');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('bill', NULL, NULL, NULL, NULL);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('bill', 'Allison Hill', 1005);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('bill', 'Allison Hill', 1012.0);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('bill', 'Allison Hill', 1019.0);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('bill', 'Allison Hill', 1026.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM personfriend AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT name, age, city, gender, job, AVG(age) OVER () AS meanage FROM person) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend DESC) LIMIT 1);

/*
Gold Result:
('bill',)
*/

-- Prediction Query
SELECT DISTINCT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.age < (SELECT AVG(age) FROM person);

/*
Prediction Result:
*/