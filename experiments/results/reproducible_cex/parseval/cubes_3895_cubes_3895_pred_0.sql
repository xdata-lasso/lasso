-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('G', 1, '5k5swwqcgs', '9n8', 't1__e52c1d');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 1610062532, 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', -1610064545, 'n', 'rmdp', 'siie');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('O', 1, 'w6kl', 'a9', 't1__e52c1d');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('t2__f9db98', 1, 'gce376nium52', 'zbuo4nrqrof', 't1__e52c1d');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('t1__eb4628', 1, 'ytoo3o9hl7', 'klex14ji', 't1__e52c1d');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('t2__b71e26', -453362185, 'au2dwyrq13', 'yu78', '9');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'G', -845863578);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'A', -45536098);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'O', 546571701);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'A', 947159877);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'A', 1408123494);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'A', -1964997180);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', -1031969798);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', -1106983592);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', 1884179925);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'O', -2070843029);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', 328305758);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', -751275471);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'Alice', -1068298341);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', -314162272);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', 2137741668);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__f9db98', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('t2__b71e26', 't1__eb4628', 244829661);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'Alice', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'Alice', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't1__eb4628', -904834265);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'O', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'G', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't1__eb4628', 1692174491);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'O', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't2__b71e26', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't1__eb4628', -1025564911);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'O', -975213201);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 't1__eb4628', -705985602);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age", "job" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "LHS"."friend" AS "friend", "LHS"."year" AS "year", "RHS"."maxyear" AS "maxyear" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) AS "LHS" INNER JOIN (SELECT "name", "year", MAX("year") AS "maxyear" FROM "personfriend" WHERE ("friend" = 'Alice') GROUP BY name, YEAR) AS RHS ON (LHS.name = RHS.name AND LHS.year = RHS.year)) ORDER BY name, "name" NULLS LAST, "age" NULLS LAST, "job" NULLS LAST;

/*
Gold Result:
('A', -1610064545, 'siie')
('A', -1610064545, 'siie')
('A', -1610064545, 'siie')
('A', -1610064545, 'siie')
('Alice', 1610062532, 'rwbbp6luhvd')
('G', 1, 't1__e52c1d')
('O', 1, 't1__e52c1d')
('O', 1, 't1__e52c1d')
('O', 1, 't1__e52c1d')
('t1__eb4628', 1, 't1__e52c1d')
('t1__eb4628', 1, 't1__e52c1d')
('t1__eb4628', 1, 't1__e52c1d')
('t1__eb4628', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
('t2__f9db98', 1, 't1__e52c1d')
*/

-- Prediction Query
SELECT T1.name, T1.age, T1.job FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice' AND T2.year = (SELECT MAX(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('t2__f9db98', 1, 't1__e52c1d')
*/