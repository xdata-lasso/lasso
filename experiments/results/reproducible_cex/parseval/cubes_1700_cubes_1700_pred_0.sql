-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (2, 'mov_15ddca', -55602865, 'swwqcgsk');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (3, 'mov_15ddca', 1610062532, 'pgu7vfe4');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, 't2__a020ff', 1160656988, 'ia2yp');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483645, 't2__a020ff', 906324270, 'b');

-- Inserting into table: reviewer --
INSERT INTO "reviewer" ("rid", "name") VALUES (1, 'Chris Jackson');

INSERT INTO "reviewer" ("rid", "name") VALUES (-2147483647, 'Chris Jackson');

INSERT INTO "reviewer" ("rid", "name") VALUES (2, 'Chris Jackson');

INSERT INTO "reviewer" ("rid", "name") VALUES (3, 'ilbnp');

-- Inserting into table: rating --
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1670923962, '2023-01-03');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1072996612, '2025-08-22');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1349201381, '2021-04-10');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 3, -1910425938, '2023-05-26');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (3, 1, 1236688122, '2022-02-26');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 3, 907682809, '2022-07-21');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (3, 1, -918961358, '2021-06-03');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 3, -1823627488, '2023-09-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (3, 1, 1861536320, '2023-11-17');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 3, -1399556171, '2020-01-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (3, 1, 1419861592, '2025-04-12');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 374105386, '2020-06-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1683203397, '2020-10-26');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1585009206, '2022-02-24');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 283598170, '2025-01-28');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -443340271, '2023-08-27');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1179823637, '2022-04-13');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 781505063, '2023-01-30');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1031969798, '2022-09-19');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -921187550, '2020-03-14');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 2107872094, '2024-08-27');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 743312762, '2020-11-05');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -751275471, '2022-02-01');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1068298341, '2024-10-16');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 2074205376, '2023-01-29');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 2137741668, '2024-03-26');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -188151580, '2021-04-03');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 90119032, '2021-11-06');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, -1390245819, '2024-03-14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM "movie" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."rid" AS "rid", "LHS"."mid" AS "mid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM "rating" AS "LHS" LEFT JOIN "reviewer" AS "RHS" ON ("LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Chris Jackson')) AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('mov_15ddca',)
('t2__a020ff',)
*/

-- Prediction Query
SELECT DISTINCT title FROM Movie EXCEPT SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Chris Jackson';

/*
Prediction Result:
*/