-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: user_profiles --
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'use_33f935', 'use_9266e7', 1, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483647, 'use_393b86', 'use_1c3ebe', 1, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483646, 'q_1_dc9068', 'use_dc6265', -55602865, -59984348);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483645, 'q_1_dc9068', 'use_dc6265', -664303813, -1022641847);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-1, 'A', 'use_dc6265', -1726781632, 247012447);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (0, '@', 'use_dc6265', -1980249628, -734455130);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM user_profiles ORDER BY name DESC, user_profiles.uid NULLS LAST) LIMIT 1);

/*
Gold Result:
('use_393b86',)
*/

-- Prediction Query
SELECT name FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/