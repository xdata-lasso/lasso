-- Schema DDL
CREATE TABLE "i055" ("ID" INTEGER, "User" TEXT, "Activity" TEXT, "PageURL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (1, 'Alice', 'Login', '/home');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (2, 'Alice', 'Login', '/dashboard');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (3, 'Alice', 'Logout', '/exit');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (4, 'Bob', 'Login', '/home');
INSERT INTO "i055" ("ID", "User", "Activity", "PageURL") VALUES (5, 'Bob', 'View', '/profile');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "user", "activity", "concatpageurl" FROM (SELECT "activity", "user", GROUP_CONCAT("pageurl", ' ') AS concatpageurl FROM i055 GROUP BY activity, USER) ORDER BY USER, "user" NULLS LAST, "activity" NULLS LAST, "concatpageurl" NULLS LAST;

/*
Gold Result:
('Alice', 'Login', '/home /dashboard')
('Alice', 'Logout', '/exit')
('Bob', 'Login', '/home')
('Bob', 'View', '/profile')
*/

-- Prediction Query
SELECT User, Activity, PageURL FROM i055 GROUP BY User, Activity;

/*
Prediction Result:
('Alice', 'Login', '/home')
('Alice', 'Logout', '/exit')
('Bob', 'Login', '/home')
('Bob', 'View', '/profile')
*/