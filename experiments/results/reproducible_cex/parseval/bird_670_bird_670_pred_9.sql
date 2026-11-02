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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 1360271423, 1583472758, '1970-01-01 00:00:00+00:00', 1449284300, -977470238, 'd8y', 1, '2023-05-06 21:04:41+00:00', '1afgo', 'ri', -902895762, -197933860, 2111987706, 0, '2023-01-25 15:19:02+00:00', '2022-01-13 07:24:35+00:00', 1972233925, '2022-03-04 13:07:03+00:00', '4301jh3den8', 'c68x8vacx7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1944978593, 1722106924, '2024-06-15 00:00:00+00:00', -2072838897, -1173368267, 'cd07z2zezjo7', 1, '2024-11-08 11:45:59+00:00', 'gxd5ys', 'cmr0oz', -870767087, -1699185893, 875300074, -2147483647, '2021-01-24 01:19:46+00:00', '2023-11-26 16:36:47+00:00', -1405314653, '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1273687251, 333302050, '2024-06-15 00:00:00+00:00', 1162591638, -2136247961, 'la3', 1, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n', -1817527403, -1402164108, 2123471885, 0, '2025-08-19 19:51:44+00:00', '2023-03-18 11:45:17+00:00', -451030047, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '7sx58b4pma');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -200807520, -790819470, '2024-06-15 00:00:00+00:00', -1278087274, -1140595602, 'wzw', 1, '2024-02-22 07:15:08+00:00', 'h', '9mo7', -354292049, 238533676, -1514700303, 0, '2020-09-11 00:02:55+00:00', '2021-12-11 06:40:50+00:00', -1793230843, '2022-07-09 16:59:45+00:00', 'do2zobb', 'q0k32od');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 2061558815, 895277769, '2024-06-15 00:00:00+00:00', 364043263, -1177989415, 'wyn', 1, '2025-04-18 20:42:36+00:00', 'c1', 'j', 211603887, -413043724, 761519897, 1, '2023-08-24 14:09:34+00:00', '2023-04-06 19:38:57+00:00', -1156828895, '2023-04-04 11:32:59+00:00', 'o6l0hdt6fu', 'yxuzk');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -206528034, -1686002788, '2024-06-15 00:00:00+00:00', -1250380401, 1718516876, '6elbo', 1, '2020-08-28 14:27:04+00:00', 'wii1', '5nxih66', -251205568, 287256667, 1614799674, -1, '2025-07-02 03:36:52+00:00', '2021-12-05 05:27:44+00:00', 1774679448, '2024-08-29 05:28:03+00:00', 'aawg', '6aqb0tbin');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1148916014, -1988582944, '2022-09-05 12:39:02+00:00', -1275298282, 1933158443, '3tdu6bd0w960', 2, '2023-12-02 04:32:05+00:00', 'vzxw1rxe9y', 'k7', -1046720861, 643589729, -1231488097, -1, '2024-03-03 12:11:16+00:00', '2025-10-15 00:12:43+00:00', -516345261, '2020-05-31 03:27:03+00:00', 'ohvu06dza3', 'rmkio18r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 3, '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 2, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -1610064545, 429706943, '2022-01-18 15:57:55+00:00', 1236688122, 2087640001, 'dposiie5unw', 4, '2024-05-04 23:07:19+00:00', 'lfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, 0, '2021-08-19 01:10:02+00:00', '2024-10-24 14:16:53+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 328305758, -751275471, '2021-08-01 11:21:15+00:00', -1068298341, -314162272, 'ytoo3o9', 5, '2020-12-13 17:48:30+00:00', '72k', 'ex1', -74849714, 105869088, -2081315180, 1, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1025564911, -227162283, '2021-05-26 08:15:06+00:00', -705985602, 537874887, 'z0f8jegd21vy', 6, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', 'ph2', 1298861365, 1968874827, -664193365, -1, '2022-02-18 09:12:59+00:00', '2020-04-10 05:04:30+00:00', 555413010, '2025-09-07 08:46:54+00:00', 'hncprjtu', 'dz79fjg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 894242932, -211209314, '2023-11-18 03:19:57+00:00', 806170397, 513454646, '0gcb98', 7, '2021-11-18 07:56:25+00:00', 'k3zbily', 'kn6vc', 1784916884, 37673509, 834709651, 2, '2023-07-25 15:03:55+00:00', '2020-10-15 18:29:15+00:00', 138842628, '2022-05-28 16:44:30+00:00', 'wlq7xb', '72fxa7ryfd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 777149609, 61479715, '2021-02-09 08:26:06+00:00', 2011234363, -1483100200, '5dh', 8, '2024-02-27 00:46:50+00:00', 'grgj', '8', -458359144, 600440952, 1568069663, 2, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1923912467, 518609210, '2021-01-17 17:19:55+00:00', -163600466, -1826414375, 'c68x8vacx', 9, '2024-05-22 05:48:31+00:00', 'f', '5w1of7', 76996700, -435350511, 1992637800, 4, '2022-08-17 19:55:37+00:00', '2020-06-07 10:59:23+00:00', 481546706, '2020-09-19 12:51:08+00:00', '62', '0v');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1, 'ypuzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -443340271, '2025-10-02 08:51:14+00:00', 'o4nrqr', '2021-11-17 08:00:56+00:00', 'fqyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, -1390245819, 1055976837, 1, '4ji7zwa');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, -1612443122, '2020-03-11 08:08:02+00:00', 'v', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -1, 'dz79fjg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, 1523825314, '2020-10-05 17:58:46+00:00', '5w1of7', '2024-05-28 03:27:01+00:00', 'zo72', 'ctdctmfg62g0', '5q8qdj', -1139855872, -288338724, 1897687032, -241848752, -1, '8507cvtjp');

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
SELECT MIN("posts"."creaiondate") FROM "users" JOIN "posts" ON "users"."id" = "posts"."owneruserid" WHERE "users"."age" = (SELECT MIN("age") FROM "users" WHERE NOT "age" IS NULL);

/*
Prediction Result:
(None,)
*/