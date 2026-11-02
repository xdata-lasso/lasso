-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Victoria Wyatt', 1013, 'South Joshuastad', 'commercial', 'Metallurgist');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Bob', NULL, NULL, NULL, NULL);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'Victoria Wyatt', 1014);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Bob', 'Victoria Wyatt', 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "person" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "personfriend" WHERE ("friend" = 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Victoria Wyatt',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Bob';

/*
Prediction Result:
('Victoria Wyatt',)
('Victoria Wyatt',)
*/