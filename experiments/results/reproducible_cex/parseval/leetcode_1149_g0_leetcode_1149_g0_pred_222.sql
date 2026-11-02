-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 2, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 3, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 4, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, NULL, 1, '2021-11-08');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, NULL, 1, '2021-11-08');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, NULL, 1, '2021-11-08');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 3, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 2, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -59984348, -664303813, '2022-12-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID || AUTHOR_ID) > 1 ORDER BY 1 ASC, ID NULLS LAST;

/*
Prediction Result:
(1,)
*/