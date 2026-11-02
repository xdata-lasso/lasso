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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'Open source tools for visualizing multi-dimensional data?', 'e5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 537874887, -461695645, '2025-11-28 13:30:18+00:00', -1529584866, 1196308825, 'd21vy9uxj4hw', 2, '2020-03-11 08:08:02+00:00', 'Open source tools for visualizing multi-dimensional data?', 'v', 1581736075, -261132974, -1264842910, -2147483647, '2022-03-02 18:03:57+00:00', '2022-12-08 23:34:02+00:00', -1245682094, '2020-04-10 05:04:30+00:00', 'x5hncprjtu0', 'z');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 1255343543, -541746689, '2024-12-20 11:42:02+00:00', -961217731, -1888505890, 'z16nijjai5d', 3, '2025-07-17 09:46:47+00:00', 'Open source tools for visualizing multi-dimensional data?', '5o', 1449284300, -977470238, -1478247928, -2147483647, '2024-07-26 15:42:53+00:00', '2023-04-21 03:11:26+00:00', 1129658414, '2022-08-16 10:09:33+00:00', '1afgogritsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1180042408, 199672698, '2023-06-27 00:27:42+00:00', -1962347906, -866772222, 'ttg6', 4, '2020-03-23 04:17:18+00:00', 'Open source tools for visualizing multi-dimensional data?', 'ou5z', 1691780814, 1944978593, 1722106924, 3, '2020-02-23 23:54:56+00:00', '2020-09-25 02:07:37+00:00', -1173368267, '2025-01-04 09:05:19+00:00', 'd', '7z2zezj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -604098478, 1248858185, '2020-06-06 19:46:47+00:00', 1999335832, -526612570, 'cmr0oz', 4, '2022-07-12 13:13:05+00:00', 'Open source tools for visualizing multi-dimensional data?', 'g', -20116244, -176606723, -15162884, 2, '2021-11-07 05:17:12+00:00', '2022-01-04 01:02:12+00:00', 1692046802, '2021-09-04 22:07:03+00:00', 'k58qs27p', 'r94gth2m');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, -2136247961, -1478011227, '2020-02-06 22:46:22+00:00', 1919033056, -1428186898, 'uttmu2ne5', 4, '2024-11-14 17:33:35+00:00', 'Open source tools for visualizing multi-dimensional data?', '8lfvyz7zz', -2052653308, -489120589, -72442907, 2, '2022-03-14 12:32:27+00:00', '2024-11-20 13:19:41+00:00', -2060082151, '2025-08-08 12:00:20+00:00', 'maus', 'auvmkrpd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1105964624, -663234145, '2020-04-07 03:05:00+00:00', -1674145149, 234957614, 'o705a9n0jxfo', 1, '2020-09-13 06:13:20+00:00', 'Open source tools for visualizing multi-dimensional data?', 'szdo2z', 270415200, -2071531094, -397848196, 2, '2025-04-29 20:31:18+00:00', '2025-07-15 16:41:07+00:00', 375841374, '2021-05-20 02:31:08+00:00', '2odwcl5a', 'msorlwyngc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 681061317, 1935791961, '2025-06-07 08:57:59+00:00', -413043724, 761519897, 'yoeyo6l', 1, '2023-07-16 23:01:09+00:00', 'Open source tools for visualizing multi-dimensional data?', 'dt', -795975227, 1294064538, 778835680, 3, '2023-05-18 17:35:26+00:00', '2021-06-11 00:32:43+00:00', 450555855, '2023-11-05 01:08:45+00:00', 'gwnlas6', 'elboeowii1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -251205568, 287256667, '2023-03-16 20:38:44+00:00', 412199481, 727608179, 'awg96aqb0tbi', 1, '2025-04-01 08:16:25+00:00', 't1__475364', 'dz39', 2085299664, 2038321753, 1376887048, 2, '2024-10-08 16:57:12+00:00', '2022-08-02 17:02:31+00:00', 748154000, '2023-01-06 00:58:47+00:00', 'g', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 5, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 6, '2020-03-11 00:23:16+00:00', 'Open source tools for visualizing multi-dimensional data?', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -74849714, 105869088, '2023-01-02 05:47:29+00:00', 481163439, 2123196517, 'dwyrq13pyu78', 8, '2020-06-02 21:50:32+00:00', 'Open source tools for visualizing multi-dimensional data?', '9rljsl0b4', 1649269347, -1116181514, 1255852738, 6, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -2078052421, -512640349, '2021-06-12 16:42:05+00:00', 32204797, -1672720816, '8j', 10, '2022-05-28 16:44:30+00:00', 'Open source tools for visualizing multi-dimensional data?', 'wlq7xb', 602161869, 1350414441, 2094425101, 7, '2020-01-31 17:55:18+00:00', '2024-12-20 11:42:02+00:00', -961217731, '2020-09-26 17:28:32+00:00', 'r', 'z16nijjai5d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 645287482, 765724008, '2024-06-30 03:42:59+00:00', 76996700, -435350511, '72ctdctmfg62', 12, '2020-10-18 11:14:36+00:00', 'Open source tools for visualizing multi-dimensional data?', 'v5q8qdj', -1139855872, -288338724, 1897687032, 5, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -176606723, -15162884, '2021-11-07 05:17:12+00:00', -1556979799, -55240145, '8qs27p2r', 14, '2024-09-21 04:14:02+00:00', 'Open source tools for visualizing multi-dimensional data?', '4gth2mnajjla', 1919033056, -1428186898, -761353513, 4, '2024-12-20 13:57:16+00:00', '2022-07-15 04:16:04+00:00', -1311735207, '2023-10-19 18:37:00+00:00', 'e578', 'fvy');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -2071531094, -397848196, '2025-04-29 20:31:18+00:00', -366775518, 575038073, 'dwcl', 16, '2024-03-21 20:48:17+00:00', 'Open source tools for visualizing multi-dimensional data?', 'amsorlwyng', -1960313034, 681061317, 1935791961, 7, '2025-06-07 08:57:59+00:00', '2021-03-08 22:30:59+00:00', 1056589776, '2020-11-27 04:53:28+00:00', 'k1yoeyo6l0h', 't');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't2__2e4676', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1179823637, '2021-09-24 11:50:48+00:00', 't2__2e4676', '2025-01-09 01:18:18+00:00', 'rqrofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 1178636309, '2021-07-01 18:29:24+00:00', 't2__2e4676', '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', 'yrq13p', 'u78d99r', -1362461264, -904834265, -346339240, 1692174491, -1025564911, 'rkf9vqx5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 401805964, '2021-04-23 15:57:00+00:00', 'q8', '2021-10-07 12:15:00+00:00', 'f3dqv0gc', '9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1923912467, '2024-11-10 21:13:22+00:00', 'jh3den8c68', '2023-02-21 21:59:10+00:00', 'vacx7afu5', '1of77p', 'o72ctdc', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', 'tliqa1', 2074205376, 274769912, -188151580, 226938182, 90119032, 'lex');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -1492524358, '2021-01-22 00:53:52+00:00', 'bdvlph', '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', '5hncprjtu0d', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, -1625552518, '2021-12-10 17:04:01+00:00', 'rg', '2021-04-29 02:40:32+00:00', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 1923912467, 518609210, 1948383687, 1476361420, 195720193, 'vacx7afu5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1944978593, '2024-02-13 05:21:59+00:00', 'f', '2021-05-31 16:00:51+00:00', 'oa', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020, 983324983, 1269522000, 853709925, -870767087, 'j5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, -451030047, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '2024-11-20 13:19:41+00:00', 'sx58b4pma', 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 1731843275, -582376271, -1165594842, 'szdo2z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Title = 'Open source tools for visualizing multi-dimensional data?';

/*
Gold Result:
('t2__2e4676',)
('t2__2e4676',)
('q8',)
('jh3den8c68',)
('jh3den8c68',)
('jh3den8c68',)
('t2__2e4676',)
('t2__2e4676',)
('wwqcg',)
('52zbuo4nrq',)
('bdvlph',)
('rg',)
('f',)
('be8yvkv42q',)
*/

-- Prediction Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title LIKE '%Open source tools for visualizing multi-dimensional data%';

/*
Prediction Result:
('t2__2e4676',)
('t2__2e4676',)
('t2__2e4676',)
('q8',)
('t2__2e4676',)
('t2__2e4676',)
('t2__2e4676',)
('q8',)
('t2__2e4676',)
('wwqcg',)
(None,)
('wwqcg',)
('jh3den8c68',)
(None,)
*/