-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_badb97', 1, 'lhs_3ac33b', 'lhs_2c0cb6', 'lhs_195296');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_1fb659', 1, 'lhs_e1626b', 'lhs_838a5b', 'lhs_e38fdd');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Bob', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_7b762b', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_9bc784', 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_9bc784', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'per_7b762b', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "person" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "personfriend" WHERE ("friend" = 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('per_7b762b',)
('per_9bc784',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Bob';

/*
Prediction Result:
('per_7b762b',)
('per_9bc784',)
('per_7b762b',)
('per_7b762b',)
('per_7b762b',)
('per_7b762b',)
('per_7b762b',)
('per_7b762b',)
('per_7b762b',)
('per_7b762b',)
*/