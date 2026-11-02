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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-06-15 00:00:00+00:00', 13244799, -1659388584, 'l', 1, '2022-07-30 13:34:14+00:00', 'ilbnp', 'mdpos', -1576219117, -1823627488, -1209887326, 1, '2024-05-04 23:07:19+00:00', '2021-05-18 10:50:30+00:00', 1151980946, '2020-09-15 12:11:12+00:00', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 364869063, -953437896, '2024-06-15 00:00:00+00:00', -1097120355, 244829661, 'jsl', 1, '2023-07-26 21:52:05+00:00', '4', 'p5qi2rk', -705985602, 537874887, -461695645, -2147483647, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, 894242932, -211209314, '1969-12-31 23:59:59+00:00', -1056308489, -1454058168, 'bilyrkn', 1, '2025-11-22 09:05:23+00:00', 'vck6ah0f8', 'sww', -1388029300, -566887085, 602161869, -2147483647, '2020-09-05 12:25:49+00:00', '2023-03-07 13:22:39+00:00', -961217731, '2020-09-26 17:28:32+00:00', 'r', 'z16nijjai5d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, -683007527, 2035306060, '1969-12-31 23:59:59+00:00', 1523825314, 2078438287, '5w1of7', 1, '2024-05-28 03:27:01+00:00', 'zo72', 'ctdctmfg62g0', 1870300798, 820970595, 1421303999, 1, '2020-06-16 16:03:52+00:00', '2025-05-19 01:18:37+00:00', -1488156735, '2020-07-27 22:34:35+00:00', 'io22785', '7cvtjpt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1944978593, 1722106924, '2024-06-15 00:00:00+00:00', -2072838897, -1173368267, 'cd07z2zezjo7', 1, '2024-11-08 11:45:59+00:00', 'gxd5ys', 'cmr0oz', -870767087, -1699185893, 875300074, -2147483647, '2021-01-24 01:19:46+00:00', '2023-11-26 16:36:47+00:00', -1405314653, '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1273687251, 333302050, '2024-06-15 00:00:00+00:00', 1162591638, -2136247961, 'la3', 1, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n', -1817527403, -1402164108, 2123471885, 0, '2025-08-19 19:51:44+00:00', '2023-03-18 11:45:17+00:00', -451030047, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '7sx58b4pma');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -200807520, -790819470, '2024-06-15 00:00:00+00:00', -1278087274, -1140595602, 'wzw', 1, '2024-02-22 07:15:08+00:00', 'h', '9mo7', -354292049, 238533676, -1514700303, 0, '2020-09-11 00:02:55+00:00', '2021-12-11 06:40:50+00:00', -1793230843, '2022-07-09 16:59:45+00:00', 'do2zobb', 'q0k32od');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 2061558815, 895277769, '2024-06-15 00:00:00+00:00', 364043263, -1177989415, 'wyn', 1, '2025-04-18 20:42:36+00:00', 'c1', 'j', 211603887, -413043724, 761519897, 1, '2023-08-24 14:09:34+00:00', '2023-04-06 19:38:57+00:00', -1156828895, '2023-04-04 11:32:59+00:00', 'o6l0hdt6fu', 'yxuzk');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -206528034, -1686002788, '2024-06-15 00:00:00+00:00', -1250380401, 1718516876, '6elbo', 1, '2020-08-28 14:27:04+00:00', 'wii1', '5nxih66', -251205568, 287256667, 1614799674, -1, '2025-07-02 03:36:52+00:00', '2021-12-05 05:27:44+00:00', 1774679448, '2024-08-29 05:28:03+00:00', 'aawg', '6aqb0tbin');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -592014051, 1744849810, '2025-02-20 13:44:44+00:00', 1996699977, -1027584872, 'el', 2, '2020-05-04 22:25:03+00:00', 'qb9i9f', 'ccukjq1q', -796609690, -1459013972, -1670335771, -2147483642, '2023-07-12 04:15:18+00:00', '2024-07-31 14:48:12+00:00', 1862728578, '2022-08-23 08:32:45+00:00', 'pqomizt', 'vb6m4iz78aq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1437333179, -921145356, '2023-01-16 20:10:41+00:00', -1022641847, -1726781632, '9n8', 3, '2020-04-30 23:22:06+00:00', 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', 'dpos');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -1602639011, -45536098, '2021-11-09 05:42:50+00:00', 44952191, 1151980946, 'a9', 4, '2023-06-17 21:52:40+00:00', '00t5c4ecigc', 'e376nium52', -443340271, 757448742, -1179823637, 0, '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 328305758, -751275471, '2021-08-01 11:21:15+00:00', -1068298341, -314162272, 'ytoo3o9', 5, '2020-12-13 17:48:30+00:00', '72k', 'ex1', -74849714, 105869088, -2081315180, 1, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1692174491, -1025564911, '2023-10-21 02:54:45+00:00', -975213201, -705985602, 'x58pz0f8je', 6, '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', -736979194, 2103044118, -1642259219, 4, '2020-12-04 21:49:29+00:00', '2021-09-30 11:37:26+00:00', 1968874827, '2022-12-08 23:34:02+00:00', 'qcx5', 'hncprjtu0dz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 894242932, -211209314, 'dqv0gcb9', 7, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 3, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 602161869, 1350414441, '2023-03-07 13:22:39+00:00', -961217731, -1888505890, 'z16nijjai5d', 8, '2025-07-17 09:46:47+00:00', '5o', 'rg', -1478247928, 1074760385, 1129658414, 5, '2022-08-16 10:09:33+00:00', '2025-06-10 19:01:27+00:00', 1250290042, '2020-11-06 22:27:04+00:00', 'grit', 'sj3ayxp1q430');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 518609210, 1948383687, '2020-06-27 17:29:33+00:00', -1826414375, 357330522, '68x8vacx7a', 9, '2020-10-05 17:58:46+00:00', '5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, -2147483642, '2020-10-18 11:14:36+00:00', '2023-07-14 21:32:37+00:00', 1870300798, '2024-03-11 08:01:44+00:00', 'q8qdjpe1io22', '8507cvtjp');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1, 'ypuzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -443340271, '2025-10-02 08:51:14+00:00', 'o4nrqr', '2021-11-17 08:00:56+00:00', 'fqyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, -1390245819, 1055976837, 1, '4ji7zwa');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, -1612443122, '2020-03-11 08:08:02+00:00', 'v', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -1, 'dz79fjg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, 1360271423, '2024-02-27 00:46:50+00:00', 'grgj', '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3', 'y', -598313376, 1972233925, 1792827279, 804529642, -1, '01jh3den');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, -1897615568, '2023-12-20 17:13:08+00:00', 'tajz9td8n', '2025-07-30 07:59:24+00:00', '5wcgumbc3td', 'u6bd0w9603', 'vzxw1rxe9y', -1046720861, 643589729, -1231488097, 956819642, 1, '5y3dohvu06d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -154207334, '2024-11-26 15:07:48+00:00', 'mkio1', '2024-07-20 09:13:00+00:00', 'i2hy0', '8ftp6ewtqx', 'njabym', 1528227252, -1277305894, -1659775598, -891525031, 1, '1cj8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, -63214972, '2021-10-06 21:42:28+00:00', 'zys7dyyd1jmg', '2025-09-12 04:23:42+00:00', 'ach', 'qta8y3a17', 'v4ygmayq3qdp', -2082238979, -845136979, -1042976410, -1670945624, 1, 'wlic7dn2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreaionDate FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE NOT T1.Age IS NULL ORDER BY T1.Age, T2.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('1969-12-31 23:59:59+00:00',)
*/

-- Prediction Query
SELECT MIN(posts.CreaionDate) AS FirstPostCreationDate FROM posts INNER JOIN users ON posts.OwnerUserId = users.Id WHERE users.Id = (SELECT MIN(users.Id) FROM users);

/*
Prediction Result:
(None,)
*/