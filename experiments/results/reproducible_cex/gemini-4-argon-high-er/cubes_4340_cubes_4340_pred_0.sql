-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (1, 'C1', 'Alice', 'CityA', NULL);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (2, 'C2', 'Bob', 'CityB', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LEVEL FROM (SELECT * FROM (SELECT * FROM (SELECT LEVEL, MAX(n) AS maxn FROM (SELECT LEVEL, COUNT(*) AS n FROM member GROUP BY LEVEL) GROUP BY LEVEL) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY COUNT(*) DESC, LEVEL NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/