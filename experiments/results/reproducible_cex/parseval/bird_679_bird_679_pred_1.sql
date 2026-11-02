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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 't2__907b68', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1675430660, -688509700, '2025-07-25 08:53:04+00:00', 0, 233994589, 'j4hwbd', 4, '2022-10-17 07:55:28+00:00', 't2__05a63f', 'ph2', 1298861365, 1968874827, -664193365, -2147483647, '2022-02-18 09:12:59+00:00', '2020-04-10 05:04:30+00:00', 555413010, '2025-09-07 08:46:54+00:00', 'hncprjtu', 'dz79fjg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 1427161052, 564390026, '2024-11-03 18:41:48+00:00', 0, 61479715, 'jja', 4, '2021-02-04 08:22:25+00:00', 't2__05a63f', 'dh5ogrgj', -458359144, 600440952, 1568069663, 1, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -241848752, 2004147439, '2022-11-19 00:43:43+00:00', 0, -866772222, 'ttg6', 4, '2020-03-23 04:17:18+00:00', 't2__05a63f', 'ou5z', 1691780814, 1944978593, 1722106924, -2147483647, '2020-02-23 23:54:56+00:00', '2020-09-25 02:07:37+00:00', -1173368267, '2025-01-04 09:05:19+00:00', 'd', '7z2zezj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -1428186898, -761353513, '2024-12-20 13:57:16+00:00', -1, 618058035, '2ne578', 4, '2021-06-23 03:34:31+00:00', 't2__05a63f', 'vy', -451030047, -2052653308, -489120589, -2147483647, '2021-05-17 07:10:59+00:00', '2022-10-30 06:13:33+00:00', 318331233, '2023-10-16 10:50:30+00:00', '7sx58', 'b4pmaus3auv');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 274891948, 609771851, '2020-06-03 10:00:15+00:00', -609553675, 989018473, 'chn9mo70', 1, '2024-02-20 06:09:53+00:00', 't2__907b68', 'a9n0jxfofws', 1719800120, -210159774, 270415200, -2147483647, '2020-02-24 22:37:14+00:00', '2020-04-02 11:13:10+00:00', -397848196, '2025-04-29 20:31:18+00:00', '0k32odwcl5a', 'msorlwyngc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, 287256667, 1614799674, '2025-07-02 03:36:52+00:00', -1, 727608179, 'awg96aqb0tbi', 0, '2025-04-01 08:16:25+00:00', 't2__05a63f', 'dz39', 2085299664, 2038321753, 1376887048, 4, '2024-10-08 16:57:12+00:00', '2022-08-02 17:02:31+00:00', 748154000, '2023-01-06 00:58:47+00:00', 'g', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 1677948887, 389700824, '2025-09-10 18:51:56+00:00', 0, 769234989, '8ftp6ewtqx', -1, '2023-01-28 06:02:52+00:00', 't2__05a63f', 'jaby', 462225708, 1528227252, -1277305894, -1, '2023-02-03 12:07:21+00:00', '2024-06-12 11:15:53+00:00', -1659775598, '2023-11-11 00:49:07+00:00', '6sto', 'cj8sh5k');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 1966809332, 1487347213, '2023-03-15 00:23:20+00:00', -1, -531932574, 'jmgjach', -1, '2024-07-16 00:46:06+00:00', 't2__05a63f', 'qta8y3a17v4y', 306260487, 1168225104, -499203870, 0, '2023-12-18 01:48:18+00:00', '2022-02-24 01:09:12+00:00', 1032339628, '2022-02-11 12:07:46+00:00', 'uap96rntdqr', 'm5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 2, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -1, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, -2147483645, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', 'tliqa1', 2074205376, 274769912, -188151580, 226938182, 90119032, 'lex');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -74849714, '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '2022-03-25 08:00:08+00:00', '3pyu78d', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483645, -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, 1235416111, '2023-08-17 20:15:35+00:00', 'jh3den8c68', '2023-02-21 21:59:10+00:00', 'vacx7afu5', '1of77p', 'o72ctdc', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, 1448731351, '2024-06-13 19:21:11+00:00', 'wgxd5ysxcm', '2022-04-20 03:52:20+00:00', '0oztdgj5i3lq', '5lnpim5k58qs', '7p2r94gt', 1273687251, 333302050, 1162591638, -2136247961, -1478011227, '3');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, -413043724, '2025-10-05 07:32:01+00:00', '1yo', '2020-08-13 21:38:24+00:00', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 1468640756, 1048147204, -1814875250, -647898186, -1610380698, '5nxih66');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, 1964331395, '2024-04-21 17:44:41+00:00', 'd', '2023-07-29 15:22:11+00:00', '9603vz', 'xw1rxe9yfk7', 'k162n', -516345261, -1191116453, 1709667347, -1934709172, -2121397544, 'rmkio18r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Id, T2.Title FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId ORDER BY T2.Score DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(-1, None)
*/

-- Prediction Query
SELECT Id, Title FROM posts WHERE Score = (SELECT MAX(Score) FROM posts);

/*
Prediction Result:
(4, None)
*/