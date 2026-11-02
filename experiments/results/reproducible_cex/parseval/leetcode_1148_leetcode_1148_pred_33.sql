-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-55602865, 1, -59984348, '2023-11-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1258409369, 1, -1981402255, '2023-04-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 247012447, '2020-06-08');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, -106629402, '2021-02-11');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 809183447, 1, '2025-11-03');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -734455130, 1, '2020-09-26');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1633151678, 1, -252690330, '2022-09-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1670923962, 1, 700293388, '2023-11-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 2, 1908028688, '2020-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 2, 1072996612, '2025-08-22');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -1349201381, 3, '2021-04-10');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -1910425938, 4, '2023-05-26');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-841692980, 1, -1364429300, '2022-04-29');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (462974032, 1, -1137908826, '2023-03-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 1, -1576219117, '2020-11-04');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 1, -45536098, '2022-06-13');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 44952191, 1, '2021-12-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 1620389964, 1, '2024-09-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A1.AUTHOR_ID AS ID FROM VIEWS AS A1 CROSS JOIN VIEWS AS A2 WHERE A1.AUTHOR_ID = A2.VIEWER_ID AND A1.ARTICLE_ID = A2.ARTICLE_ID ORDER BY A1.AUTHOR_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(1,)
*/