-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1020, 'Amy Underwood', 'michellejames@example.com', 1021, 1022);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1023, 'Dylan Miller', 'elizabethmiles@example.net', 1024, 1022);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1026, 'Colleen Nguyen', 'frankgray@example.net', 1027, 1023);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, followers FROM user_profiles ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
('Amy Underwood', 1022)
('Colleen Nguyen', 1023)
('Dylan Miller', 1022)
*/

-- Prediction Query
SELECT name, followers FROM user_profiles ORDER BY followers DESC, user_profiles.uid NULLS LAST;

/*
Prediction Result:
('Colleen Nguyen', 1023)
('Amy Underwood', 1022)
('Dylan Miller', 1022)
*/