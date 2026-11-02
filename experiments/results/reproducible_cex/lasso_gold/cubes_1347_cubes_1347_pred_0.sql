-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 1019, 'Michaelview', 'science', 'Building surveyor');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('politics', NULL, NULL, NULL, NULL);
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('hundred', NULL, NULL, NULL, NULL);
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('threat', NULL, NULL, NULL, NULL);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('politics', 'Bob', 1020);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('hundred', 'Bob', 1022);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('threat', 'Bob', 1024);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT * FROM "personfriend" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "person" WHERE ("name" <> 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
('hundred',)
('politics',)
('threat',)
*/

-- Prediction Query
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T1.name = 'Bob';

/*
Prediction Result:
('politics',)
('hundred',)
('threat',)
*/