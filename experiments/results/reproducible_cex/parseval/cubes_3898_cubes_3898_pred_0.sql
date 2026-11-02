-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_496d5d', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_320581', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_c1ae32', 1, 'per_c7bab1', 'per_676feb', 'per_db2ff6');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_5462e6', 1, 'per_429a99', 'per_9e4cbd', 'per_e09d37');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_424684', 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_42d492', -1585009206, '52zb', 'uo4nrqrofqy', '5s5b');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_59ee2c', 2107872094, '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_15d54b', 1178636309, 'ex1', 'ji7zwau2', 'dwyrq13pyu78');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('lhs_424684', 'lhs_42d492', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('lhs_59ee2c', 'lhs_15d54b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('lhs_424684', 'lhs_42d492', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('lhs_424684', 'lhs_42d492', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM personfriend AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT name, age, city, gender, job, AVG(age) OVER () AS meanage FROM person) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend DESC) LIMIT 1);

/*
Gold Result:
('lhs_59ee2c',)
*/

-- Prediction Query
SELECT DISTINCT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.age < (SELECT AVG(age) FROM person);

/*
Prediction Result:
*/