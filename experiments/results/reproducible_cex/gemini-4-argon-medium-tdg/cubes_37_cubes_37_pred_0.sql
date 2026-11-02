-- Schema DDL
CREATE TABLE "i055" ("ID" INTEGER, "User" TEXT, "Activity" TEXT, "PageURL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (1, 'alice', 'login', 'http://a.com');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (2, 'alice', 'login', 'http://b.com');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (3, 'alice', 'view', 'http://c.com');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (4, 'bob', 'login', 'http://d.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "user", "activity", "concatpageurl" FROM (SELECT "activity", "user", GROUP_CONCAT("pageurl", ' ') AS concatpageurl FROM i055 GROUP BY activity, USER) ORDER BY USER, "user" NULLS LAST, "activity" NULLS LAST, "concatpageurl" NULLS LAST;

/*
Gold Result:
('alice', 'login', 'http://a.com http://b.com')
('alice', 'view', 'http://c.com')
('bob', 'login', 'http://d.com')
*/

-- Prediction Query
SELECT User, Activity, PageURL FROM i055 GROUP BY User, Activity;

/*
Prediction Result:
('alice', 'login', 'http://a.com')
('alice', 'view', 'http://c.com')
('bob', 'login', 'http://d.com')
*/