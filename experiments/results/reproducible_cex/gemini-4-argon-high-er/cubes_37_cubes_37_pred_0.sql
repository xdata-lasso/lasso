-- Schema DDL
CREATE TABLE "i055" ("ID" INTEGER, "User" TEXT, "Activity" TEXT, "PageURL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (1, 'Alice', 'Login', 'url1');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (2, 'Alice', 'Login', 'url2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "user", "activity", "concatpageurl" FROM (SELECT "activity", "user", GROUP_CONCAT("pageurl", ' ') AS concatpageurl FROM i055 GROUP BY activity, USER) ORDER BY USER, "user" NULLS LAST, "activity" NULLS LAST, "concatpageurl" NULLS LAST;

/*
Gold Result:
('Alice', 'Login', 'url1 url2')
*/

-- Prediction Query
SELECT User, Activity, PageURL FROM i055 GROUP BY User, Activity;

/*
Prediction Result:
('Alice', 'Login', 'url1')
*/