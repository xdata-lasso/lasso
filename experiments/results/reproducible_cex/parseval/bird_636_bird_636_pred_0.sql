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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1264842910, -1052964641, '2021-10-14 08:16:37+00:00', -1070063173, 555413010, '5hncprjtu0d', 1, '2023-05-14 17:39:51+00:00', '9fjgq8n2f', 'dqv0gcb9', 172461907, 1606439408, 1443629118, 2, '2023-12-12 02:47:46+00:00', '2023-05-15 04:44:08+00:00', 1686459626, '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -932772113, -639539893, '2022-03-20 09:18:33+00:00', -566887085, 602161869, 'xa', 1, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja', -7597509, -1625552518, -1738458256, 4, '2020-11-09 07:36:21+00:00', '2021-04-29 02:40:32+00:00', -458359144, '2025-06-10 19:01:27+00:00', 'afgogri', 'tsj3ayxp1q4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 4, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2123196517, 364869063, '2022-05-13 17:57:39+00:00', -1021749117, 392822403, 'yu78', 1, '2020-06-02 21:50:32+00:00', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, -461695645, 5, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1382410067, '9', 2, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 6, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1538707438, -163600466, '2020-08-20 06:07:09+00:00', 195720193, 1774087382, 'c', 5, '2023-02-22 19:24:03+00:00', 'afu5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, 3, '2020-10-18 11:14:36+00:00', '2023-07-14 21:32:37+00:00', 1870300798, '2024-03-11 08:01:44+00:00', 'q8qdjpe1io22', '8507cvtjp');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1467355421, -1171104889, '2024-03-12 07:01:30+00:00', -1575410149, -68044929, 'kf', 5, '2025-08-13 14:13:20+00:00', 'acd0', '7z2zezjo7wg', 1248858185, -57705450, -915385605, 5, '2020-04-12 14:45:54+00:00', '2021-08-06 04:52:45+00:00', 1721638020, '2023-06-27 00:46:15+00:00', 'ztdg', '5i3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1125548818, 1497321728, '2024-09-21 04:14:02+00:00', 988954859, -1719383707, '2m', 9, '2021-10-18 07:51:02+00:00', 'ajjla3okv8u', 'tmu2n', -1817527403, -1402164108, 2123471885, 8, '2025-08-19 19:51:44+00:00', '2023-03-18 11:45:17+00:00', -451030047, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '7sx58b4pma');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 823835795, -354292049, '2025-06-30 18:54:45+00:00', 238533676, -1514700303, 'of', 3, '2022-12-30 09:36:03+00:00', 'zdo2z', 'obb0q0k32o', -1898678660, 440115543, 292557306, 9, '2025-08-28 09:25:40+00:00', '2021-12-02 07:29:49+00:00', -984562992, '2023-01-20 18:10:08+00:00', 'ngc1dj9', 'rh');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Neil McGuigan', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -2070843029, '2022-01-05 17:19:47+00:00', 'Neil McGuigan', '2023-07-13 23:57:06+00:00', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309, -1390245819, 1055976837, 1775126557, -74849714, '7zw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', '2024-09-26 13:13:01+00:00', 'ljsl0', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'Neil McGuigan', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -2070843029, '2022-01-05 17:19:47+00:00', 'Neil McGuigan', '2023-07-13 23:57:06+00:00', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309, -1390245819, 1055976837, 1775126557, -74849714, '7zw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1612443122, '2020-03-11 08:08:02+00:00', 't1__9b89ee', '2020-06-06 08:33:45+00:00', 'lph2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1746373317, '2020-07-12 19:51:25+00:00', 't1__9b89ee', '2025-07-17 09:46:47+00:00', '5o', 'rg', 'd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, 1, 59, 'zbuo4nrqrof', '2024-12-28 10:57:01+00:00', 1, 'yp5s5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, 1, 59, '1vy9uxj4', '2021-01-22 00:53:52+00:00', 4, 'bdvlph');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 4, 59, '01jh3den', '2024-08-17 10:42:21+00:00', 1, 'c68x8vacx7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 1, 59, '5w1of7', '2024-05-28 03:27:01+00:00', 4, 'zo72');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 4, 59, 'dctmf', '2020-11-14 00:31:21+00:00', 1, '2g0v5q8qd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 1, 59, 'e1io', '2023-10-10 11:56:21+00:00', 4, '78507cvt');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 4, 59, 'ttg6bnou5zi3', '2024-05-05 04:13:50+00:00', 1, '4');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, 59, 'foa', '2025-01-04 09:05:19+00:00', 4, 'd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 4, 59, 'z2zezjo7w', '2020-12-04 11:46:08+00:00', 1, 'd5ysxc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, 59, '0oztdgj5i3lq', '2025-11-16 21:50:04+00:00', 1, 'lnpim5k5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, 59, 'qs27p2r94', '2020-11-05 16:17:26+00:00', 1, 'h2mna');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 3, 60, 'zbuo4nrqrof', '2024-12-28 10:57:01+00:00', 3, 'yp5s5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 5, NULL, 'value', '2024-06-15 00:00:00+00:00', 5, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 6, 60, '2fxa7ryfdrz', '2025-05-15 17:08:24+00:00', 6, '6nijjai');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 7, NULL, 'value', '2024-06-15 00:00:00+00:00', 7, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 8, 59, 'q5l', '2021-11-07 05:17:12+00:00', 8, 'im5k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 9, 60, 'us3auvmkrpdj', '2025-10-04 15:32:15+00:00', 9, 'zw5chn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 10, NULL, 'value', '2024-06-15 00:00:00+00:00', 10, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T1.DisplayName = 'Neil McGuigan' AND T3.Score < 60;

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(T2.Score) FROM users AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Neil McGuigan' AND T2.Score < 60;

/*
Prediction Result:
(7,)
*/