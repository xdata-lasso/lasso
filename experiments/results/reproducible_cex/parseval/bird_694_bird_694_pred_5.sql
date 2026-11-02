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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'Analysing wind data with R', 'e5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 2103044118, -1642259219, '2020-12-04 21:49:29+00:00', -1264842910, -1052964641, 'qcx5', 2, '2025-05-27 16:57:17+00:00', 'Analysing wind data with R', 'nc', 1575412235, -988981234, -841004020, 1, '2023-07-15 22:31:56+00:00', '2020-06-29 02:04:50+00:00', 401805964, '2021-04-23 15:57:00+00:00', 'q8', 'n2f3dqv0gcb9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 1, '2023-08-17 20:15:35+00:00', 'Analysing wind data with R', 'jh3den8c68', -683007527, 2035306060, 1523825314, 3, '2020-10-05 17:58:46+00:00', '2022-09-01 11:41:59+00:00', 1371234901, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, -242584410, -698610044, '2025-11-17 07:39:50+00:00', -1021978385, 569007824, 'e1io', 1, '2023-10-10 11:56:21+00:00', 'Analysing wind data with R', '78507cvt', -1523347137, 1582582341, 453836040, 1, '2020-11-29 15:34:58+00:00', '2024-05-07 03:46:17+00:00', 1467355421, '2021-11-07 01:38:36+00:00', 'u5zi', '6c4bfkfo');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1378873397, 1964331395, '2024-04-21 17:44:41+00:00', 1295379066, 1071401016, 'w9603vz', 1, '2025-10-31 13:59:15+00:00', 'Analysing wind data with R', 'xw1rxe9yfk7', -1046720861, 643589729, -1231488097, 0, '2024-03-03 12:11:16+00:00', '2025-10-15 00:12:43+00:00', -516345261, '2020-05-31 03:27:03+00:00', 'ohvu06dza3', 'rmkio18r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1299171592, 2066302536, '2024-04-19 20:17:36+00:00', -1853955201, -805997097, 'xnjaby', 1, '2025-03-02 19:27:14+00:00', 'Analysing wind data with R', 'zn2m', -1810873111, 1243701948, -156175571, 2, '2022-01-25 01:36:36+00:00', '2024-05-18 01:33:40+00:00', -891525031, '2021-12-19 14:23:57+00:00', 'cj8sh5k', 'zys7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -1502591405, -2008781089, '2024-07-16 00:46:06+00:00', 973811121, 280292620, 'a8y3a17v4yg', 1, '2024-11-09 23:43:28+00:00', 'Analysing wind data with R', 'ayq3', 1432875972, 1032339628, 608093726, 3, '2020-02-17 04:43:11+00:00', '2022-01-07 23:30:42+00:00', -845136979, '2022-03-09 23:28:22+00:00', 'hm5wl', 'c7d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, -592014051, 1744849810, '2025-02-20 13:44:44+00:00', 1996699977, -1027584872, 'el', 1, '2020-05-04 22:25:03+00:00', 'Analysing wind data with R', 'qb9i9f', -788896327, -1541581575, -325680600, -2147483642, '2022-09-04 04:40:22+00:00', '2021-02-17 14:55:24+00:00', -1459013972, '2025-12-05 08:19:48+00:00', 'yhb08hlst1p', 'qomiztvb6m');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -1370566258, 948460309, '2020-03-09 05:15:04+00:00', 192271618, -312228770, 'qbre6bje', 1, '2024-12-21 23:01:28+00:00', 'Analysing wind data with R', 'uwsj8k', -1486030107, 1138926079, -609840352, 0, '2023-02-19 09:49:51+00:00', '2025-03-20 08:27:04+00:00', 1939337883, '2022-04-12 19:37:51+00:00', 'sur', '0kaqtnc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 4, '2020-03-11 00:23:16+00:00', 't2__6e13f2', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 5, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 4, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 6, '2020-03-11 00:23:16+00:00', 'Analysing wind data with R', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1585009206, -53231346, '2025-09-21 09:36:38+00:00', -443340271, 757448742, '4nrq', 7, '2025-01-30 02:54:07+00:00', 'Analysing wind data with R', 'ofqyp', -921187550, -2070843029, 328305758, 5, '2022-10-06 23:43:31+00:00', '2022-07-13 23:48:43+00:00', -1347802441, '2022-02-19 15:51:21+00:00', '1', 'ryytoo3');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__f6bf72', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1106983592, '2022-06-06 01:51:46+00:00', 't1__f6bf72', '2024-04-01 02:40:29+00:00', 'bbp02eutliqa', '1ryytoo', 'o9hl72kl', -305670381, -1525670226, -453362185, 481163439, 2123196517, 'dwyrq13pyu78');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 244829661, '2021-07-21 20:51:39+00:00', 't1__f6bf72', '2021-03-27 18:00:10+00:00', 'l0b4y', 'p5qi2rkf9v', 'x58pz', -1529584866, 1196308825, 910894705, -283454505, 233994589, 'j4hwbd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -1520489792, '1970-01-01 00:00:01+00:00', 't1__f6bf72', '2022-12-13 04:17:12+00:00', 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1448731351, '1970-01-01 00:00:00+00:00', 't1__7d790a', '2024-06-13 19:21:11+00:00', 'wgxd5ysxcm', '0oztd', 'j5', -1609653472, -1405314653, 1816660482, -1212676731, 1692046802, '5k58');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -1428186898, '1970-01-01 00:00:00+00:00', 't1__7d790a', '2024-08-16 16:07:41+00:00', 'uttmu2ne578', 'fvy', '7zzbe8y', -705922211, 1043710187, 318331233, -233617564, 79330142, '58b4pm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 628082526, '1969-12-31 23:59:59+00:00', 't1__7d790a', '2025-07-08 06:16:45+00:00', 'n0jxfofws', 'do2zobb', 'q0k32od', -613916489, 2061558815, 895277769, 364043263, -1177989415, 'wyn');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, -360096930, '1970-01-01 00:00:00+00:00', 't1__7d790a', '2020-05-28 05:20:14+00:00', '6fuqy', 'uzkb52', 'gwnlas6', -2076274980, 1731324803, -1159083009, -1589605308, -268740517, 'nxih662q');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 1501227157, '1969-12-31 23:59:59+00:00', 't1__7d790a', '2025-10-12 19:34:35+00:00', 'v88kwdmdb', 'h', '6j47n', -556370776, 1144507576, -343920305, 460471995, -1515201134, 'n');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -1040088060, '1970-01-01 00:00:00+00:00', 't1__7d790a', '2021-06-25 02:35:55+00:00', 'w', '014', '5dqts', -1340460158, -2098439423, -459764012, -1148194959, 944310519, '6dd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, -269868995, '1970-01-01 00:00:00+00:00', 't1__7d790a', '2023-01-05 08:50:12+00:00', 'q51oa2sb3u', 'i1pa', 'cvwnyq', -1005394301, 917675957, -1582954378, -1143329124, 1368469085, '63xyf');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 373262291, '2023-04-26 07:28:40+00:00', '5s5b', '2020-03-11 14:09:37+00:00', '02eu', 'liqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 't3__cbeaaf', '2025-10-19 18:29:54+00:00', 1, 'rofqy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, -1454058168, 't3__cbeaaf', '2023-05-15 04:44:08+00:00', 3, 'i');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, 982314585, 't3__cbeaaf', '2022-05-18 00:14:53+00:00', 1, 'kn6vck6ah0f8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -1, -406331049, 't3__3d3524', '2023-05-04 15:58:08+00:00', 1, 'zj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 1, 1055237066, 't3__3d3524', '2023-11-07 06:34:01+00:00', 0, '94gth');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -1, -2136247961, 't3__3d3524', '2021-04-29 06:47:06+00:00', 2, 'a3o');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, 1164790775, 't3__3d3524', '2023-11-09 04:27:38+00:00', 3, 'u');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 0, -1140595602, 't3__3d3524', '2021-03-23 21:08:32+00:00', 0, 'wzw5chn9mo70');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, -323362455, 't3__3d3524', '2025-02-24 09:11:47+00:00', 1, '9er');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, -1, -413043724, 't3__3d3524', '2025-10-05 07:32:01+00:00', -2147483643, '1yo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, 0, 412199481, 't3__3d3524', '2022-08-25 00:08:33+00:00', -2147483642, 'ow9oaawg96a');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, -1, 868039568, 't3__3d3524', '2025-04-01 08:16:25+00:00', 0, 'dz39');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, 1, 261633665, 't3__3d3524', '2020-06-02 05:30:58+00:00', -2147483642, 'n5wcgumbc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, -1, -1243923337, 't3__3d3524', '2023-01-06 21:15:07+00:00', -1, 'wx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483634, -1, 1193656937, 't3__3d3524', '2025-01-08 04:15:41+00:00', -2147483643, 'phdku2gir3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, 0, -1094296226, 't3__3d3524', '2023-09-29 04:33:18+00:00', -2147483643, 'mb3aj0ju0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 2, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', -2147483641, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 3, 1485335077, 'yrq13pyu78d9', '2024-09-26 13:13:01+00:00', 1, 'ljsl0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483641, 1, NULL, '2024-06-15 00:00:00+00:00', -2147483640, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 5, 226938182, '72k', '2021-07-01 18:29:24+00:00', -1, 'x1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('72k', None)
*/

-- Prediction Query
SELECT comments.text, comments.userdisplayname FROM comments INNER JOIN posts ON comments.postid = posts.id WHERE posts.title = 'Analysing wind data with R' ORDER BY comments.creationdate DESC, comments.id NULLS LAST, posts.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('t3__cbeaaf', 'rofqy')
('t3__3d3524', '1yo')
('t3__3d3524', 'dz39')
('t3__3d3524', '9er')
('t3__3d3524', 'phdku2gir3')
(None, 'value')
('t3__3d3524', 'u')
('t3__3d3524', '94gth')
('t3__3d3524', 'mb3aj0ju0')
('t3__cbeaaf', 'i')
*/