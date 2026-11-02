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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1072996612, 13244799, '2022-09-23 20:24:07+00:00', 1019800248, 1000, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1575412235, -988981234, '2022-08-03 01:56:16+00:00', -792947627, 1000, 'z', 1, '2024-06-08 14:05:00+00:00', 'fjgq8n2f3', 'dqv0gcb98ozk', -155284187, 1686459626, -1554531873, 1, '2023-03-28 14:41:46+00:00', '2022-05-18 00:14:53+00:00', 1038566008, '2025-03-26 10:17:14+00:00', 'n6vck6ah0f8', 'sww');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 609771851, -1934017803, '2025-10-04 15:32:15+00:00', 1105964624, 1000, 'w5chn9m', 2, '2025-11-19 09:24:25+00:00', '705a', '9n0jxfofwsz', -210159774, 270415200, -2071531094, -2147483647, '2023-06-19 15:36:55+00:00', '2022-03-19 07:41:34+00:00', -366775518, '2023-11-21 15:04:11+00:00', '2odwcl5amso', 'lwyng');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 681061317, 1935791961, '2025-06-07 08:57:59+00:00', -413043724, 761519897, 'yoeyo6l', 4, '2023-07-16 23:01:09+00:00', 'dt', 'fuqyxuzkb', -30041412, -277407746, -670154354, 1, '2021-07-02 13:56:51+00:00', '2020-01-06 01:47:51+00:00', -2076274980, '2020-08-28 14:27:04+00:00', 'wii1', '5nxih66');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2038321753, 1376887048, '2024-10-08 16:57:12+00:00', -841516418, 152478847, '5wcgumbc3td', 2, '2024-11-28 14:19:46+00:00', '6bd0w9', '03vzxw1rx', 2012400150, -505019168, 1968783602, 4, '2024-07-02 05:26:35+00:00', '2022-03-07 06:27:54+00:00', 312804300, '2025-12-21 03:00:28+00:00', '62nh55y3do', 'vu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 2013745856, 917362079, '2023-03-16 17:59:19+00:00', 462225708, 1528227252, 'fx7h', 2, '2023-12-11 11:19:14+00:00', 'p6sto1cj', 'sh5knzys7', 1487347213, 1328948152, -1923069176, 2, '2024-12-17 00:18:59+00:00', '2021-03-29 20:14:24+00:00', -1502591405, '2020-04-10 08:01:49+00:00', '8q', 'ta8y3a17v4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -670250982, -2091687257, '2021-03-13 17:12:02+00:00', 1580782292, 1000, 'jwk6hh2oe7', -2147483647, '2025-01-28 11:17:03+00:00', '350fzrv1l', '930', 286693031, -728757169, -1008994143, 2, '2024-04-05 14:41:38+00:00', '2025-08-07 10:12:19+00:00', -974198226, '2022-01-07 13:37:53+00:00', 'saxeeinmbc', 'v5o');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 764470079, -1038583670, '2023-11-12 20:15:07+00:00', -986328637, 1000, 'xdoxa0', 2, '2021-11-14 16:08:19+00:00', 'l1zmjrssbh', '2404qpp33', -383974656, -2083357443, -1232267276, -2147483647, '2022-03-16 00:47:20+00:00', '2022-10-11 07:37:50+00:00', 359389091, '2020-07-12 20:48:01+00:00', 'ojdlhl', 'pdyxk0a');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1683203397, 528680845, '2023-12-22 03:17:01+00:00', 1155439218, 1000, 'um5', 1, '2023-11-07 12:14:47+00:00', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -2147483647, '2021-03-04 19:22:02+00:00', '2022-02-19 15:51:21+00:00', -2118135981, '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 1775126557, -74849714, '2021-02-17 21:51:43+00:00', -453362185, 1000, 'au2dwyrq13', 5, '2022-01-29 19:28:25+00:00', 'u78d99r', 'jsl', -346339240, 1692174491, -1025564911, -2147483647, '2023-10-21 02:54:45+00:00', '2022-04-27 23:55:02+00:00', 2056419640, '2024-09-10 08:04:52+00:00', 'qx58pz', 'f8jegd2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1427161052, 564390026, '2024-11-03 18:41:48+00:00', 61479715, 999, 'jja', -2147483647, '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '8', -458359144, 600440952, 1568069663, 8, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 1, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1072996612, 13244799, '2022-09-23 20:24:07+00:00', 1019800248, 1000, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -705985602, '2025-02-21 13:28:29+00:00', 'x58pz0f8jeg', '2020-06-01 02:38:05+00:00', '1vy9uxj4', 'wb', 'v', 1581736075, -261132974, -1264842910, -1052964641, -1245682094, 'x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -47052816, '2025-07-13 05:36:35+00:00', 'of77pzo', '2025-11-10 20:25:30+00:00', '72ctdctmfg62', '0v', 'q8qdjpe1', -1180042408, 199672698, 2119806856, -1962347906, -866772222, 'ttg6');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1798111945, '2022-09-30 05:55:33+00:00', '5zi36c4bfkfo', '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', -1699185893, 875300074, -1609653472, -1405314653, 1816660482, 'npi');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -270163507, '2024-09-09 00:32:20+00:00', 'r8', '2023-02-21 14:07:24+00:00', 'qbl', 'xd4s', '5il', 1338378083, 945802166, 47431001, -698277997, 748510826, 'wakmwgw73fy3');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -1884996250, '2020-06-06 01:38:23+00:00', 'ptx', '2020-10-01 23:52:35+00:00', 'bl10qx6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', -199427879, -18235088, 564132547, 562558425, -417385007, 'i');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 76996700, '2023-05-23 12:32:01+00:00', '72ct', '2020-06-07 10:59:23+00:00', 't', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, -241848752, 2004147439, 'tjpttg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, 2, 1, '4nrq', '2025-01-30 02:54:07+00:00', 1, 'ofqyp', 's5bbp02e', 'tliqa1');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 3, 1, 'ryytoo3', '2021-12-11 04:26:48+00:00', 1, 'hl72klex1', 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 4, 1, '9', '2024-09-26 13:13:01+00:00', 1, 'ljsl0', '4', 'p5qi2rk');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 2, 1, 'q7x', '2020-03-06 15:32:29+00:00', 1, '72fxa7ryfd', 'z16ni', 'jai');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 3, 1, 'dh5ogrgj', '2020-06-19 19:37:13+00:00', 1, 'yzt1afgog', 'itsj3', 'y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 4, -2147483647, '1q43', '2023-06-28 02:52:00+00:00', 1, 'jh3den8', 'c68x8vacx7', 'f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, 2, 1, '5k58', '2022-02-21 20:00:53+00:00', 4, 's27p2r94gth2', 'najj', 'a3o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 3, 1, 'v8u', '2022-08-27 04:45:18+00:00', 4, 'tmu2ne578l', 'vy', '7zzbe8y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 4, 1, 'kv42q7', '2022-05-28 06:47:17+00:00', 4, '58b4pm', 'u', '3auvm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483639, 2, 4, 'q2xlyoto', '2022-12-15 20:09:37+00:00', 1, 'oaawg96aq', '0', 'bindz');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483638, 3, 5, '6dza35r', '2025-09-12 02:45:33+00:00', 1, 'kio1', 'ri2hy08ft', '6ewt');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 4, 6, 'ygmayq3qdpu', '2020-02-17 04:43:11+00:00', 1, '96rn', 'dqrhm', 'wlic7dn2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, 2, 1, '90xdmsqt', '2020-11-30 04:51:31+00:00', 4, 'lc', 'qb9i9f', 'ccukjq1q');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, 3, 1, 'ik1yhb', '2023-07-12 04:15:18+00:00', 4, 'hlst1pqom', 'ztv', '6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, 4, 1, '4iz7', '2024-08-21 17:37:09+00:00', 4, 'q', 'lud8f', 'tb8r9114qbre');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483633, 2, 4, 'uu', '2022-12-10 16:57:51+00:00', 1, 'j8kjh', '5wpxlvris', 'urz0kaqtncg');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483632, 3, 5, 'c8s3b7v88k', '2023-01-07 20:03:41+00:00', 1, 'm', 'b', 'h');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483631, 4, 6, '6j47n', '2023-02-24 23:29:14+00:00', 1, 'r', '0hsjhanz', 'dpunmw');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483630, 2, 1, 'qrlawk', '2023-07-20 15:35:59+00:00', 4, '14r5dqtsmg97', 'aqz2o20pj6d', 'dlysu6iphd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483629, 3, 1, 'u2g', '2021-02-12 03:53:34+00:00', 4, '31vwq', '1oa2sb3u', 'i1pa');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483628, 4, 1, 'cvwnyq', '2022-04-06 03:56:24+00:00', 4, 'uirl', 'rpouit63xyf', 'mjwpp2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483627, 2, 4, 'aj0ju0h3', '2022-05-04 21:59:05+00:00', 1, '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483626, 3, 5, '54o6qjektb1', '2020-07-03 07:17:37+00:00', 1, 'nzg3rjkw', 'ns47j2ja8dc', 'y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483625, 4, 6, 'vjwq49yr', '2021-11-08 10:13:37+00:00', 1, 'xs6dvdxdo2', '7t3gvp', 'j9f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483624, 2, 1, 'uun7k10z2my1', '2021-12-19 13:06:55+00:00', 4, 'gyv1rgezaxc', '1clupgly78o', 'txe');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483623, 3, 1, 'lpe', '2023-08-01 18:59:25+00:00', 4, '19cy7od033d', 'hds', 'nhed29');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483622, 4, 1, 'qv2', '2024-05-04 08:55:12+00:00', 4, 'u331spxpw30b', 'wk', 'xginlj6idm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483621, 2, 4, '2o3', '2020-01-30 11:27:57+00:00', 1, '162', 'cagj', 'ev');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483620, 3, 5, 'zxlu49', '2021-05-12 18:37:33+00:00', 1, 'boe8cd', '4u', 'kh');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483619, 4, 6, 'llbwvdpu5v0e', '2020-06-13 01:38:22+00:00', 1, 'y9v2z1', '29835xoepa', 'cxdb2f0c296x');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483618, 2, 1, 'et8xjhcf46c', '2020-10-07 05:57:05+00:00', 4, 'perxa61sjv', 'nv3ddroku', 'zc');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483617, 3, 1, 'ehia3', '2020-04-29 23:45:36+00:00', 4, 'mvb7vpc0xffw', 'r1es', 'sf9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483616, 4, 1, '82qg0', '2023-08-19 06:53:10+00:00', 4, 'ui', '7f8', 'qhi');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483615, 2, 4, 'gm8gxb5qjl', '2022-07-06 20:49:55+00:00', 1, 'awsp4kwi3h', '7j4', 'y795ybv8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483614, 3, 5, 'kr3w4jn2', '2023-05-04 12:29:43+00:00', 1, '9xgjjac', 'gmukfb5if4', '80terbf');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483613, 4, 6, 'kvee', '2024-05-15 08:40:39+00:00', 1, 'ltut6', 'lu2cel8mhfc', 'mn5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483612, 4, 1, 'i0f', '2021-09-15 16:05:47+00:00', 1, 'bgz5oqxs27', 'h888y1', '253');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483611, 4, 1, '9ls1ehn1', '2021-08-09 03:33:17+00:00', 1, 'daqqhyyzsn', '64hm', 'nw4m');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483610, 4, 1, 'wbjk0', '2020-02-21 02:46:03+00:00', 1, 'h6gd', 'b7jjpl', 'tlzh42');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483609, 4, 1, '5yr', '2021-04-08 20:41:55+00:00', 1, '5mq', 'na3', '8gfxswb2d0zm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483608, 4, 1, 'b', '2024-06-09 02:04:04+00:00', 1, 'tp5q', '1k4c', 'gwnkd4kc3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483607, 4, 1, 'axz', '2022-04-24 00:17:28+00:00', 1, '90nhsp9gobb6', 'rn5u', 'phy');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483606, 4, 1, 'a', '2023-03-12 17:13:38+00:00', 1, 'hvyx8s', 'r', 'fs3qn0b');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483605, 4, 1, 'rlxcrwfx', '2023-06-27 23:15:54+00:00', 1, '3rzgz84lqm', '2w', 'b1b3vun66e0i');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483604, 4, 1, 't07', '2023-07-11 13:41:18+00:00', 1, 'zi90o50q83', 'g865zm6d', 'ewew');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483603, 4, 1, 'p40u2vil21x', '2022-05-25 00:15:10+00:00', 1, 'd', '6q5ziqoauy0', '3lwh994f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483602, 1690470489, 1, 'q', '2021-07-18 11:51:01+00:00', 1, 'c8cwvad', 'p', '760ugk2');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1507399154, 3, 'pg1lcg', '2024-09-08 12:45:04+00:00', 3, '4', 'kj', 'og8dw16f5tqh');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 1, 7, 'd5m', '2020-02-04 08:44:03+00:00', 5, 'm', 'kr2tzdlb6i42', 'tew5c29d');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (13, 1, 1, '9uxj4hw', '2020-03-11 08:08:02+00:00', 8, 'v', 'ph2', 'nd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, 1, 5, 'qcx5', '2025-05-27 16:57:17+00:00', 5, 'nc', 'rjtu', 'dz79fjg');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 1235416111, 8, 'jh3den8', '2025-01-28 02:00:27+00:00', 6, 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, -1171104889, 10, '5zi36c4bfkfo', '2020-02-08 07:26:28+00:00', 7, 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, -1179823637, 11, 'rqro', '2025-10-15 06:50:58+00:00', 9, 'qy', '5s5b', 'p');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483594, 328305758, 10, 'tliqa1', '2023-08-19 04:29:46+00:00', 4, 'yytoo', 'o9hl72kl', 'x1');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1, NULL, 7, 'value', '2024-06-15 00:00:00+00:00', 2, 'value', 'value', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.UserId FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T3.ViewCount >= 1000 GROUP BY T2.UserId HAVING COUNT(DISTINCT T2.PostHistoryTypeId) = 1;

/*
Gold Result:
(3,)
(5,)
(8,)
(9,)
*/

-- Prediction Query
SELECT T2.UserId FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId WHERE T1.Views >= 1000 GROUP BY T2.UserId HAVING COUNT(DISTINCT T2.PostId) = 1;

/*
Prediction Result:
(3,)
(6,)
*/