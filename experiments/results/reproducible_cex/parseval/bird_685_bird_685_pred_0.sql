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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, 1, 'nprmdposii', 1, '2020-08-22 06:30:10+00:00', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, 1, '2021-08-19 01:10:02+00:00', '2024-10-24 14:16:53+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1748371085, -1742081330, '2024-08-10 07:57:32+00:00', -1255130038, 1, '3d', -2147483647, '2025-08-02 02:30:29+00:00', 'qv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 37673509, 1, '2025-01-10 14:09:09+00:00', '2025-11-27 06:11:21+00:00', -1672720816, '2020-10-15 18:29:15+00:00', 'jswwlq7xb', '72fxa7ryfd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1129658414, 1250290042, '2020-11-06 22:27:04+00:00', -1194675273, -946046410, 'tsj3ayxp1q4', 2, '2023-11-21 06:57:41+00:00', '1jh3den', 'c68x8vacx', -1762140823, 1371234901, -290314193, -2147483647, '2025-10-08 08:31:18+00:00', '2020-09-07 18:22:07+00:00', -1099855564, '2021-11-28 21:12:32+00:00', '72ctdctmfg62', '0v');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1944978593, 1722106924, '2020-02-23 23:54:56+00:00', -1776877925, 1201273976, 'oacd07z2zez', -2147483647, '2021-04-04 14:38:19+00:00', '7wgx', '5', -526612570, -546516406, -405743609, 2, '2020-06-02 03:52:50+00:00', '2020-11-20 06:56:49+00:00', -20116244, '2023-11-26 16:36:47+00:00', 'q5l', 'pim5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 769234989, 168442149, '2025-03-31 02:33:27+00:00', -1853955201, 1, 'qxxnj', 4, '2020-01-09 12:53:38+00:00', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 1106724223, 1, '2025-06-29 15:21:32+00:00', '2023-03-26 14:26:48+00:00', 1487347213, '2023-03-15 00:23:20+00:00', 'yd1jmgjach8', 'qta8y3a17v4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 5, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 6, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 3, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -1025564911, -227162283, '2021-05-26 08:15:06+00:00', -705985602, 537874887, 'z0f8jegd21vy', 3, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', 'ph2', 1298861365, 1968874827, -664193365, 7, '2022-02-18 09:12:59+00:00', '2020-04-10 05:04:30+00:00', 555413010, '2025-09-07 08:46:54+00:00', 'hncprjtu', 'dz79fjg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 3, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 4, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1250290042, -1717646459, '2020-11-22 11:14:57+00:00', -946046410, -902895762, 'ayxp1q43', 6, '2023-06-28 02:52:00+00:00', 'jh3den8', 'c68x8vacx7', 1523825314, 2078438287, -47052816, 8, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 6, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 875300074, -1609653472, '2021-06-20 20:52:42+00:00', -15162884, 1339733032, 'im5k', -2147483647, '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, 9, '2021-04-29 06:47:06+00:00', '2021-07-29 14:03:28+00:00', -2096405521, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (13, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 7, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (14, -366775518, 575038073, '2021-12-14 11:59:29+00:00', -1898678660, 440115543, 'msorlwyngc', 4, '2023-08-12 12:46:14+00:00', 'j', '9erhizgk1yoe', 1483450542, 513375398, 718167481, 10, '2023-07-16 23:01:09+00:00', '2021-01-20 11:06:45+00:00', -1942581013, '2024-04-21 11:49:54+00:00', 'uq', 'xuzkb52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (15, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 2, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (16, 989306270, 1147652228, '2020-07-01 00:06:39+00:00', 1964331395, -1943814113, '9603vz', 11, '2025-10-31 13:59:15+00:00', 'xw1rxe9yfk7', 'k162n', -516345261, -1191116453, 1709667347, 11, '2022-09-26 18:21:28+00:00', '2023-07-30 22:23:05+00:00', 30861410, '2023-05-21 01:39:33+00:00', '3', 'rmkio18r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (17, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', -2147483647, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 9, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't3__1f36bd', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -305670381, '2021-03-25 19:22:18+00:00', 't3__1f36bd', '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 176555546, '2020-08-21 23:51:43+00:00', 't3__1f36bd', '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1919033056, '2021-06-04 07:47:26+00:00', 't3__1f36bd', '2022-11-17 11:44:09+00:00', 'uttmu2ne5', '78lfvyz7zz', 'be8yvkv42q7', -2060082151, -1122409769, 1849819405, -929383517, -2090240067, 'mkrpdj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1105964624, '2023-06-01 10:01:12+00:00', 'w5chn9mo705a', '2025-07-08 06:16:45+00:00', 'n0jxfofws', 'do2zobb', 'q0k32od', -613916489, 2061558815, 895277769, 364043263, -1177989415, 'wyn');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', '2020-12-13 17:48:30+00:00', '72k', 'ex1', 'ji7zwau2', 364869063, -953437896, -1097120355, 244829661, -1362461264, 'l0b4y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -658391922, '2021-07-03 08:58:16+00:00', '7xb72', '2020-09-05 12:25:49+00:00', 'a7ryfd', 'z16ni', 'jai', 1746373317, 1360271423, 1583472758, 1449284300, -977470238, 'd8y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -68044929, '2020-09-25 02:07:37+00:00', 'foa', '2025-01-04 09:05:19+00:00', 'd', '7z2zezj', '7wgx', -57705450, -915385605, -2005628382, 1721638020, 983324983, 'ztdg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -1122409769, '2020-01-08 04:07:26+00:00', 'us3auvmkrpdj', '2025-10-04 15:32:15+00:00', 'zw5chn', 'mo705a9n0', 'xfo', -1793230843, -441521858, 2015094998, 1010672881, -1197954156, '0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, -251205568, '2023-10-18 11:51:31+00:00', 'lyotow', '2024-08-29 05:28:03+00:00', 'aawg', '6aqb0tbin', 'z', 2085299664, 2038321753, 1376887048, 261633665, 748154000, 'cgumbc');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, 328305758, 1, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 777149609, 1, '16nijjai5dh', '2024-02-27 00:46:50+00:00', 2, 'Computer Game Datasets', 'grgj', '8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, -1021978385, 3, 'jpe1io22785', '2023-06-27 00:27:42+00:00', 2, 'Computer Game Datasets', '7cvtjpttg6b', 'ou5z');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1379859112, 4, 'qs27p2r94', '2020-11-05 16:17:26+00:00', 1, 'Computer Game Datasets', 'h2mna', 'jla');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1960313034, 1, 'j', '2024-09-02 12:22:50+00:00', 1, 'Computer Game Datasets', 'rh', 'izgk1yoeyo6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -1614619556, 4, '6fuqy', '2023-01-26 17:19:01+00:00', 3, 'Computer Game Datasets', 'uzkb521gwnl', 's');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -2076274980, 1, 'ow', '2021-02-07 13:23:16+00:00', 4, 'Computer Game Datasets', '1z5', 'xih6');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -1034034171, 4, 'lyotow', '2024-08-29 05:28:03+00:00', 3, 'Computer Game Datasets', 'aawg', '6aqb0tbin');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 2085299664, 1, 'j', '2023-05-09 01:10:53+00:00', 3, 'Computer Game Datasets', 'td8n5wcgu', 'bc3t');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 1964331395, 1, 'bd0w9603v', '2023-05-02 20:56:40+00:00', 4, 'Computer Game Datasets', 'xw1rxe9yfk7', 'k162n');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 956819642, 1, '5y3dohvu06d', '2023-05-21 01:39:33+00:00', 1, 'Computer Game Datasets', '3', 'rmkio18r');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, -2081662466, 3, '3qdpu', '2020-02-17 04:43:11+00:00', 4, 'Computer Game Datasets', '96rn', 'dqrhm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, 899787662, 3, 'n2np490xdms', '2022-03-21 02:41:13+00:00', 2, 'Computer Game Datasets', 'gelcu', 'qb9i9f2ccu');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, -1575692857, 3, 'yhb08hl', '2022-06-07 15:54:39+00:00', -2147483647, 'Computer Game Datasets', 't1pqomiztvb6', '4iz7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, 1728201214, 1, 'ud8', '2020-09-11 22:26:51+00:00', 1, 't1__67fead', 'tb8r9114qbre', '6bjeuuwsj8k');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, 1, 5, 'value', '2024-06-15 00:00:00+00:00', 2, NULL, 'value', 'value');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 902887186, 6, 'qrofqyp5s5b', '2020-03-11 14:09:37+00:00', 6, 'Computer Game Datasets', '02eu', 'liqa1');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, -1762857309, 8, 'dqv0gcb98ozk', '2023-12-12 02:47:46+00:00', 7, 'Computer Game Datasets', 'bilyrkn', '6vck6ah0f8js');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 820970595, 10, 'qdjpe1io2', '2023-10-17 13:49:58+00:00', 5, 'Computer Game Datasets', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, 1908593332, 12, 'vy', '2023-05-05 20:15:58+00:00', 9, 'Computer Game Datasets', 'zzbe8yvkv', '42q7sx58b4');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, -1250380401, 14, 's', '2024-04-30 14:56:46+00:00', 5, 'Computer Game Datasets', 'elboeowii1', '5nxih66');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, 1677948887, 16, 'y08ftp6ewt', '2022-03-03 17:20:50+00:00', 7, 'Computer Game Datasets', 'xnjaby', 'mzn2mfx7h3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(1, 't3__1f36bd')
(1, 't3__1f36bd')
(-946046410, 't3__1f36bd')
(1201273976, 't3__1f36bd')
(1, 't3__1f36bd')
(1201273976, 't3__1f36bd')
(1, 't3__1f36bd')
(1201273976, 't3__1f36bd')
(1, 't3__1f36bd')
(-946046410, 't3__1f36bd')
(-946046410, 't3__1f36bd')
(-946046410, 't3__1f36bd')
(1, 't3__1f36bd')
(1, 't3__1f36bd')
(1019800248, 'wwqcg')
(537874887, 'ytoo3o9')
(-902895762, '7xb72')
(1339733032, 'foa')
(440115543, 'us3auvmkrpdj')
(-1943814113, 'lyotow')
*/

-- Prediction Query
SELECT T1.ViewCount, T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title = 'Computer Game Datasets';

/*
Prediction Result:
*/