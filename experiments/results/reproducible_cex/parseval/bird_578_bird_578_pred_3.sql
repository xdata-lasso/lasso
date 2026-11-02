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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'understanding what dassault isight is doing?', 'e5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1438850342, -305670381, '2021-03-25 19:22:18+00:00', 105869088, -2081315180, '2dwyrq13pyu7', 1, '2024-08-08 00:51:45+00:00', 'understanding what dassault isight is doing?', '9', 244829661, -1362461264, -904834265, -2147483647, '2023-07-26 21:52:05+00:00', '2020-03-25 00:00:06+00:00', 1692174491, '2024-03-18 20:04:07+00:00', 'i2rkf', 'vqx58pz0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 172461907, 1606439408, '2021-05-16 14:38:12+00:00', -155284187, 1686459626, 'lyr', 3, '2021-06-12 16:42:05+00:00', 'understanding what dassault isight is doing?', 'n6vck6ah0f', 138842628, -932772113, -639539893, 1, '2022-03-20 09:18:33+00:00', '2024-06-08 00:23:27+00:00', 1255343543, '2020-03-06 15:32:29+00:00', '72fxa7ryfd', 'z16ni');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 1774087382, 1732258051, '2024-05-22 05:48:31+00:00', 1523825314, 2078438287, '5w1of7', 4, '2024-05-28 03:27:01+00:00', 'understanding what dassault isight is doing?', 'zo72', -1957268147, -1928431425, 1303877941, 1, '2025-11-30 16:40:04+00:00', '2025-03-16 18:53:17+00:00', -1284905200, '2020-11-14 00:31:21+00:00', '2g0v5q8qd', 'jpe1io22785');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -1962347906, -866772222, '2022-01-28 18:02:07+00:00', 1582582341, 453836040, '6b', 4, '2021-11-07 01:38:36+00:00', 'understanding what dassault isight is doing?', 'u5zi', 1944978593, 1722106924, -2072838897, 4, '2021-05-31 16:00:51+00:00', '2020-10-11 01:34:34+00:00', 1923659053, '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 983324983, 1269522000, '2025-12-11 00:03:18+00:00', -405743609, -1935752926, '5i3', 4, '2021-06-20 20:52:42+00:00', 'understanding what dassault isight is doing?', '5lnpi', -1300180872, -1125548818, 1497321728, 3, '2024-09-21 04:14:02+00:00', '2024-01-24 03:21:29+00:00', -1719383707, '2020-12-28 23:17:24+00:00', '2mnajjla3o', 'v8u');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 362376128, -1311735207, '2023-10-19 18:37:00+00:00', -1252009958, 1908593332, 'vy', 1, '2023-05-05 20:15:58+00:00', 'understanding what dassault isight is doing?', 'zzbe8yvkv', 318331233, -233617564, 79330142, 3, '2023-02-22 13:15:37+00:00', '2025-10-01 11:12:58+00:00', -2060082151, '2025-08-08 12:00:20+00:00', 'maus', 'auvmkrpd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1105964624, -663234145, '2020-04-07 03:05:00+00:00', -1674145149, 234957614, 'o705a9n0jxfo', 1, '2020-09-13 06:13:20+00:00', 'understanding what dassault isight is doing?', 'szdo2z', 270415200, -2071531094, -397848196, -2147483647, '2025-04-29 20:31:18+00:00', '2025-07-15 16:41:07+00:00', 375841374, '2021-05-20 02:31:08+00:00', '2odwcl5a', 'msorlwyngc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 1935791961, 595714424, '2023-06-08 15:48:15+00:00', -499913447, -360096930, 't', 1, '2024-04-21 11:49:54+00:00', 'pos_c49136', 'uq', 1294064538, 778835680, 1755752040, 3, '2021-06-11 00:32:43+00:00', '2020-03-04 20:06:24+00:00', -30041412, '2023-09-14 18:35:43+00:00', 'wn', 'as6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 2, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 5, '2020-03-11 00:23:16+00:00', 'understanding what dassault isight is doing?', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -74849714, 105869088, '2023-01-02 05:47:29+00:00', 481163439, 2123196517, 'dwyrq13pyu78', 7, '2020-06-02 21:50:32+00:00', 'understanding what dassault isight is doing?', '9rljsl0b4', 1649269347, -1116181514, 1255852738, 6, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -2078052421, -512640349, '2021-06-12 16:42:05+00:00', 32204797, -1672720816, '8j', 9, '2022-05-28 16:44:30+00:00', 'understanding what dassault isight is doing?', 'wlq7xb', 602161869, 1350414441, 2094425101, 7, '2020-01-31 17:55:18+00:00', '2024-12-20 11:42:02+00:00', -961217731, '2020-09-26 17:28:32+00:00', 'r', 'z16nijjai5d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 645287482, 765724008, '2024-06-30 03:42:59+00:00', 76996700, -435350511, '72ctdctmfg62', 11, '2020-10-18 11:14:36+00:00', 'understanding what dassault isight is doing?', 'v5q8qdj', -1139855872, -288338724, 1897687032, 5, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -176606723, -15162884, '2021-11-07 05:17:12+00:00', -1556979799, -55240145, '8qs27p2r', 13, '2024-09-21 04:14:02+00:00', 'understanding what dassault isight is doing?', '4gth2mnajjla', 1919033056, -1428186898, -761353513, 3, '2024-12-20 13:57:16+00:00', '2022-07-15 04:16:04+00:00', -1311735207, '2023-10-19 18:37:00+00:00', 'e578', 'fvy');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -2071531094, -397848196, '2025-04-29 20:31:18+00:00', -366775518, 575038073, 'dwcl', 15, '2024-03-21 20:48:17+00:00', 'understanding what dassault isight is doing?', 'amsorlwyng', -1960313034, 681061317, 1935791961, 7, '2025-06-07 08:57:59+00:00', '2021-03-08 22:30:59+00:00', 1056589776, '2020-11-27 04:53:28+00:00', 'k1yoeyo6l0h', 't');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, 1, '2024-12-15 00:56:33+00:00', 'use_c4aca5', '2025-11-23 07:28:46+00:00', '5k5swwqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 1, '2021-11-30 23:39:10+00:00', 'use_c4aca5', '2024-01-27 22:01:59+00:00', 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1937207087, '2023-09-10 09:37:01+00:00', 'y9uxj4', '2021-01-22 00:53:52+00:00', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', -1898531797, -1748371085, -1742081330, 894242932, -211209314, 'dqv0gcb9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1483100200, '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3', 'y', -598313376, 1972233925, 1792827279, 804529642, -1538707438, 'den8c68x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', 'tliqa1', 2074205376, 274769912, -188151580, 226938182, 90119032, 'lex');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -1492524358, '2021-01-22 00:53:52+00:00', 'bdvlph', '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', '5hncprjtu0d', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, -1625552518, '2021-12-10 17:04:01+00:00', 'rg', '2021-04-29 02:40:32+00:00', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 1923912467, 518609210, 1948383687, 1476361420, 195720193, 'vacx7afu5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1944978593, '2024-02-13 05:21:59+00:00', 'f', '2021-05-31 16:00:51+00:00', 'oa', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020, 983324983, 1269522000, 853709925, -870767087, 'j5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, -451030047, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '2024-11-20 13:19:41+00:00', 'sx58b4pma', 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 1731843275, -582376271, -1165594842, 'szdo2z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName, T1.Reputation FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T2.Title = 'Understanding what Dassault iSight is doing?';

/*
Gold Result:
*/

-- Prediction Query
SELECT users.DisplayName, users.Reputation FROM posts INNER JOIN users ON posts.OwnerUserId = users.Id WHERE LOWER(posts.Title) = 'understanding what dassault isight is doing?';

/*
Prediction Result:
('use_c4aca5', 1)
('use_c4aca5', 1)
('y9uxj4', -1937207087)
('dh5ogrgj', -1483100200)
('dh5ogrgj', -1483100200)
('dh5ogrgj', -1483100200)
('use_c4aca5', 1)
('use_c4aca5', 1)
('wwqcg', -55602865)
('52zbuo4nrq', -1585009206)
('bdvlph', -1492524358)
('rg', -1625552518)
('f', 1944978593)
('be8yvkv42q', -451030047)
*/