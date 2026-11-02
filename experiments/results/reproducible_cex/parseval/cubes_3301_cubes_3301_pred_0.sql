-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: user_profiles --
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'use_ec781b', 'use_e72816', -55602865, 1000);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483647, 'use_ec781b', 'use_e72816', -59984348, 1000);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'use_9bbfbd', 'use_dc6265', -664303813, 999);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 'use_9bbfbd', 'use_dc6265', -1022641847, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, NULL, 'use_dc6265', -1726781632, 1000);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (5, 'use_9bbfbd', NULL, 247012447, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM user_profiles WHERE (followers >= 1000) ORDER BY name, user_profiles.uid NULLS LAST;

/*
Gold Result:
(None, 'use_dc6265')
('use_9bbfbd', None)
('use_ec781b', 'use_e72816')
('use_ec781b', 'use_e72816')
*/

-- Prediction Query
SELECT name, email FROM user_profiles WHERE followers > 1000;

/*
Prediction Result:
*/