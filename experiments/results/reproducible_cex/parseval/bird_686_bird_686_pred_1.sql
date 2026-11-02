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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 0, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 775304493, 373262291, '2023-04-26 07:28:40+00:00', -1106983592, -1, '5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, -2147483648, '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00', -74849714, '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 0, 'p5qi2rk', -2147483648, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux', -1492524358, -1612443122, -2050247126, -2147483648, '2022-10-17 07:55:28+00:00', '2021-07-30 02:29:08+00:00', 2103044118, '2020-12-31 11:15:26+00:00', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1748371085, -1742081330, '2024-08-10 07:57:32+00:00', -1255130038, -1, '3d', -2147483648, '2025-08-02 02:30:29+00:00', 'qv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 37673509, -2147483648, '2025-01-10 14:09:09+00:00', '2025-11-27 06:11:21+00:00', -1672720816, '2020-10-15 18:29:15+00:00', 'jswwlq7xb', '72fxa7ryfd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 61479715, -1496556994, '2020-01-23 21:20:16+00:00', -7597509, 0, 'h5ogrgjd8yz', -2147483648, '2022-08-16 10:09:33+00:00', '1afgogritsj', 'ayxp1q43', 1235416111, 1923912467, 518609210, -2147483648, '2021-01-17 17:19:55+00:00', '2023-12-06 02:24:58+00:00', 1476361420, '2021-11-04 04:05:36+00:00', 'c68x8vacx', 'afu5w1of7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 87529806, -1957268147, '2020-06-07 10:59:23+00:00', 481546706, -1, 'g6', -2147483648, '2023-10-09 23:10:02+00:00', '0v', 'q8qdjpe1', -1180042408, 199672698, 2119806856, -2147483648, '2025-08-02 16:41:48+00:00', '2024-06-06 16:33:41+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -2072838897, -1173368267, '2025-01-04 09:05:19+00:00', -1950324754, 0, '7z2zezj', -2147483648, '2021-12-22 04:28:19+00:00', 'wgxd5ysxc', 'r0oz', -870767087, -1699185893, 875300074, -2147483648, '2021-01-24 01:19:46+00:00', '2023-11-26 16:36:47+00:00', -1405314653, '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1273687251, 333302050, '2021-08-24 18:58:08+00:00', 418247369, -1, 'jla', -2147483648, '2023-12-07 12:32:22+00:00', 'okv8uttmu2', 'e578', 1908593332, 697257217, -451030047, -2147483648, '2025-05-30 03:33:11+00:00', '2025-02-28 08:35:18+00:00', -2052653308, '2024-08-15 05:55:27+00:00', 'yvkv42q7sx58', 'b4pmaus3auv');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -1140595602, -609553675, '2022-12-09 16:13:13+00:00', -55494714, 0, 'n9', -2147483648, '2021-08-16 22:45:01+00:00', 'o705a9n0jxfo', 'ws', 1719800120, -210159774, 270415200, -2147483648, '2020-02-24 22:37:14+00:00', '2020-04-02 11:13:10+00:00', -397848196, '2025-04-29 20:31:18+00:00', '0k32odwcl5a', 'msorlwyngc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 453340472, 211603887, '2025-05-23 18:24:29+00:00', 681061317, -1, 'iz', -2147483648, '2020-11-27 04:53:28+00:00', 'k1yoeyo6l0h', 't', -795975227, 1294064538, 778835680, -2147483648, '2023-05-18 17:35:26+00:00', '2021-06-11 00:32:43+00:00', 450555855, '2023-11-05 01:08:45+00:00', 'gwnlas6', 'elboeowii1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 1557188093, 548968280, '2021-03-06 10:06:33+00:00', -251205568, 0, 'xlyotow9', -2147483648, '2021-12-24 12:13:22+00:00', 'aawg96aqb0tb', 'indz39tajz', 261633665, 748154000, 1148916014, -2147483648, '2020-04-24 22:41:34+00:00', '2020-11-23 15:43:29+00:00', -794767771, '2020-04-05 13:31:14+00:00', '3', 'tdu6bd0w96');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (13, -541917667, -961629819, '2020-07-22 23:26:49+00:00', -505019168, -1, '7qk', -2147483648, '2024-12-06 05:16:35+00:00', '162nh55y3d', 'ohvu06dza3', 1595632888, 2072023304, 789756515, -2147483648, '2021-12-14 20:39:54+00:00', '2023-08-06 06:41:23+00:00', 769234989, '2025-01-05 20:14:57+00:00', 'ftp6ewtqx', 'njabym');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (14, -224390110, -1810873111, '2024-06-12 11:15:53+00:00', -1659775598, 0, 'p6sto1cj', -2147483648, '2024-08-04 01:35:33+00:00', 'h5knz', 'ys7dyyd1jmg', 729543907, -2108844113, 973811121, -2147483648, '2024-10-22 04:53:36+00:00', '2022-08-08 19:19:58+00:00', 620355627, '2025-04-13 01:34:03+00:00', 'y3a17v4yg', 'mayq3qdpua');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (15, 1982265552, 2013152515, '2020-06-09 09:52:21+00:00', -1042976410, -1, 'm5', -2147483648, '2025-01-14 14:36:19+00:00', 'wlic7dn2np', '90xdmsqt', -1685482179, -1391541536, -1025517017, -2147483648, '2024-09-18 21:46:55+00:00', '2021-03-03 11:42:43+00:00', 238243966, '2023-10-20 18:15:15+00:00', 'ccukjq1qui', '1yh');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (16, 166124233, 1862197286, '2022-06-07 15:54:39+00:00', 1909521477, 0, 'qomi', -2147483648, '2023-06-06 02:04:32+00:00', 'tvb6m4iz78', 'q', -1043357093, -753065777, 190510318, -2147483648, '2022-08-06 20:35:20+00:00', '2020-03-09 05:15:04+00:00', 192271618, '2025-08-17 22:42:43+00:00', '114qbre6b', 'jeuuwsj8kj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (17, -609840352, 486475144, '2025-04-06 16:59:59+00:00', 1939337883, -1, 'isurz', -2147483648, '2023-06-26 09:26:27+00:00', 'aqt', 'ncgc8s3b7v', 180947503, -622923312, 1789767331, -2147483648, '2020-07-06 15:58:49+00:00', '2020-02-25 20:54:19+00:00', -1924635316, '2022-07-31 04:43:08+00:00', 'j47nxar50', 'sj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (18, -553121210, 1720208360, '2022-10-01 02:03:07+00:00', 2014610660, 0, 'wfwx', -2147483648, '2022-03-12 01:37:04+00:00', 'lawk0', '14r5dqtsmg97', -2098439423, -459764012, -1148194959, -2147483648, '2023-07-12 01:39:56+00:00', '2022-02-11 21:53:49+00:00', 6224071, '2024-10-14 09:14:29+00:00', 'dlysu6iphdk', 'u2gir31vwq5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (19, -2014514218, -1184608964, '2023-08-04 14:43:35+00:00', 473443538, -1, 'cvwnyq', -2147483648, '2022-04-06 03:56:24+00:00', 'uirl', 'rpouit63xyf', 1394459557, -1335280432, -614741184, -2147483648, '2022-01-23 00:40:27+00:00', '2023-09-29 04:33:18+00:00', -1305057240, '2023-12-03 17:16:54+00:00', 'j', '0ju0h3r133ir');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (20, -569461411, 1498496406, '2022-01-24 14:05:23+00:00', -1366005916, 0, '9es', -2147483648, '2020-02-12 00:42:02+00:00', '8pgc', 'qwt', 1339281953, -69263912, 17776256, -2147483648, '2021-04-19 20:41:37+00:00', '2020-08-07 10:08:52+00:00', 889799750, '2022-07-20 07:38:42+00:00', '1', '2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (21, -1517965246, 1807244612, '2024-02-02 07:56:36+00:00', -1522433566, -1, 'a8d', -2147483648, '2020-05-07 14:08:10+00:00', 'y', 'vjwq49yr', 1014871129, -583955995, -1935855834, -2147483648, '2024-11-01 17:04:58+00:00', '2020-06-20 05:52:23+00:00', -563917514, '2021-11-19 21:47:20+00:00', 'v7t3gvpl', '9fj');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM posts WHERE ViewCount > (SELECT AVG(ViewCount) FROM posts);

/*
Gold Result:
(2,)
(4,)
(6,)
(8,)
(10,)
(12,)
(14,)
(16,)
(18,)
(20,)
*/

-- Prediction Query
SELECT COUNT(*) FROM posts WHERE ViewCount > (SELECT CAST(AVG(ViewCount) AS REAL) FROM posts);

/*
Prediction Result:
(10,)
*/