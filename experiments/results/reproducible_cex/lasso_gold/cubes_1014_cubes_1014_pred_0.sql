-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Carla Kelly', 'Texas', 1020.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Jonathan Wilkerson', 'Montana', 1026.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1021.5, 'Timothy Wong', 'politics', 1022.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1024.5, 'Margaret Hawkins DDS', 'threat', 1025.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1027.5, 'Daniel Hahn', 'under', 1028.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1021.5, 'Carla Kelly', 'prove', 'Congress');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1024.5, 'Carla Kelly', 'special', 'stand');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1027.5, 'Jonathan Wilkerson', 'serious', 'forward');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, cname FROM (SELECT cname, COUNT(*) AS n FROM tryout GROUP BY cname) ORDER BY count___, cname NULLS LAST;

/*
Gold Result:
(1, 'Jonathan Wilkerson')
(2, 'Carla Kelly')
*/

-- Prediction Query
SELECT COUNT(*), cName FROM tryout GROUP BY cName ORDER BY COUNT(*) DESC, cName NULLS LAST;

/*
Prediction Result:
(2, 'Carla Kelly')
(1, 'Jonathan Wilkerson')
*/