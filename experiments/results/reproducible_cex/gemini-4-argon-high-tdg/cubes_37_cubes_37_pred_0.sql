-- Schema DDL
CREATE TABLE "i055" ("ID" INTEGER, "User" TEXT, "Activity" TEXT, "PageURL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (1, 'charlie', 'login', 'https://site.com/login');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (2, 'alice', 'view', 'https://site.com/home');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (3, 'alice', 'view', 'https://site.com/profile');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (4, 'alice', 'edit', 'https://site.com/settings');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (5, 'bob', 'view', 'https://site.com/home');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (6, 'bob', 'login', 'https://site.com/login');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (7, 'bob', 'login', 'https://site.com/auth');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "user", "activity", "concatpageurl" FROM (SELECT "activity", "user", GROUP_CONCAT("pageurl", ' ') AS concatpageurl FROM i055 GROUP BY activity, USER) ORDER BY USER, "user" NULLS LAST, "activity" NULLS LAST, "concatpageurl" NULLS LAST;

/*
Gold Result:
('alice', 'edit', 'https://site.com/settings')
('alice', 'view', 'https://site.com/home https://site.com/profile')
('bob', 'login', 'https://site.com/login https://site.com/auth')
('bob', 'view', 'https://site.com/home')
('charlie', 'login', 'https://site.com/login')
*/

-- Prediction Query
SELECT User, Activity, PageURL FROM i055 GROUP BY User, Activity;

/*
Prediction Result:
('alice', 'edit', 'https://site.com/settings')
('alice', 'view', 'https://site.com/home')
('bob', 'login', 'https://site.com/login')
('bob', 'view', 'https://site.com/home')
('charlie', 'login', 'https://site.com/login')
*/