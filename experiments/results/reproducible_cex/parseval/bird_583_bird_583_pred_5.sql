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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 244829661, -1362461264, '2022-06-17 21:46:26+00:00', -1372125820, -2031361952, 'p5qi2rk', 2, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux', -1492524358, -1612443122, -2050247126, -2147483647, '2022-10-17 07:55:28+00:00', '2021-07-30 02:29:08+00:00', 2103044118, '2020-12-31 11:15:26+00:00', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 1255343543, -541746689, '2024-12-20 11:42:02+00:00', -961217731, -1888505890, 'z16nijjai5d', 3, '2025-07-17 09:46:47+00:00', '5o', 'rg', -1478247928, 1074760385, 1129658414, 1, '2022-08-16 10:09:33+00:00', '2025-06-10 19:01:27+00:00', 1250290042, '2020-11-06 22:27:04+00:00', 'grit', 'sj3ayxp1q430');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1180042408, 199672698, '2023-06-27 00:27:42+00:00', -1962347906, -866772222, 'ttg6', 6, '2020-03-23 04:17:18+00:00', 'ou5z', '36c', 1722106924, -2072838897, -1173368267, 3, '2025-01-04 09:05:19+00:00', '2020-05-22 14:53:50+00:00', -406331049, '2023-05-04 15:58:08+00:00', 'zj', '7wgx');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1999335832, -526612570, '2023-03-04 02:34:12+00:00', -2005628382, 1721638020, '0oztdgj5i3lq', 6, '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94', -1719383707, 1273687251, 333302050, 1, '2021-08-24 18:58:08+00:00', '2021-10-18 07:51:02+00:00', -2136247961, '2021-04-29 06:47:06+00:00', 'a3o', 'v8u');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 362376128, -1311735207, '2023-10-19 18:37:00+00:00', -1252009958, 1908593332, 'vy', 6, '2023-05-05 20:15:58+00:00', 'zzbe8yvkv', '42q7sx58b4', -1122409769, 1849819405, -929383517, -2147483647, '2020-02-11 09:48:43+00:00', '2022-09-08 09:11:51+00:00', -699574669, '2021-05-14 07:56:41+00:00', 'rpdjwzw5ch', '9mo7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, 628082526, -1245584612, '2021-04-02 17:49:19+00:00', -582376271, -1165594842, 'szdo2z', 6, '2024-10-15 01:24:38+00:00', 'bb0q', '0k32odwcl5a', 292557306, 709097796, -984562992, 3, '2023-01-20 18:10:08+00:00', '2023-03-23 15:19:54+00:00', -1689155697, '2023-08-12 12:46:14+00:00', 'j', '9erhizgk1yoe');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 513375398, 718167481, '2023-07-16 23:01:09+00:00', -1614619556, 1435223075, 'qyxuzk', 1, '2020-03-04 20:06:24+00:00', '521gwnlas6e', 'lboeowii1z5', 1557188093, 548968280, -1552469358, 3, '2024-05-19 10:57:10+00:00', '2024-04-07 18:10:54+00:00', -251205568, '2023-10-18 11:51:31+00:00', 'lyotow', 'oaawg96aq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -381485009, 868039568, '2025-04-01 08:16:25+00:00', -1216952047, -457901285, 'tajz9td8n', 1, '2025-07-30 07:59:24+00:00', '5wcgumbc3td', 'u6bd0w9603', -541917667, -961629819, 2012400150, 1, '2025-09-23 03:38:51+00:00', '2024-09-21 06:52:15+00:00', -505019168, '2021-05-30 10:13:06+00:00', 'qk162nh55', '3dohvu0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -921187550, -2070843029, '2022-01-05 17:19:47+00:00', 2, 882961052, '2eutliqa11r', 5, '2023-03-22 03:47:49+00:00', 'ytoo3o9hl7', 'klex14ji', -453362185, 481163439, 2123196517, 3, '2025-11-10 22:24:59+00:00', '2020-06-29 05:47:52+00:00', 1485335077, '2024-12-22 09:14:04+00:00', 'rq13pyu', '8d99rljsl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1692174491, -1025564911, '2023-10-21 02:54:45+00:00', 3, -975213201, '9v', 1, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, 4, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1583472758, 1449284300, '2022-04-26 08:43:58+00:00', 1, -1714354341, '8', 9, '2023-04-21 03:11:26+00:00', 't1afgog', 'itsj3', -491938169, -106471771, 1235416111, 2, '2023-08-17 20:15:35+00:00', '2024-11-10 21:13:22+00:00', -1538707438, '2023-12-06 02:24:58+00:00', 'e', '8c68');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1774087382, 1732258051, '2024-05-22 05:48:31+00:00', 1, 1523825314, 'u5', 9, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, 5, '2024-03-11 08:01:44+00:00', '2025-11-17 07:39:50+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 199672698, 2119806856, '2025-08-02 16:41:48+00:00', -1962347906, -866772222, 'ttg6', 8, '2020-03-23 04:17:18+00:00', 'ou5z', '36c', 1722106924, -2072838897, -1173368267, 9, '2025-01-04 09:05:19+00:00', '2020-05-22 14:53:50+00:00', -406331049, '2023-05-04 15:58:08+00:00', 'zj', '7wgx');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', 10, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483647, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 328305758, -751275471, '2021-08-01 11:21:15+00:00', -1068298341, -314162272, 'ytoo3o9', 11, '2020-12-13 17:48:30+00:00', '72k', 'ex1', -74849714, 105869088, -2081315180, 10, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, -664193365, -1070063173, '2025-05-09 05:17:21+00:00', -1660358170, -1106350634, 'tu0', 13, '2020-06-29 02:04:50+00:00', '79fjgq8', 'n2f3dqv0gcb9', 172461907, 1606439408, 1443629118, 9, '2023-12-12 02:47:46+00:00', '2023-05-15 04:44:08+00:00', 1686459626, '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 15, '2023-08-17 20:15:35+00:00', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, -47052816, 9, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Yevgeny', '2022-06-06 02:35:43+00:00', 't2__98a99d', 'wqcgsk', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1179823637, '2021-09-24 11:50:48+00:00', 'Yevgeny', '2025-01-09 01:18:18+00:00', 't2__98a99d', 'rqrofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 1644911394, '2021-12-11 04:26:48+00:00', 'Yevgeny', '2024-09-13 14:36:04+00:00', 't2__98a99d', 'l7', 'klex14ji', -453362185, 481163439, 2123196517, 364869063, -953437896, '3pyu78d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 401805964, '2021-04-23 15:57:00+00:00', 'q8', '2021-10-07 12:15:00+00:00', 'f3dqv0gc', '9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 518609210, '2021-01-17 17:19:55+00:00', 'den8c68x', '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'Yevgeny', '2022-06-06 02:35:43+00:00', 't2__aa677c', 'wqcgsk', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1908028688, '2020-03-08 22:40:47+00:00', 'Yevgeny', '2022-01-03 02:42:55+00:00', 't2__aa677c', 'luhvdltti', 'bnp', 1236688122, 2087640001, 907682809, 2026480202, -1576219117, '5u');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 1861536320, '2022-12-10 02:38:39+00:00', 'klfa9000t', '2024-03-03 15:52:53+00:00', 'use_5bd1e4', '4', 'ecigce376n', 1313172851, -761141909, 283598170, 742285925, -747753377, 'nrqrofqy');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1968874827, '2022-12-08 23:34:02+00:00', 'Yevgeny', '2021-10-14 08:16:37+00:00', 'cx5hn', 'p', 'jtu0d', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -155284187, '2020-02-20 05:24:11+00:00', 'Yevgeny', '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -55602865, '2024-02-19 01:18:26+00:00', 'Yevgeny', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483636, 1019800248, '2022-11-06 10:19:41+00:00', 'l', '2022-07-30 13:34:14+00:00', 'val_1', 'ilbnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1149850321, '2020-05-18 19:45:10+00:00', 'Yevgeny', '2025-04-19 21:11:20+00:00', '37', 'nium52zbu', '4nrq', 418417917, -1031969798, -1106983592, 1884179925, 902551284, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', NULL, 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, -1116181514, '2022-03-22 13:45:21+00:00', 'Yevgeny', '2021-03-04 06:15:13+00:00', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -1612443122, -2050247126, -736979194, 2103044118, -1642259219, 'nd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', NULL, 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 138842628, '2022-05-28 16:44:30+00:00', 'Yevgeny', '2022-12-13 04:17:12+00:00', 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', NULL, 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Score), T2.WebsiteUrl FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Yevgeny' GROUP BY T2.WebsiteUrl;

/*
Gold Result:
(-1068298341, '37')
(2, 'cx5hn')
(-197933860, 'lq7xb7')
(-1660358170, 'rkf9vqx5')
(-5552898801, 't2__98a99d')
(2, 't2__aa677c')
(None, 'wqcgsk')
*/

-- Prediction Query
SELECT SUM(posts.score) AS totalscore, users.websiteurl FROM posts INNER JOIN users ON posts.lasteditoruserid = users.id WHERE users.displayname = 'Yevgeny';

/*
Prediction Result:
(-13046073591, 't2__98a99d')
*/