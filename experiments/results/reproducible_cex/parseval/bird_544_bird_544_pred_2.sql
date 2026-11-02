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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'Examples for teaching: Correlation does not mean causation', 'e5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 537874887, -461695645, '2025-11-28 13:30:18+00:00', -1529584866, 1196308825, 'd21vy9uxj4hw', -2147483647, '2020-03-11 08:08:02+00:00', 'Examples for teaching: Correlation does not mean causation', 'v', 1581736075, -261132974, -1264842910, 2, '2022-03-02 18:03:57+00:00', '2022-12-08 23:34:02+00:00', -1245682094, '2020-04-10 05:04:30+00:00', 'x5hncprjtu0', 'z');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -1520489792, -658391922, '2021-07-03 08:58:16+00:00', 1255343543, -541746689, '7ryfdrz16n', 3, '2021-02-09 08:26:06+00:00', 'Examples for teaching: Correlation does not mean causation', 'jai', 1746373317, 1360271423, 1583472758, 3, '2020-10-22 21:08:07+00:00', '2022-04-26 08:43:58+00:00', -1714354341, '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 1303877941, -1284905200, '2020-11-14 00:31:21+00:00', -242584410, -698610044, 'q8qdjpe1io22', 1, '2024-05-29 05:19:47+00:00', 'Examples for teaching: Correlation does not mean causation', '507cvtjpt', 453836040, 1467355421, -1171104889, 4, '2024-03-12 07:01:30+00:00', '2023-06-13 16:42:54+00:00', 1691780814, '2023-12-14 20:00:33+00:00', 'c4bfkfoac', '0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -406331049, -461418236, '2025-12-26 20:24:57+00:00', 641521863, 304189298, 'xd', 4, '2024-02-20 16:52:17+00:00', 'Examples for teaching: Correlation does not mean causation', 'sxcmr0o', 853709925, -870767087, -1699185893, 4, '2025-12-26 14:53:02+00:00', '2024-03-18 21:27:42+00:00', -1609653472, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1817366143, 1615073310, '2025-05-07 04:09:25+00:00', -1125548818, 1497321728, '4gth2mnaj', -2147483647, '2021-04-29 06:47:06+00:00', 'Examples for teaching: Correlation does not mean causation', 'a3o', -1428186898, -761353513, 362376128, 4, '2024-12-23 03:48:38+00:00', '2024-10-19 09:01:03+00:00', -1311735207, '2023-10-19 18:37:00+00:00', 'e578', 'fvy');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 448935289, 458835042, '2020-08-06 07:31:44+00:00', -489120589, -72442907, '7sx58', 3, '2025-10-20 14:58:18+00:00', 'Examples for teaching: Correlation does not mean causation', '4', -1122409769, 1849819405, -929383517, 1, '2020-02-11 09:48:43+00:00', '2022-09-08 09:11:51+00:00', -699574669, '2021-05-14 07:56:41+00:00', 'rpdjwzw5ch', '9mo7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 628082526, -1245584612, '2021-04-02 17:49:19+00:00', -582376271, -1165594842, 'szdo2z', 3, '2024-10-15 01:24:38+00:00', 'Examples for teaching: Correlation does not mean causation', 'bb0q', -366775518, 575038073, -1161141730, 1, '2023-01-14 08:25:47+00:00', '2020-04-28 14:07:17+00:00', 2061558815, '2024-03-21 20:48:17+00:00', 'amsorlwyng', '1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -413043724, 761519897, '2023-08-24 14:09:34+00:00', 955267863, -1156828895, 'o6l0hdt', 1, '2024-04-21 11:49:54+00:00', 't1__cdfde1', 'uq', 1294064538, 778835680, 1755752040, 1, '2021-06-11 00:32:43+00:00', '2020-03-04 20:06:24+00:00', -30041412, '2023-09-14 18:35:43+00:00', 'wn', 'as6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 1, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 5, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'Examples for teaching: Correlation does not mean causation', 'nprmdposii', -1823627488, -1209887326, -1399556171, 6, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -74849714, 105869088, '2023-01-02 05:47:29+00:00', 481163439, 2123196517, 'dwyrq13pyu78', 6, '2020-06-02 21:50:32+00:00', 'Examples for teaching: Correlation does not mean causation', '9rljsl0b4', 1649269347, -1116181514, 1255852738, 8, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -2078052421, -512640349, '2021-06-12 16:42:05+00:00', 32204797, -1672720816, '8j', 7, '2022-05-28 16:44:30+00:00', 'Examples for teaching: Correlation does not mean causation', 'wlq7xb', 602161869, 1350414441, 2094425101, 10, '2020-01-31 17:55:18+00:00', '2024-12-20 11:42:02+00:00', -961217731, '2020-09-26 17:28:32+00:00', 'r', 'z16nijjai5d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 645287482, 765724008, '2024-06-30 03:42:59+00:00', 76996700, -435350511, '72ctdctmfg62', 5, '2020-10-18 11:14:36+00:00', 'Examples for teaching: Correlation does not mean causation', 'v5q8qdj', -1139855872, -288338724, 1897687032, 12, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -176606723, -15162884, '2021-11-07 05:17:12+00:00', -1556979799, -55240145, '8qs27p2r', 4, '2024-09-21 04:14:02+00:00', 'Examples for teaching: Correlation does not mean causation', '4gth2mnajjla', 1919033056, -1428186898, -761353513, 14, '2024-12-20 13:57:16+00:00', '2022-07-15 04:16:04+00:00', -1311735207, '2023-10-19 18:37:00+00:00', 'e578', 'fvy');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -2071531094, -397848196, '2025-04-29 20:31:18+00:00', -366775518, 575038073, 'dwcl', 7, '2024-03-21 20:48:17+00:00', 'Examples for teaching: Correlation does not mean causation', 'amsorlwyng', -1960313034, 681061317, 1935791961, 16, '2025-06-07 08:57:59+00:00', '2021-03-08 22:30:59+00:00', 1056589776, '2020-11-27 04:53:28+00:00', 'k1yoeyo6l0h', 't');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't2__b2606e', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1179823637, '2021-09-24 11:50:48+00:00', 't2__b2606e', '2025-01-09 01:18:18+00:00', 'rqrofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 1178636309, '2021-07-01 18:29:24+00:00', 't2__b2606e', '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', 'yrq13p', 'u78d99r', -1362461264, -904834265, -346339240, 1692174491, -1025564911, 'rkf9vqx5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1748371085, '2020-10-20 06:14:04+00:00', '8n2f3', '2025-11-06 14:42:57+00:00', 'q', '0gcb98', 'zk3z', 1686459626, -1554531873, 982314585, 638024588, -688098735, '6ah');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -491938169, '2022-01-13 07:24:35+00:00', 'q4301jh', '2023-12-06 02:24:58+00:00', 'e', '8c68', '8vacx7', 1523825314, 2078438287, -47052816, 645287482, 765724008, '7pzo72ctd');

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
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title = 'Examples for teaching: Correlation does not mean causation';

/*
Gold Result:
('t2__b2606e',)
('t2__b2606e',)
('8n2f3',)
('q4301jh',)
('q4301jh',)
('q4301jh',)
('t2__b2606e',)
('t2__b2606e',)
('wwqcg',)
('52zbuo4nrq',)
('bdvlph',)
('rg',)
('f',)
('be8yvkv42q',)
*/

-- Prediction Query
SELECT DISTINCT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title = 'Examples for teaching: Correlation does not mean causation';

/*
Prediction Result:
('t2__b2606e',)
('8n2f3',)
('q4301jh',)
('wwqcg',)
('52zbuo4nrq',)
('bdvlph',)
('rg',)
('f',)
('be8yvkv42q',)
*/