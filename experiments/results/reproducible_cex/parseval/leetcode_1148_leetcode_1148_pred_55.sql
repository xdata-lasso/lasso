-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-55602865, 1, -59984348, '2023-11-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1258409369, '2020-06-07');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -1726781632, 1, '2021-12-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1610062532, 1, -106629402, '2021-02-11');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (809183447, 1, 89267185, '2020-12-20');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1744686505, '2025-06-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1160656988, '2023-01-06');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -252690330, 1, '2022-09-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -1670923962, 1, '2023-01-03');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (906324270, NULL, 1908028688, '2020-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1072996612, '2025-08-22');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, NULL, 1, '2022-01-31');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT ID FROM (SELECT A.AUTHOR_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.AUTHOR_ID = B.VIEWER_ID AND A.ARTICLE_ID = B.ARTICLE_ID) AS ID GROUP BY ID ORDER BY ID ASC;

/*
Prediction Result:
(1,)
*/