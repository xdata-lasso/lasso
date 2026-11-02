-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 1020, 'Teresaburgh', 'movement', 'Claims inspector/assessor');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('truth', NULL, NULL, NULL, NULL);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('truth', 'Zach', 0);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES (NULL, 'Zach', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT "name", "friend", "year", MAX("year") OVER () AS "maxyear" FROM "personfriend") WHERE ("name" = 'Zach' AND maxyear = YEAR) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
(None,)
('truth',)
*/

-- Prediction Query
SELECT friend FROM PersonFriend WHERE name = 'Zach' AND YEAR = (SELECT MAX(YEAR) FROM PersonFriend WHERE name = 'Zach');

/*
Prediction Result:
('truth',)
(None,)
*/