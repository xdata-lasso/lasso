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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2024-06-15 00:00:00+00:00', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1675430660, -688509700, '2025-07-25 08:53:04+00:00', 233994589, 1442655647, 'hwbdvlph', 2, '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', 722884590, 580968159, -1245312912, 2, '2022-01-23 03:13:33+00:00', '2022-04-18 00:53:20+00:00', -1509264256, '2024-06-15 00:00:00+00:00', '0dz79f', 'gq8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -515895469, 1427161052, '2022-05-09 09:35:03+00:00', 777149609, 61479715, 'jja', 3, '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '8', -458359144, 600440952, 1568069663, -2147483647, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2024-06-15 00:00:00+00:00', 'itsj3', 'y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -242584410, -698610044, '2025-11-17 07:39:50+00:00', -1021978385, 569007824, 'e1io', 4, '2023-10-10 11:56:21+00:00', '78507cvt', 'ptt', 1467355421, -1171104889, -29242208, -2147483647, '2021-02-17 19:49:53+00:00', '2023-12-14 20:00:33+00:00', -68044929, '2024-06-15 00:00:00+00:00', 'kf', 'oacd07z2zez');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1448731351, -604098478, '2023-03-07 00:15:11+00:00', -57705450, -915385605, 'm', 4, '2022-04-20 03:52:20+00:00', '0oztdgj5i3lq', '5lnpim5k58qs', 1615073310, 1055237066, 988954859, 2, '2020-11-05 16:17:26+00:00', '2022-08-10 04:39:07+00:00', 1273687251, '2024-06-15 00:00:00+00:00', '2mnajjla3o', 'v8u');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 362376128, -1311735207, '2023-10-19 18:37:00+00:00', -1252009958, 1908593332, 'vy', 4, '2023-05-05 20:15:58+00:00', 'zzbe8yvkv', '42q7sx58b4', -1122409769, 1849819405, -929383517, -2147483647, '2020-02-11 09:48:43+00:00', '2022-09-08 09:11:51+00:00', -699574669, '2024-06-15 00:00:00+00:00', 'rpd', 'wzw');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -2013213247, 101754718, '2024-02-20 06:09:53+00:00', 238533676, -1514700303, 'of', 1, '2022-12-30 09:36:03+00:00', 'zdo2z', 'obb0q0k32o', -1898678660, 440115543, 292557306, 3, '2025-08-28 09:25:40+00:00', '2021-12-02 07:29:49+00:00', -984562992, '2024-06-15 00:00:00+00:00', 'yngc1d', 'j9erhizgk1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1156828895, 1483450542, '2025-04-08 19:28:10+00:00', -360096930, -1942581013, 'fuqyxuzkb', 1, '2025-06-29 01:47:27+00:00', '521gwnlas6', 'elboeowii1', -457369423, 1557188093, 548968280, 3, '2021-03-06 10:06:33+00:00', '2021-01-02 12:34:35+00:00', 7342822, '2024-06-15 00:00:00+00:00', '2xlyo', 'tow9oaawg96a');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 5, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 3, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 6, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 7, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 8, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 9, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 7, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 10, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483647, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 11, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 12, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 9, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 13, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 3, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't2__ea4f77', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 373262291, '2023-04-26 07:28:40+00:00', 't2__ea4f77', '2022-01-22 16:14:13+00:00', 's5bbp02e', 'tliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 364869063, '2022-05-13 17:57:39+00:00', 't2__ea4f77', '2022-03-25 08:00:08+00:00', '3pyu78d', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -106471771, '2023-06-28 02:52:00+00:00', 'jh3den8', '2025-01-28 02:00:27+00:00', 'c68x8vacx7', 'f', '5w1of7', 76996700, -435350511, 1992637800, -820614248, 481546706, 'g6');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 868039568, '2025-04-01 08:16:25+00:00', 'dz39', '2022-07-28 07:48:03+00:00', 'j', '9td8n5w', 'g', -794767771, 989306270, 1147652228, 1378873397, 1964331395, 'bd0w9603v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 2122220075, '2022-01-03 02:42:55+00:00', 'luhvdltti', '2021-07-20 10:41:36+00:00', 'n', 'rmdp', 'siie', -45536098, 1861536320, 44952191, 1151980946, 1620389964, '00t5c4ecigc');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', 'tliqa1', 2074205376, 274769912, -188151580, 226938182, 90119032, 'lex');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -74849714, '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '2022-03-25 08:00:08+00:00', '3pyu78d', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1675430660, '2022-11-21 09:24:31+00:00', '9uxj4hw', '2020-03-11 08:08:02+00:00', 'v', 'ph2', 'nd', -1052964641, -1245682094, -1660358170, -1106350634, -1509264256, '0dz79f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, -1742081330, '2024-08-10 07:57:32+00:00', 'n2f3dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, -1888505890, '2025-10-16 14:52:58+00:00', '16nijja', '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '8', 'yzt1afgogrit', 678047687, -1478134144, -491938169, -106471771, 1235416111, 'jh3den8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 357330522, '2024-10-22 06:47:26+00:00', '68x8vacx7afu', '2024-02-28 09:48:47+00:00', '1of77p', 'o72ctdc', 'mfg62', -1744557630, 1870300798, 820970595, 1421303999, -1488156735, '1i');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE NOT T1.ClosedDate IS NULL;

/*
Gold Result:
('t2__ea4f77',)
('t2__ea4f77',)
('dqv0gcb9',)
('jh3den8',)
('jh3den8',)
('jh3den8',)
('t2__ea4f77',)
('t2__ea4f77',)
*/

-- Prediction Query
SELECT DISTINCT u.DisplayName FROM users AS u JOIN posts AS p ON u.Id = p.OwnerUserId WHERE NOT p.ClosedDate IS NULL;

/*
Prediction Result:
('t2__ea4f77',)
('dqv0gcb9',)
('jh3den8',)
*/