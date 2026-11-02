-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Alice', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_c6c4a2', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_8c06b5', -1576219117, '5u', 'w6kl', 'a9');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_c6c4a2', 2087640001);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_c6c4a2', 907682809);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_c6c4a2', 2026480202);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('per_8c06b5', 'per_c6c4a2', 1620389964);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_8c06b5', 1419861592);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "personfriend" WHERE ("friend" = 'Alice') ORDER BY name, personfriend.friend NULLS LAST, personfriend.year NULLS LAST;

/*
Gold Result:
('per_8c06b5',)
('per_c6c4a2',)
('per_c6c4a2',)
('per_c6c4a2',)
*/

-- Prediction Query
SELECT name FROM PersonFriend WHERE friend = 'Alice' AND YEAR = (SELECT MIN(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('per_c6c4a2',)
*/