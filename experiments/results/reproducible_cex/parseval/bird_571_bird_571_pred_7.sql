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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 374105386, 1274489983, '2021-02-04 01:21:18+00:00', 1149850321, -1833165707, '6nium52zb', 24, '2025-10-02 08:51:14+00:00', 'o4nrqr', 'fqyp', -921187550, -2070843029, 328305758, -2147483648, '2022-10-06 23:43:31+00:00', '2022-07-13 23:48:43+00:00', -1347802441, '2022-02-19 15:51:21+00:00', '1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 894242932, -211209314, 'dqv0gcb9', -2147483648, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, -2147483648, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 602161869, 1350414441, '2023-03-07 13:22:39+00:00', -961217731, -1888505890, 'z16nijjai5d', -2147483648, '2025-07-17 09:46:47+00:00', '5o', 'rg', -1478247928, 1074760385, 1129658414, 2, '2022-08-16 10:09:33+00:00', '2025-06-10 19:01:27+00:00', 1250290042, '2020-11-06 22:27:04+00:00', 'grit', 'sj3ayxp1q430');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 24, '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 2, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1137908826, -918961358, '2021-01-29 03:06:29+00:00', -1823627488, -1209887326, 'klfa9000t', 24, '2024-03-03 15:52:53+00:00', '4', 'ecigce376n', 1313172851, -761141909, 283598170, 2, '2023-11-07 12:14:47+00:00', '2025-09-21 09:36:38+00:00', -443340271, '2025-10-02 08:51:14+00:00', 'o4nrqr', 'fqyp');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -868774469, -1068298341, '2023-08-20 20:02:04+00:00', 2074205376, 274769912, 'oo3o9', 24, '2020-12-13 17:48:30+00:00', '72k', 'ex1', -74849714, 105869088, -2081315180, 24, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 222415430, 556727997, '2024-02-28 14:45:41+00:00', 1836127587, -1529584866, 'd2', 24, '2023-09-10 09:37:01+00:00', 'y9uxj4', 'wb', -1929953647, 1581736075, -261132974, -2147483648, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 894242932, -211209314, 'dqv0gcb9', 24, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 2, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1888505890, 777149609, '2025-05-15 17:08:24+00:00', 61479715, -1496556994, 'i', 24, '2024-03-27 22:48:03+00:00', 'h', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, 24, '2020-11-22 11:14:57+00:00', '2022-05-19 02:17:07+00:00', 710458518, '2025-08-05 22:21:48+00:00', 'j3ayx', '1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 195720193, 1774087382, '2020-02-13 02:40:04+00:00', 2035306060, 1523825314, 'u5', 24, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, -2147483648, '2024-03-11 08:01:44+00:00', '2025-11-17 07:39:50+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (24, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -305670381, '2021-03-25 19:22:18+00:00', '7zw', '2025-03-16 12:14:02+00:00', 'u', '2dwyrq13pyu7', 'd99rljsl0', -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, 'kf9vq');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483648, 1, 226938182, '2022-02-06', 24, 1178636309);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483647, 1, 1178000634, '2022-08-22', 24, -461695645);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483646, 1, 176555546, '2020-11-04', 24, 1196308825);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483645, 1, -283454505, '2024-05-17', 24, -792092619);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483644, 1, -87647544, '2023-12-18', 24, -2050247126);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, 1, 2103044118, '2021-04-26', 24, -261132974);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, 1, 1968874827, '2023-11-15', 24, -1245682094);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (5, 4, 518609210, '2021-05-19', -2147483648, -163600466);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (7, 1, 195720193, '2023-10-28', -2147483648, 1732258051);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (4, 6, -1364429300, '2022-04-29', -2147483648, 462974032);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (6, 2, 902551284, '2020-04-03', 24, 328305758);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (8, 3, -1025564911, '2025-01-05', -2147483648, -975213201);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (9, 6, -841004020, '2024-08-30', -2147483648, -1898531797);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (10, 8, 2094425101, '2020-02-10', -2147483648, 1294666887);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (11, 7, 518609210, '2021-05-19', 24, -163600466);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (12, 9, 2004147439, '2023-10-20', 2, -866772222);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.Id) AS REAL) / COUNT(DISTINCT T1.Id) FROM votes AS T1 INNER JOIN posts AS T2 ON T1.UserId = T2.OwnerUserId WHERE T1.UserId = 24;

/*
Gold Result:
(8.0,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(Id) FROM posts WHERE OwnerUserId = 24) AS REAL) / (SELECT COUNT(Id) FROM votes WHERE UserId = 24) AS PostToVoteRatio;

/*
Prediction Result:
(0.8888888888888888,)
*/