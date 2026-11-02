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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1649269347, 'p5qi2rkf9v', 1, '2022-03-30 02:18:34+00:00', 'Analysing wind data with R', 'x58pz0f8je', 1196308825, 910894705, -283454505, -2147483647, '2023-04-27 18:28:48+00:00', '2025-07-25 08:53:04+00:00', 233994589, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 32204797, -1672720816, '2020-10-15 18:29:15+00:00', 138842628, -932772113, 'lq7xb7', 1, '2025-04-29 15:45:27+00:00', 'Analysing wind data with R', '2fxa7ryfdrz', 61479715, -1496556994, -2115841792, 1, '2024-03-27 22:48:03+00:00', '2020-07-12 19:51:25+00:00', -1625552518, '2021-12-10 17:04:01+00:00', 'rg', 'd8y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 87529806, -1957268147, '2020-06-07 10:59:23+00:00', 481546706, -1784554553, '2g0v5q8qd', 1, '2025-05-19 01:18:37+00:00', 'Analysing wind data with R', 'pe1', -1180042408, 199672698, 2119806856, -2147483645, '2025-08-02 16:41:48+00:00', '2024-06-06 16:33:41+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -604098478, 1248858185, '2020-06-06 19:46:47+00:00', 1999335832, -526612570, 'cmr0oz', 1, '2022-07-12 13:13:05+00:00', 'Analysing wind data with R', 'g', -20116244, -176606723, -15162884, -2147483647, '2021-11-07 05:17:12+00:00', '2022-01-04 01:02:12+00:00', 1692046802, '2021-09-04 22:07:03+00:00', 'k58qs27p', 'r94gth2m');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, -663234145, -2013213247, '2021-10-23 07:09:38+00:00', 234957614, 823835795, '05a9n0jxf', 1, '2021-12-11 06:40:50+00:00', 'Analysing wind data with R', 'ws', 1719800120, -210159774, 270415200, -1, '2020-02-24 22:37:14+00:00', '2020-04-02 11:13:10+00:00', -397848196, '2025-04-29 20:31:18+00:00', '0k32odwcl5a', 'msorlwyngc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -1614619556, 1435223075, '2022-09-04 15:41:16+00:00', -477129795, -1418927432, '521gwnlas6e', 1, '2025-09-08 01:16:35+00:00', 'Analysing wind data with R', 'boe', -1159083009, -1589605308, -268740517, -2147483645, '2024-03-11 19:06:57+00:00', '2021-10-05 09:01:22+00:00', 548968280, '2021-03-06 10:06:33+00:00', '66', 'q2xlyoto');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, -1046720861, 643589729, '2021-10-24 14:42:01+00:00', -516345261, -1191116453, 'u06dza', 1, '2023-12-12 21:29:29+00:00', 'Analysing wind data with R', 'rmkio18r', 431832073, 1510892261, 1677948887, -2147483644, '2025-01-09 08:20:29+00:00', '2023-03-14 06:45:13+00:00', -1853955201, '2022-08-28 09:41:49+00:00', 'xxnja', 'bymzn2mfx7h3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 1584429327, -1575692857, '2023-09-17 07:05:21+00:00', -1670335771, 1862728578, 't1pqomiztvb6', 1, '2021-09-01 18:50:29+00:00', 'Analysing wind data with R', 'iz78aqql', -753065777, 190510318, -835782528, -2147483642, '2024-08-19 12:45:04+00:00', '2022-05-23 00:59:46+00:00', -312228770, '2024-02-13 02:51:20+00:00', 'bre6b', 'jeuuwsj8kj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1019350771, -225571092, '2023-09-26 01:51:36+00:00', 944310519, 6224071, 'dlysu6iphd', 1, '2021-06-07 11:18:19+00:00', 'Analysing wind data with R', 'u2gir31vwq5', -299585625, -2014514218, -1184608964, 1, '2023-08-04 14:43:35+00:00', '2022-01-28 08:10:37+00:00', -1971610898, '2022-12-05 03:41:58+00:00', 'yqro', 'uirlrpouit');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1589523321, 586437419, '2020-09-16 01:34:18+00:00', 1394459557, -1335280432, 'wpp26mb3aj0j', 1, '2022-09-19 11:14:39+00:00', 'Analysing wind data with R', '0h3r133ir1ax', -485095266, -1617977597, -1366005916, -2147483640, '2021-02-10 22:21:32+00:00', '2024-09-16 02:54:30+00:00', -1837449583, '2020-02-12 00:42:02+00:00', '8pgc', 'qwt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483637, -1640621748, 253464886, '2025-10-25 17:35:40+00:00', -1066046077, 972991637, 'u331spxpw', 1, '2023-12-04 23:08:20+00:00', 'Analysing wind data with R', 'bgwkxgi', 404445908, -1919229426, 495658460, -2147483645, '2021-08-02 14:59:03+00:00', '2023-10-28 13:45:31+00:00', 1069076646, '2023-11-26 00:12:14+00:00', 'k', '62ocagj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483636, -220327705, -344881050, '2023-10-11 16:36:28+00:00', 8608094, -1863057592, 'xjhcf46cf', 1, '2024-11-14 09:09:26+00:00', 'Analysing wind data with R', 'erxa', -329270684, -1517724233, -1265768652, 1, '2023-12-24 22:02:49+00:00', '2020-07-13 02:49:45+00:00', -1891572006, '2021-11-17 05:42:02+00:00', 'uez', 'ctehia3cmvb');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483635, -635922435, -150306637, '2021-07-03 05:10:00+00:00', 979098248, -113489293, '795ybv8', 1, '2023-11-11 18:56:57+00:00', 'Analysing wind data with R', 'r3w', 1347243533, 1099005231, -1213283783, -1, '2023-05-04 12:29:43+00:00', '2023-09-05 18:09:16+00:00', 643485636, '2020-11-24 12:33:47+00:00', 'jac', 'gmukfb5if4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 2, '2020-03-11 00:23:16+00:00', 't2__a209e0', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 3, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, -2147483637, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 4, '2020-03-11 00:23:16+00:00', 'Analysing wind data with R', 'nprmdposii', -1823627488, -1209887326, -1399556171, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1666765085, 1178636309, '2021-07-01 18:29:24+00:00', -305670381, -1525670226, '7zwau2dwyr', 5, '2022-03-25 08:00:08+00:00', 'Analysing wind data with R', '3pyu78d', -977635379, 1661181156, -1372125820, 4, '2020-03-25 00:00:06+00:00', '2023-12-31 18:03:51+00:00', 1649269347, '2025-02-03 05:21:58+00:00', '5qi2', 'kf9vq');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__07d556', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1106983592, '2022-06-06 01:51:46+00:00', 't1__07d556', '2024-04-01 02:40:29+00:00', 'bbp02eutliqa', '1ryytoo', 'o9hl72kl', -305670381, -1525670226, -453362185, 481163439, 2123196517, 'dwyrq13pyu78');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -988981234, '1970-01-01 00:00:01+00:00', 't1__07d556', '2022-08-03 01:56:16+00:00', '0dz79f', 'gq8', 'n2f3dqv0gcb9', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483645, -598313376, '1970-01-01 00:00:00+00:00', 't1__eed73a', '2023-08-04 05:42:30+00:00', '4301j', '3d', 'n8', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, '1of77p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, 1803796945, '1970-01-01 00:00:00+00:00', 't1__eed73a', '2022-11-17 11:44:09+00:00', 'uttmu2ne5', '78lfvyz7zz', 'be8yvkv42q7', -2060082151, -1122409769, 1849819405, -929383517, -2090240067, 'mkrpdj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, 868039568, '1970-01-01 00:00:00+00:00', 't1__eed73a', '2025-04-01 08:16:25+00:00', 'dz39', 'ajz9t', '8', 748154000, 1148916014, -1988582944, -794767771, 989306270, 'tdu6bd0w96');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 1728926031, '1969-12-31 23:59:59+00:00', 't1__eed73a', '2024-02-16 17:13:12+00:00', 'nzy', '7dyyd', 'jmgjach', 1122899168, -161108900, -735270562, 614314115, 306260487, 'y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 2013152515, '1970-01-01 00:00:01+00:00', 't1__07d556', '2020-06-09 09:52:21+00:00', 'rhm5w', 'ic7', 'dn2np490xdm', 1996699977, -1027584872, -1685482179, -1391541536, -1025517017, 'i9f2ccukj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, -1040951738, '1970-01-01 00:00:00+00:00', 't1__eed73a', '2024-12-16 15:00:57+00:00', 'ncgc8s3b7v8', 'kwdmdbdht', 'j47nxar50', -913430713, -1652411404, -553121210, 1720208360, -1243923337, 'fwxqrl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -966886446, '1969-12-31 23:59:59+00:00', 't1__eed73a', '2020-07-17 02:02:33+00:00', 'axc1clu', 'gly7', '8oitxeilpe0', -1958403507, 72217086, -392891099, 1529023742, 1735624376, 'hds');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, -2051917235, '1970-01-01 00:00:00+00:00', 't1__eed73a', '2020-07-25 14:10:53+00:00', 'cde4uekhl', 'lbwvdpu5v0e', 'u', -699425950, -432771718, 516500236, 171585273, 1870044139, 'oepacx');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483637, -1745755546, '1970-01-01 00:00:00+00:00', 't1__eed73a', '2021-12-05 03:29:21+00:00', '1esks', '9q', '2qg01huij', 128895724, -1663813652, 1094664154, -1728059226, 1652765764, 'qjlsawsp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 373262291, '2023-04-26 07:28:40+00:00', '5s5b', '2020-03-11 14:09:37+00:00', '02eu', 'liqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1155439218, '2021-02-10 21:10:52+00:00', 'm52zbu', '2021-11-30 23:39:10+00:00', 'nrqrofqy', '5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 't3__21dde3', '2025-10-19 18:29:54+00:00', 1, 'rofqy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, 1, 580968159, 't3__21dde3', '2021-10-14 14:41:11+00:00', -2147483647, 'p');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 1, 600440952, 't3__85e530', '2020-02-01 05:25:26+00:00', -2147483647, 'fgogritsj3ay');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 1, -1776877925, 't3__85e530', '2020-10-11 01:34:34+00:00', 1, 'oacd07z2zez');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 1, -1524425594, 't3__85e530', '2021-07-29 14:03:28+00:00', 1, '3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 1, 681061317, 't3__85e530', '2020-12-05 23:36:13+00:00', -2147483644, 'izgk1yoeyo6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, 727608179, 't3__85e530', '2025-12-04 20:24:52+00:00', -2147483644, 'awg96aqb0t');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, -541917667, 't3__85e530', '2023-09-10 07:58:54+00:00', -2147483643, 'xe9yf');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, 63063873, 't3__85e530', '2022-08-01 13:51:03+00:00', -2147483647, '1cj8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, 1, -1941472821, 't3__85e530', '2025-06-16 07:53:05+00:00', -2147483642, 'ap96rn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, 1, -609840352, 't3__85e530', '2023-02-19 09:49:51+00:00', 0, 'lvrisurz0k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, 1, -300547632, 't3__85e530', '2022-05-03 20:38:07+00:00', -2147483642, 'dqtsmg97');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, 1, -1042838119, 't3__85e530', '2020-08-07 10:08:52+00:00', 0, 'ktb1d2nzg3rj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, 1, 1125564712, 't3__85e530', '2023-10-16 11:45:57+00:00', -2147483640, 'a8d');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483634, 1, 826141460, 't3__85e530', '2022-03-29 23:19:21+00:00', -1, '9yrnxs6d');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, 1, 134065688, 't3__85e530', '2023-11-18 04:54:23+00:00', 0, 'gvplj9fjvu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483632, 1, 720126052, 't3__85e530', '2025-07-01 21:03:25+00:00', -2147483642, 'my1ogyv1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483631, 1, -696200137, 't3__85e530', '2023-06-10 06:35:40+00:00', -2147483647, 'lu49ku');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483630, 1, 848275284, 't3__85e530', '2025-09-17 05:54:13+00:00', -2147483640, 'c0xf');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483629, 1, 143843552, 't3__85e530', '2022-08-22 21:24:27+00:00', -2147483637, 'rb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 4, 1155439218, 'um5', '2023-11-07 12:14:47+00:00', 0, 'zbuo4nrqrof');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 5, 1485335077, 'yrq13pyu78d9', '2024-09-26 13:13:01+00:00', 1, 'ljsl0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 4, 1, NULL, '2024-06-15 00:00:00+00:00', -2147483640, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, -2147483637, 1, NULL, '2024-06-15 00:00:00+00:00', 5, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None, 't1__07d556')
*/

-- Prediction Query
SELECT comments.Text, users.DisplayName FROM comments INNER JOIN posts ON comments.PostId = posts.Id INNER JOIN users ON comments.UserId = users.Id WHERE posts.Title = 'Analysing wind data with R' ORDER BY comments.CreationDate DESC, comments.id NULLS LAST, posts.id NULLS LAST, users.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('t3__85e530', 't1__eed73a')
('t3__21dde3', 't1__07d556')
('t3__85e530', 't1__eed73a')
('t3__85e530', 't1__eed73a')
('t3__85e530', 't1__eed73a')
(None, 'm52zbu')
('t3__85e530', 't1__07d556')
('t3__85e530', 't1__eed73a')
('t3__85e530', 't1__eed73a')
('t3__85e530', 't1__07d556')
*/