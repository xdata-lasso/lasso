-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'pos_753e34', 'nprmdposii', -1823627488, -1209887326, -1399556171, -2147483648, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1313172851, -761141909, '2024-10-24 14:16:53+00:00', -53231346, -443340271, 'uo4nrqrofqy', -2147483648, '2022-01-22 16:14:13+00:00', 'pos_753e34', 's5bbp02e', -751275471, -1347802441, 1673584235, -2147483648, '2020-01-22 05:30:29+00:00', '2023-08-20 20:02:04+00:00', 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', 'l7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2123196517, 364869063, '2022-05-13 17:57:39+00:00', -1021749117, 392822403, 'yu78', -2147483648, '2020-06-02 21:50:32+00:00', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, -461695645, -2147483648, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1454058168, -2078052421, '2021-07-02 01:45:48+00:00', 982314585, 638024588, '6vck6ah0f8js', -2147483648, '2022-12-13 04:17:12+00:00', 'lq7xb7', '2fxa7ryfdrz', 61479715, -1496556994, -2115841792, -2147483648, '2024-03-27 22:48:03+00:00', '2020-07-12 19:51:25+00:00', -1625552518, '2021-12-10 17:04:01+00:00', 'rg', 'd8y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 804529642, -1538707438, '2023-12-06 02:24:58+00:00', 1476361420, 195720193, 'vacx7afu5', -2147483648, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, -2147483648, '2024-03-11 08:01:44+00:00', '2025-11-17 07:39:50+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 944975670, -1575410149, '2024-05-05 04:13:50+00:00', 1944978593, 1722106924, 'f', -2147483648, '2021-05-31 16:00:51+00:00', 'oa', 'cd07z2zezjo7', 304189298, -542502665, 1999335832, -2147483648, '2023-03-18 12:07:22+00:00', '2022-06-10 06:35:27+00:00', -546516406, '2021-08-06 04:52:45+00:00', '0oztd', 'j5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1615073310, 1055237066, '2023-11-07 06:34:01+00:00', 1497321728, -95808609, 'h2mna', -2147483648, '2021-03-26 16:58:48+00:00', 'la3', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -2147483648, '2023-05-05 20:15:58+00:00', '2024-06-27 07:12:45+00:00', 448935289, '2023-04-29 21:53:50+00:00', 'be8yvkv42q7', 'x58b4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -1140595602, -609553675, '2022-12-09 16:13:13+00:00', -55494714, -1674145149, 'mo705a9n0', -2147483648, '2021-04-02 17:49:19+00:00', 'fofwsz', 'o', 1010672881, -1197954156, -2019656607, -2147483648, '2022-03-19 07:41:34+00:00', '2025-04-29 20:31:18+00:00', -366775518, '2023-11-21 15:04:11+00:00', '2odwcl5amso', 'lwyng');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -477129795, -1418927432, '2025-06-29 01:47:27+00:00', -30041412, -277407746, 'nlas6e', -2147483648, '2025-09-08 01:16:35+00:00', 'boe', 'wii1', -457369423, 1557188093, 548968280, -2147483648, '2021-03-06 10:06:33+00:00', '2021-01-02 12:34:35+00:00', 7342822, '2022-03-16 10:43:12+00:00', 'xlyotow9', 'aawg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 748154000, 1148916014, '2020-04-24 22:41:34+00:00', -1694533100, -1275298282, '3', -2147483648, '2025-03-26 09:37:26+00:00', 'tdu6bd0w96', '3vzxw1r', 237552112, -1046720861, 643589729, -2147483648, '2021-10-24 14:42:01+00:00', '2020-12-13 20:46:34+00:00', 956819642, '2025-10-15 00:12:43+00:00', 'y3dohvu0', 'dza35rmki');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: postlinks --
INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483648, '2021-05-27 14:39:41+00:00', 2, 1, -1390245819);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483647, '2023-08-25 07:55:29+00:00', 2, 1, -74849714);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483646, '2023-01-02 20:56:29+00:00', 4, 2, -2050247126);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483645, '2020-12-31 11:15:26+00:00', 4, 2, -261132974);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483644, '2022-12-08 23:34:02+00:00', 4, 1, -1245682094);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (2, '2024-03-04 00:31:03+00:00', 1, 4, 580968159);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (3, '2020-05-10 07:36:02+00:00', 1, 2, 1575412235);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483641, '2021-10-07 12:15:00+00:00', 1, 4, -211209314);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (4, '2024-06-15 00:00:00+00:00', 1, 3, 1250290042);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (5, '2024-06-15 00:00:00+00:00', 2, 1, -1696173285);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (6, '2024-06-15 00:00:00+00:00', 3, 1, -902895762);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (7, '2024-06-15 00:00:00+00:00', 3, 2, 2111987706);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (8, '2024-06-15 00:00:00+00:00', 1, 5, 199672698);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (9, '2024-06-15 00:00:00+00:00', 3, 5, 2004147439);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (10, '2024-06-15 00:00:00+00:00', 5, 4, -866772222);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (11, '2024-06-15 00:00:00+00:00', 1, 4, 453836040);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (12, '2024-06-15 00:00:00+00:00', 1, 1, -176606723);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (13, '2024-06-15 00:00:00+00:00', 4, 6, 1816660482);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (14, '2024-06-15 00:00:00+00:00', 6, 1, 1339733032);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (15, '2024-06-15 00:00:00+00:00', 1, 1, -1300180872);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (16, '2024-06-15 00:00:00+00:00', 1, 6, 681598285);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (17, '2024-06-15 00:00:00+00:00', 1, 7, 1849819405);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (18, '2024-06-15 00:00:00+00:00', 7, 6, 319284352);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (19, '2024-06-15 00:00:00+00:00', 7, 4, -200807520);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (20, '2024-06-15 00:00:00+00:00', 1, 2, -323362455);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (21, '2024-06-15 00:00:00+00:00', 4, 1, -413043724);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (22, '2024-06-15 00:00:00+00:00', 8, 4, 1504707292);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (23, '2024-06-15 00:00:00+00:00', 7, 3, -360096930);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (24, '2024-06-15 00:00:00+00:00', 1, 9, -1048779857);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (25, '2024-06-15 00:00:00+00:00', 7, 5, 868039568);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (26, '2024-06-15 00:00:00+00:00', 9, 3, -1897615568);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (27, '2024-06-15 00:00:00+00:00', 8, 9, 2085299664);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (28, '2024-06-15 00:00:00+00:00', 1, 3, 150596046);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (29, '2024-06-15 00:00:00+00:00', 10, 4, 1510892261);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (30, '2024-06-15 00:00:00+00:00', 10, 1, 389700824);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (31, '2024-06-15 00:00:00+00:00', 7, 10, 168442149);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title FROM posts AS T1 INNER JOIN postLinks AS T2 ON T2.PostId = T1.Id ORDER BY T1.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('tdu6bd0w96',)
*/

-- Prediction Query
SELECT "posts"."title" FROM "posts" INNER JOIN "postlinks" ON "posts"."id" = "postlinks"."postid" WHERE "postlinks"."creationdate" = (SELECT MIN("creationdate") FROM "postlinks");

/*
Prediction Result:
('pos_753e34',)
*/