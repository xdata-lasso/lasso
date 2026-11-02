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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 2, 1861536320, 44952191, -2147483648, '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00', 1038707349, '2024-12-31 04:19:17+00:00', '000t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -53231346, -443340271, '2025-10-02 08:51:14+00:00', -747753377, 902887186, 'qrofqyp5s5b', -2147483648, '2020-03-11 14:09:37+00:00', '02eu', 'liqa1', 2, 2074205376, 274769912, -2147483648, '2022-07-23 18:54:52+00:00', '2025-09-09 06:56:52+00:00', -188151580, '2024-09-13 14:36:04+00:00', 'l7', 'klex14ji');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 481163439, 2123196517, '2025-11-10 22:24:59+00:00', 1909986641, 1485335077, 'yrq13pyu78d9', -2147483648, '2024-09-26 13:13:01+00:00', 'ljsl0', '4', 1649269347, -1116181514, 1255852738, -2147483648, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', -2147483648, '2020-09-25 19:25:33+00:00', '4h', 'ia2yp', 2, -1670923962, 700293388, -2147483648, '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00', 2122220075, '2022-01-03 02:42:55+00:00', 'luhvdltti', 'bnp');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1137908826, -918961358, '2021-01-29 03:06:29+00:00', -1823627488, -1209887326, 'klfa9000t', -2147483648, '2024-03-03 15:52:53+00:00', '4', 'ecigce376n', 3, 1313172851, -761141909, -2147483648, '2024-10-24 14:16:53+00:00', '2024-02-23 22:32:48+00:00', 742285925, '2020-03-09 02:18:16+00:00', 'uo4nrqrofqy', '5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1347802441, 1673584235, '2020-01-22 05:30:29+00:00', -314162272, 2137741668, 'ytoo3o9hl7', -2147483648, '2023-10-09 18:36:37+00:00', 'lex', '4ji7zwa', 3, 2123196517, 364869063, -2147483648, '2022-05-13 17:57:39+00:00', '2022-03-25 08:00:08+00:00', -1097120355, '2022-10-12 16:19:32+00:00', '8d99rljsl', 'b4yp5qi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 556727997, 1178000634, '2024-08-09 01:13:45+00:00', 537874887, -461695645, 'f8jegd21vy9u', -2147483648, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc', 3, 555413010, 722884590, -2147483648, '2025-05-27 16:57:17+00:00', '2020-12-18 09:02:22+00:00', -1245312912, '2022-01-23 03:13:33+00:00', 'jtu0d', '79fjgq8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', NULL, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', NULL, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', NULL, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: postlinks --
INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (1, '2010-01-01 00:00:00+00:00', 1, 1, 1155439218);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483647, '2010-01-01 00:00:00+00:00', 1, 1, 1968874827);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483646, '2010-01-01 00:00:00+00:00', 1, 1, 555413010);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483645, '2010-01-01 00:00:00+00:00', 1, 1, 1575412235);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483644, '2010-01-01 00:00:00+00:00', 1, 3, -361507387);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483643, '2010-01-01 00:00:00+00:00', 1, 1, -1742081330);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483642, '2000-03-01 23:59:59+00:00', 1, 1, -1056308489);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483641, '2010-01-01 00:00:00+00:00', 1, 4, 172461907);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (2, NULL, 2, 4, 1);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (3, '2010-01-01 00:00:00+00:00', 5, 1, 328305758);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (4, '2000-03-01 23:59:59+00:00', 6, 2, -975213201);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (5, NULL, 7, 6, 1);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (6, '2010-01-01 00:00:00+00:00', 8, 3, -1056308489);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (7, '2042-08-31 23:59:59+00:00', 9, 1, 1631231566);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (8, NULL, 10, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) / 12 FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.AnswerCount <= 2 AND STRFTIME('%Y', T1.CreationDate) = '2010';

/*
Gold Result:
(0.5833333333333334,)
*/

-- Prediction Query
SELECT COUNT("postlinks"."id") / 12 FROM "postlinks" JOIN "posts" ON "postlinks"."postid" = "posts"."id" WHERE STRFTIME('%Y', "postlinks"."creationdate") = '2010' AND "posts"."answercount" <= 2;

/*
Prediction Result:
(0,)
*/