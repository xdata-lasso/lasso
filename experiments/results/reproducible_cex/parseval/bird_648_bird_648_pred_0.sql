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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 151, 1, '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00', 1038707349, '2024-12-31 04:19:17+00:00', '000t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 274769912, -188151580, '2024-09-13 14:36:04+00:00', -1666765085, 1178636309, 'ex1', 1, '2024-02-08 07:13:40+00:00', 'i7z', 'au2dwy', -953437896, -1097120355, 151, -2147483647, '2022-10-12 16:19:32+00:00', '2024-06-05 19:22:34+00:00', 244829661, '2021-07-21 20:51:39+00:00', 'sl0', '4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -1116181514, 1255852738, '2021-03-04 06:15:13+00:00', -227162283, 2056419640, 'vqx58pz0f', 1, '2025-12-29 07:05:42+00:00', 'jegd21vy9', 'xj4hwb', -1929953647, 1581736075, 151, -2147483647, '2023-09-26 13:08:37+00:00', '2020-12-04 21:49:29+00:00', -1264842910, '2022-03-02 18:03:57+00:00', 'nqcx5h', 'cprj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 1074760385, 1129658414, '2022-08-16 10:09:33+00:00', 600440952, 1568069663, 'fgogritsj3ay', 4, '2023-01-25 15:19:02+00:00', '1q43', '1jh3den', 357330522, -683007527, 151, 3, '2020-05-02 02:12:13+00:00', '2023-02-22 19:24:03+00:00', -1762140823, '2024-02-28 09:48:47+00:00', '1of77p', 'o72ctdc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -1284905200, 7929158, '2020-10-18 11:14:36+00:00', -698610044, -1021978385, 'jpe1io22785', 4, '2023-06-27 00:27:42+00:00', '7cvtjpttg6b', 'ou5z', 1691780814, 1944978593, 151, 3, '2024-02-13 05:21:59+00:00', '2020-02-23 23:54:56+00:00', -1776877925, '2020-10-11 01:34:34+00:00', 'oacd07z2zez', 'o7w');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1248858185, -57705450, '2022-06-10 06:35:27+00:00', -546516406, -405743609, 'g', 4, '2021-03-26 14:01:04+00:00', '5i3lq5lnpim5', '58q', 1817366143, 1615073310, 151, 1, '2025-05-07 04:09:25+00:00', '2024-06-08 02:27:24+00:00', 1055237066, '2023-11-07 06:34:01+00:00', '94gth', '2mnajjla3o');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 872694102, 618058035, '2022-09-17 08:42:23+00:00', -229022515, -1817527403, '78lfvyz7zz', 1, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '7sx58b4pma', -929383517, -2090240067, 151, -2147483647, '2022-11-13 09:18:31+00:00', '2021-09-20 21:41:13+00:00', 274891948, '2025-06-17 13:01:08+00:00', 'djwz', 'w5chn9mo705a');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1514700303, -1796351243, '2020-09-13 06:13:20+00:00', -634585028, 1719800120, 'o', 1, '2023-11-02 10:05:42+00:00', 'obb0q0k', '2odwcl5a', 292557306, 709097796, 151, -2147483647, '2022-04-21 05:35:41+00:00', '2021-07-28 17:39:51+00:00', -605061107, '2021-11-01 11:17:30+00:00', 'gc1dj9erhi', 'zgk1yoeyo6l0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -477129795, -1418927432, '2025-06-29 01:47:27+00:00', -30041412, -277407746, 'nlas6e', 1, '2025-09-08 01:16:35+00:00', 'boe', 'wii1', -457369423, 1557188093, 150, 3, '2025-05-04 13:24:05+00:00', '2023-02-18 23:14:50+00:00', -1552469358, '2024-05-19 10:57:10+00:00', '2q2xlyoto', '9oaawg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 2, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, NULL, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 5, '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 1160656988, -992890117, 151, 2, '2020-01-15 18:18:33+00:00', '2023-10-02 15:43:02+00:00', 1219478689, '2022-10-06 13:20:05+00:00', 'hsrwbbp', 'luhvdltti');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 429706943, 462974032, '2021-12-31 07:20:26+00:00', 2026480202, -1576219117, '5u', 6, '2021-11-09 05:42:50+00:00', '6klfa9', '00t5c4e', 1274489983, -1683203397, 151, -2147483647, '2025-04-19 21:11:20+00:00', '2020-08-15 08:54:31+00:00', -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', 'rofqyp5s5b');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__f75f3b', '2022-06-06 02:35:43+00:00', 't1__a3bbc2', 'wqcgsk', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1585009206, '2021-08-19 01:10:02+00:00', 't1__f75f3b', '2024-10-24 14:16:53+00:00', 't1__a3bbc2', '2zbuo4nr', 'qrofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -841004020, '2023-07-15 22:31:56+00:00', 't1__f75f3b', '2020-06-29 02:04:50+00:00', 't1__a3bbc2', '79fjgq8', 'n2f3dqv0gcb9', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 638024588, '2025-11-22 09:05:23+00:00', 'vck6ah0f8', '2021-03-29 13:18:36+00:00', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', 2011234363, -1483100200, -7597509, -1625552518, -1738458256, 'jd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', NULL, 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName, T1.WebsiteUrl FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T2.FavoriteCount > 150;

/*
Gold Result:
('t1__f75f3b', 't1__a3bbc2')
('t1__f75f3b', 't1__a3bbc2')
('t1__f75f3b', 't1__a3bbc2')
('vck6ah0f8', 'wwlq7')
('vck6ah0f8', 'wwlq7')
('vck6ah0f8', 'wwlq7')
('t1__f75f3b', 't1__a3bbc2')
('t1__f75f3b', 't1__a3bbc2')
(None, 'value')
('value', None)
*/

-- Prediction Query
SELECT u.DisplayName, u.WebsiteUrl FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE p.FavoriteCount > 150 AND NOT u.WebsiteUrl IS NULL;

/*
Prediction Result:
('t1__f75f3b', 't1__a3bbc2')
('t1__f75f3b', 't1__a3bbc2')
('t1__f75f3b', 't1__a3bbc2')
('vck6ah0f8', 'wwlq7')
('vck6ah0f8', 'wwlq7')
('vck6ah0f8', 'wwlq7')
('t1__f75f3b', 't1__a3bbc2')
('t1__f75f3b', 't1__a3bbc2')
(None, 'value')
*/