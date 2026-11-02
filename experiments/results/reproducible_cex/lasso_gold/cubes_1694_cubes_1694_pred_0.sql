-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1050, 'Estate agent', 1053, 'top');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1051, 'Horticultural consultant', 1060.0, 'early');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1052, 'Cartographer', 1067.0, 'trial');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1062, 'Transport planner', 1065, 'shoulder');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1063, 'Dramatherapist', 1072.0, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1064, 'Social research officer, government', 1079.0, 'common');
INSERT INTO "reviewer" ("rid", "name") VALUES (1056, 'Donald Reid');
INSERT INTO "reviewer" ("rid", "name") VALUES (1057, 'Jacob Clark');
INSERT INTO "reviewer" ("rid", "name") VALUES (1058, 'Timothy Wong');
INSERT INTO "reviewer" ("rid", "name") VALUES (1068, 'Devin Schaefer');
INSERT INTO "reviewer" ("rid", "name") VALUES (1069, 'Colleen Nguyen');
INSERT INTO "reviewer" ("rid", "name") VALUES (1070, 'Amy Underwood');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1056, 1050, 1059, '1982-02-13');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1056, 1050, 1066.0, '1982-02-14');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1056, 1050, 1073.0, '1982-02-15');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1068, 1062, 1071, '1985-05-16');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1068, 1062, 1078.0, '1985-05-17');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1068, 1062, 1085.0, '1985-05-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.n AS n FROM reviewer AS LHS INNER JOIN (SELECT * FROM (SELECT rid, COUNT(*) AS n FROM rating GROUP BY rid) WHERE (n = 3)) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
('Devin Schaefer',)
('Donald Reid',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T1.rID HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Donald Reid',)
('Devin Schaefer',)
*/