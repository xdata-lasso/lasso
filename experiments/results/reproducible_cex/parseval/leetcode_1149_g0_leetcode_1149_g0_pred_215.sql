-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, -55602865, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (4, -59984348, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (5, -664303813, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, -1022641847, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, -1726781632, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 247012447, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (4, -1980249628, 1, '2022-10-19');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 1871297066, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 809183447, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 89267185, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -1865039888, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1160656988, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, -992890117, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 1914020640, 1, '1924-04-03');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (4, 1268590800, 1, '1924-04-03');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (5, 1219478689, 1, '1924-04-01');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, -1670923962, 1, '1924-04-02');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 700293388, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (4, 906324270, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (5, 1908028688, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 2122220075, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, 1072996612, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (4, 13244799, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (5, -1659388584, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, 1526238907, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2, -1377057208, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (4, -841692980, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (5, -1364429300, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (3, -1257178728, 1, '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(1,)
*/

-- Prediction Query
SELECT A.VIEWER_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.VIEWER_ID = B.VIEWER_ID AND A.ARTICLE_ID <> B.ARTICLE_ID AND A.VIEW_DATE = B.VIEW_DATE GROUP BY A.VIEWER_ID HAVING COUNT(A.VIEWER_ID) > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(1,)
*/