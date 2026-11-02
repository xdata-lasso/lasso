-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -55602865, 1, '2025-06-13');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, -921145356, '2024-01-05');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, NULL, 1, '2022-12-08');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, -1981402255, '2023-04-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 247012447, 1, '2020-06-08');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, NULL, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -734455130, 1, '2020-09-26');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, -1633151678, '2021-07-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1914020640, 1, '2024-12-12');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1219478689, '2023-08-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT Q.AUTHOR_ID AS ID FROM (SELECT V1.AUTHOR_ID AS AUTHOR_ID, V1.ARTICLE_ID FROM VIEWS AS V1 INNER JOIN (SELECT VIEWER_ID, ARTICLE_ID FROM VIEWS) AS V2 ON V1.ARTICLE_ID = V2.ARTICLE_ID AND V1.AUTHOR_ID = V2.VIEWER_ID) AS Q ORDER BY ID;

/*
Prediction Result:
(1,)
*/