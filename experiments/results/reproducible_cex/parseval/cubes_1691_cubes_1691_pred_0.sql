-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, '9n8', 1610062532, 'pgu7vfe4');

-- Inserting into table: reviewer --
INSERT INTO "reviewer" ("rid", "name") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: rating --
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 1160656988, '2023-01-06');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 1914020640, '2024-12-12');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 1115440883, '2024-06-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, -1349201381, '2021-04-10');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 1526238907, '2022-01-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, -841692980, '2022-01-16');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-04-29');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2023-01-01');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2020-07-11');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-07-21');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2021-06-28');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2020-11-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 1861536320, '2023-11-17');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2020-12-06');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2024-09-12');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2025-07-01');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2025-04-12');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2020-06-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2021-03-18');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2020-10-26');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2025-10-19');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2021-06-20');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-02-24');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2025-01-28');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2020-03-30');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-07-11');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-04-13');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-10-25');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-06-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-11-29');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, NULL, '2022-09-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mid, meanstars AS avg_stars_ FROM (SELECT mid, meanstars, COUNT(*) OVER () AS n FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) WHERE (meanstars >= 2.0 AND meanstars <= n) ORDER BY mid, avg_stars_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT mID, AVG(stars) FROM Rating GROUP BY mID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(1, 769571339.5714285)
*/