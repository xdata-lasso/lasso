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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1659388584, 1526238907, '2021-07-11 07:27:32+00:00', -845863578, -1610064545, 'n', 1, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 4, 1, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 176555546, -1937207087, '2023-09-10 09:37:01+00:00', -688509700, -792092619, 'j4hwbdvlph', 4, '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', 722884590, 580968159, 4, 2, '2021-10-14 14:41:11+00:00', '2020-05-10 07:36:02+00:00', 1575412235, '2022-04-18 00:53:20+00:00', 'tu0', 'z');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 894242932, -211209314, 'dqv0gcb9', 4, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 4, 4, '2025-03-26 10:17:14+00:00', '2025-07-07 23:31:04+00:00', 32204797, '2020-04-16 10:31:38+00:00', '6ah', 'f8jswwl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -566887085, 602161869, '2020-09-05 12:25:49+00:00', 2094425101, -961217731, 'dr', 4, '2025-10-16 14:52:58+00:00', '16nijja', '5dh', 1583472758, 1449284300, 4, 2, '2022-04-26 08:43:58+00:00', '2020-11-09 07:36:21+00:00', -1478247928, '2024-07-26 15:42:53+00:00', 'yzt1afgogrit', 'sj3ayxp1q430');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 518609210, 1948383687, '2020-06-27 17:29:33+00:00', -1826414375, 357330522, '68x8vacx7a', 4, '2020-10-05 17:58:46+00:00', '5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 4, 2, '2020-11-14 00:31:21+00:00', '2024-04-08 04:21:40+00:00', -242584410, '2023-07-14 21:32:37+00:00', '5q8qdj', 'e1io');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 199672698, 2119806856, '2025-08-02 16:41:48+00:00', -1962347906, -866772222, 'ttg6', 1, '2020-03-23 04:17:18+00:00', 'ou5z', '36c', 1722106924, -2072838897, 4, 2, '2021-05-31 16:00:51+00:00', '2020-10-11 01:34:34+00:00', 1923659053, '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 983324983, 1269522000, '2025-12-11 00:03:18+00:00', -405743609, -1935752926, '5i3', 1, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58', -1125548818, 1497321728, 4, 2, '2024-09-21 04:14:02+00:00', '2024-01-24 03:21:29+00:00', -1719383707, '2020-12-28 23:17:24+00:00', '2mnajjla3o', 'v8u');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 618058035, 1553368934, '2021-10-09 18:25:05+00:00', -1817527403, -1402164108, 'yz7zzb', 1, '2020-08-06 07:31:44+00:00', 'yvkv42q7s', '58b4pm', 1849819405, -929383517, 4, 4, '2020-02-11 09:48:43+00:00', '2022-09-08 09:11:51+00:00', -699574669, '2021-05-14 07:56:41+00:00', 'rpdjwzw5ch', '9mo7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 628082526, -1245584612, '2021-04-02 17:49:19+00:00', -582376271, -1165594842, 'szdo2z', 1, '2024-10-15 01:24:38+00:00', 'bb0q', '0k32odwcl5a', 292557306, 709097796, 3, 2, '2022-04-21 05:35:41+00:00', '2021-07-28 17:39:51+00:00', -605061107, '2021-11-01 11:17:30+00:00', 'gc1dj9erhi', 'zgk1yoeyo6l0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, -1942581013, -795975227, '2023-04-23 07:11:55+00:00', 778835680, 1755752040, 'b52', 1, '2023-09-14 18:35:43+00:00', 'wn', 'as6', -2076274980, 1731324803, 4, 1, '2021-12-15 23:43:59+00:00', '2022-12-20 18:28:11+00:00', -1589605308, '2023-09-21 01:04:05+00:00', '5nxih66', 'q2xlyoto');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 3, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, NULL, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1149850321, -1833165707, '2024-05-26 02:52:16+00:00', -1585009206, -53231346, 'zbuo4nrqrof', 5, '2024-12-28 10:57:01+00:00', 'yp5s5', 'bbp02eutliqa', -314162272, 2137741668, 3, 5, '2024-10-18 05:00:47+00:00', '2023-03-18 23:06:49+00:00', -188151580, '2024-09-13 14:36:04+00:00', 'l7', 'klex14ji');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 6, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, NULL, 4, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 556727997, 1178000634, '2024-08-09 01:13:45+00:00', 537874887, -461695645, 'f8jegd21vy9u', 7, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph', 'gndqwnqc', 555413010, 722884590, 4, 5, '2025-05-27 16:57:17+00:00', '2020-12-18 09:02:22+00:00', -1245312912, '2022-01-23 03:13:33+00:00', 'jtu0d', '79fjgq8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1382410067, '9', 8, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 3, 3, '2025-03-26 10:17:14+00:00', '2025-07-07 23:31:04+00:00', 32204797, '2020-04-16 10:31:38+00:00', '6ah', 'f8jswwl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 9, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, NULL, 5, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -1349201381, 1019800248, '2022-11-06 10:19:41+00:00', 1526238907, -1377057208, 'ilbnp', 10, '2022-04-12 01:47:28+00:00', 'dpos', 'ie5', -1209887326, -1399556171, 4, 9, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'United Kingdom', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', '2025-01-30 02:54:07+00:00', 'ofqyp', 'United Kingdom', 's5bbp02e', -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 'yytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1666765085, '2025-11-19 11:50:18+00:00', '2klex14ji', '2025-02-02 04:37:17+00:00', 'zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'United Kingdom', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -1659388584, '2020-06-20 11:35:06+00:00', 'tti', '2021-07-20 10:41:36+00:00', 'n', 't1__9856d2', 'rmdp', 2026480202, -1576219117, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -453362185, '2025-03-16 12:14:02+00:00', 'u', '2023-10-12 22:40:24+00:00', 'dwyrq13pyu78', 't1__9856d2', '9', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'United Kingdom', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T1.Location = 'United Kingdom' AND T2.FavoriteCount >= 4;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT users.id) AS usercount FROM users INNER JOIN posts ON users.id = posts.owneruserid WHERE users.location = 'United Kingdom' AND posts.favoritecount >= 4;

/*
Prediction Result:
(2,)
*/