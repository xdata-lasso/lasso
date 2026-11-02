-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, NULL, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, NULL, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.VIEWER_ID AS ID FROM (SELECT DISTINCT * FROM VIEWS) AS T1 GROUP BY T1.VIEWER_ID HAVING COUNT(DISTINCT T1.VIEW_DATE) <> COUNT(T1.VIEW_DATE) ORDER BY T1.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(1,)
*/