-- Schema DDL
CREATE TABLE "i055" ("ID" INTEGER, "User" TEXT, "Activity" TEXT, "PageURL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1002, 'Daniel Wagner', 'agreement', 'http://cole.com/');
INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1003, 'Caitlin Henderson', 'fall', NULL);
INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1004, 'Caitlin Henderson', 'fall', 'https://blair.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "user", "activity", "concatpageurl" FROM (SELECT "activity", "user", GROUP_CONCAT("pageurl", ' ') AS concatpageurl FROM i055 GROUP BY activity, USER) ORDER BY USER, "user" NULLS LAST, "activity" NULLS LAST, "concatpageurl" NULLS LAST;

/*
Gold Result:
('Caitlin Henderson', 'fall', 'https://blair.com/')
('Daniel Wagner', 'agreement', 'http://cole.com/')
*/

-- Prediction Query
SELECT User, Activity, PageURL FROM i055 GROUP BY User, Activity;

/*
Prediction Result:
('Caitlin Henderson', 'fall', None)
('Daniel Wagner', 'agreement', 'http://cole.com/')
*/