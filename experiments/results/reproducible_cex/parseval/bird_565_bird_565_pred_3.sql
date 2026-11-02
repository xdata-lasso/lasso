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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, -2147483648, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2024-06-15 00:00:00+00:00', '4ecigce376n', 'um5');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -747753377, 902887186, '2025-10-19 18:29:54+00:00', -967741825, 775304493, 'qyp5s5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, -2147483648, '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00', -74849714, '2024-06-15 00:00:00+00:00', '7zw', 'au2dwyrq13');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2103044118, -1642259219, '2020-12-04 21:49:29+00:00', -1264842910, -1052964641, 'qcx5', -2147483648, '2025-05-27 16:57:17+00:00', 'nc', 'rjtu', -361507387, 401805964, -1485777725, 23853, '2022-03-23 04:34:16+00:00', '2024-08-10 07:57:32+00:00', -1255130038, '2024-06-15 00:00:00+00:00', '3d', 'qv0gcb98ozk');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1686459626, -1554531873, '2023-03-28 14:41:46+00:00', 638024588, -688098735, '6ah', 23853, '2023-07-25 15:03:55+00:00', '8j', 'wwlq7', 1255343543, -541746689, 1294666887, 23853, '2023-03-26 06:11:01+00:00', '2020-09-26 17:28:32+00:00', 1427161052, '2024-06-15 00:00:00+00:00', 'z16ni', 'jai');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -1738458256, -1714354341, '2020-06-19 19:37:13+00:00', 1074760385, 1129658414, '1afgo', 23853, '2020-11-22 11:14:57+00:00', 'itsj3', 'y', -598313376, 1972233925, 1792827279, -2147483648, '2025-05-18 14:45:15+00:00', '2025-11-05 10:13:50+00:00', -106471771, '2024-06-15 00:00:00+00:00', '1jh3den', 'c68x8vacx');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1421303999, -1488156735, '2020-07-27 22:34:35+00:00', -288338724, 1897687032, '278507cv', 23853, '2022-07-15 10:34:24+00:00', 'ptt', '6b', -1171104889, -29242208, 1691780814, 23853, '2023-12-14 20:00:33+00:00', '2024-05-05 04:13:50+00:00', 1944978593, '2024-06-15 00:00:00+00:00', 'bfkfoacd', '7z2zezj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -57705450, -915385605, '2020-04-12 14:45:54+00:00', -405743609, -1935752926, '5i3', 23853, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58', -1125548818, 1497321728, -95808609, -2147483648, '2022-08-10 04:39:07+00:00', '2020-12-28 23:17:24+00:00', 333302050, '2021-08-24 18:58:08+00:00', 'ajjl', '3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 448935289, 458835042, '2020-08-06 07:31:44+00:00', -489120589, -72442907, '7sx58', 23853, '2025-10-20 14:58:18+00:00', '4', 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, 23853, '2023-06-01 10:01:12+00:00', '2022-12-09 16:13:13+00:00', -55494714, '2024-06-15 00:00:00+00:00', 'n9', 'o705');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -2019656607, 375841374, '2021-05-20 02:31:08+00:00', 575038073, -1161141730, 'cl5ams', -2147483648, '2025-08-28 09:25:40+00:00', 'rlwy', 'gc1d', 453340472, 211603887, -413043724, -2147483648, '2025-10-05 07:32:01+00:00', '2021-05-31 11:16:55+00:00', 1504707292, '2024-06-15 00:00:00+00:00', 'yoeyo6l0hdt6', 'uq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, -1552469358, 7342822, '2022-03-16 10:43:12+00:00', 287256667, 1614799674, 'ow9oaawg96a', 23853, '2022-03-05 18:43:06+00:00', '0', 'bindz', 2085299664, 2038321753, 1376887048, -2147483648, '2024-10-08 16:57:12+00:00', '2022-08-02 17:02:31+00:00', 748154000, '2024-06-15 00:00:00+00:00', 'cgumbc', '3tdu6bd0w960');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483638, -438741674, -154207334, '2024-11-26 15:07:48+00:00', 1595632888, 2072023304, 'io18ri2hy08', -2147483648, '2020-09-30 07:17:16+00:00', 'tp6ewtqxxn', 'jabymzn2mfx7', -1659775598, -891525031, -1154091048, 23853, '2020-05-07 06:13:16+00:00', '2021-04-08 11:35:14+00:00', 1728926031, '2024-06-15 00:00:00+00:00', 'knzys7dy', 'yd1jmgjach8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483637, -161108900, -735270562, '2025-06-20 19:52:40+00:00', -493230039, -2081662466, '3qdpu', 23853, '2020-02-17 04:43:11+00:00', '96rn', 'dqrhm', 555368535, -1369148652, 899787662, -2147483648, '2025-06-06 16:24:29+00:00', '2021-10-03 14:10:52+00:00', 833568923, '2024-06-15 00:00:00+00:00', '90xdmsqt', 'el');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483636, 1374676344, 238243966, '2023-10-20 18:15:15+00:00', 277649518, 908468929, 'kjq1qu', -2147483648, '2021-02-17 14:55:24+00:00', '1yh', '0', 166124233, 1862197286, 1040753276, 23853, '2023-08-12 01:29:22+00:00', '2022-02-01 03:33:20+00:00', -1333785554, '2024-06-15 00:00:00+00:00', 'tvb6m4i', '78aqqlu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483635, 1144507576, -343920305, '2025-03-01 13:00:27+00:00', -913430713, -1652411404, 'zxdp', -2147483648, '2022-10-01 02:03:07+00:00', 'mwfw', 'qrlawk', 558684943, -120625031, 572453185, 23853, '2022-04-01 23:58:27+00:00', '2022-08-20 18:30:25+00:00', 1298113538, '2024-06-15 00:00:00+00:00', 'g97a', 'z2o20');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -55602865, -59984348, '2022-12-08 21:38:59+00:00', 1258409369, -1981402255, 'k9n8c', 1, '2024-01-16 07:29:50+00:00', 'gu7v', 'e4', 1160656988, -992890117, 1914020640, 1, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1364429300, -1257178728, '2022-04-12 01:47:28+00:00', 2087640001, 907682809, 'siie', -2147483648, '2024-02-29 12:08:41+00:00', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 23853, '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1178636309, -1390245819, '2023-03-10 01:47:11+00:00', 1775126557, -74849714, '7zw', -2147483648, '2025-03-16 12:14:02+00:00', 'u', '2dwyrq13pyu7', 244829661, -1362461264, -904834265, -2147483648, '2023-07-26 21:52:05+00:00', '2020-03-25 00:00:06+00:00', 1692174491, '2024-03-18 20:04:07+00:00', 'i2rkf', 'vqx58pz0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 176555546, -1937207087, '2023-09-10 09:37:01+00:00', -688509700, -792092619, 'j4hwbdvlph', 1, '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', 722884590, 580968159, -1245312912, 1, '2022-01-23 03:13:33+00:00', '2022-04-18 00:53:20+00:00', -1509264256, '2022-09-06 20:15:01+00:00', 'dz79fjg', '8n2f3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 982314585, 638024588, '2025-11-22 09:05:23+00:00', 32204797, -1672720816, '8j', -2147483648, '2022-05-28 16:44:30+00:00', 'wlq7xb', '72fxa7ryfd', 564390026, -1259474148, 2011234363, -2147483648, '2021-04-25 14:26:05+00:00', '2020-01-23 21:20:16+00:00', -7597509, '2025-07-17 09:46:47+00:00', '5o', 'rg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 518609210, 1948383687, '2020-06-27 17:29:33+00:00', -1826414375, 357330522, '68x8vacx7a', 23853, '2020-10-05 17:58:46+00:00', '5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, 23853, '2020-10-18 11:14:36+00:00', '2023-07-14 21:32:37+00:00', 1870300798, '2024-03-11 08:01:44+00:00', 'q8qdjpe1io22', '8507cvtjp');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, -1950324754, 2115816682, '2025-09-08 19:36:12+00:00', -406331049, -461418236, 'zjo7wgxd5ysx', 1, '2020-04-12 14:45:54+00:00', 'r0oz', 'dgj5i', -176606723, -15162884, 1339733032, -2147483648, '2022-01-04 01:02:12+00:00', '2021-03-03 03:48:10+00:00', -1300180872, '2021-06-04 00:33:11+00:00', '8qs27p2r', '4gth2mnaj');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (23853, 2142703426, '2023-03-13 16:07:34+00:00', '78d99r', '2021-07-21 20:51:39+00:00', 'sl0', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -835782528, '2024-08-19 12:45:04+00:00', '9114q', '2020-03-01 13:40:47+00:00', 'e6bje', 'uuwsj8kjh8', 'wpxlvris', 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 'gc8s3b7v88k');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, 1, -283454505, '9uxj4hw', '2013-07-12 09:08:18.0', 23853, 'd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, 1, -1762140823, 'w1of77pz', '2013-07-12 09:08:18.0', 23853, '72ct');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 1, -1928431425, 'mfg62', '2013-07-12 09:08:18.0', 23853, '0v');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 4, 1803796945, '8uttmu', '2013-07-12 09:08:18.0', 23853, 'ne578lfv');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 4, -1514700303, 'of', '2013-07-12 09:08:18.0', 23853, 'szdo2z');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 4, -1418927432, '521gwnlas6e', '2013-07-12 09:08:18.0', 23853, 'lboeowii1z5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, 2018368241, 'xw1rxe9yfk7', '2013-07-12 09:08:18.0', 23853, 'k162n');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, -516345261, 'o', '2013-07-12 09:08:18.0', 23853, 'vu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, -622923312, 'dbdh', '2013-07-12 09:08:18.0', 1, '6j47n');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, 1, 6224071, 'dlysu6iphd', '2024-06-15 00:00:00+00:00', 23853, 'u2g');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 5, 1, 'value', NULL, 23853, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 6, 2107872094, '02eutliqa11r', '2024-06-15 00:00:00+00:00', -2147483648, 'ytoo3o9');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 7, 1, 'value', NULL, -2147483648, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 8, -1056308489, 'gcb98oz', '2013-07-12 09:08:18.0', 1, '3zb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 9, -458359144, '1afgogritsj', '2013-07-12 09:08:18.0', -2147483648, 'ayxp1q43');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 10, 1582582341, 'tg6bnou5zi', '2013-07-12 09:08:18.0', 1, '6c4bfkfo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 11, -1351793914, 'okv8uttm', '2013-07-12 09:08:18.0', -2147483648, '2ne578');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT IIF(T2.ClosedDate IS NULL, 'NOT well-finished', 'well-finished') AS resylt FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T1.UserId = 23853 AND T1.CreationDate = '2013-07-12 09:08:18.0';

/*
Gold Result:
('well-finished',)
('well-finished',)
('well-finished',)
('well-finished',)
('well-finished',)
('well-finished',)
('well-finished',)
('well-finished',)
*/

-- Prediction Query
SELECT CASE WHEN posts.ClosedDate IS NULL THEN 'Yes' ELSE 'No' END AS is_well_finished FROM comments INNER JOIN posts ON comments.PostId = posts.Id WHERE comments.UserId = 23853 AND comments.CreationDate = '2013-07-12 09:08:18.0';

/*
Prediction Result:
('No',)
('No',)
('No',)
('No',)
('No',)
('No',)
('No',)
('No',)
*/