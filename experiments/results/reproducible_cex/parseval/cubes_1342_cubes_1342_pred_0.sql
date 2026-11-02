-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_6eb15d', 30, 'per_34d1b6', 'per_c0b7ab', 'per_26437e');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_b4a108', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_bc3a76', 30, 'per_224297', 'per_51425c', 'per_88b099');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_dbcae0', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_dbcae0', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_b4a108', 'per_6eb15d', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.friend AS friend, RHS.year AS YEAR FROM (SELECT * FROM person WHERE (age < 40 AND age <= 30)) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_b4a108',)
('rhs_dbcae0',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age > 40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age < 30);

/*
Prediction Result:
*/