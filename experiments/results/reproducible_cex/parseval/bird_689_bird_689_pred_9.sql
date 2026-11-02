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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 183, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 183, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1485335077, -511185946, '2022-03-25 08:00:08+00:00', -1097120355, 244829661, 'jsl', 183, '2023-07-26 21:52:05+00:00', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 183, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -1625552518, -1738458256, '2020-11-09 07:36:21+00:00', -1478247928, 1074760385, 't1afgog', -1, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43', 1235416111, 1923912467, 518609210, 183, '1970-01-01 00:00:00+00:00', '2021-01-17 17:19:55+00:00', -163600466, '2020-08-20 06:07:09+00:00', '8c68', '8vacx7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -47052816, 645287482, '2021-11-22 07:38:31+00:00', 76996700, -435350511, '72ctdctmfg62', -1, '2020-10-18 11:14:36+00:00', 'v5q8qdj', 'e1io', -241848752, 2004147439, -691774480, 183, '1970-01-01 00:00:00+00:00', '2021-03-27 11:42:11+00:00', -847293924, '2024-05-07 03:46:17+00:00', 'n', 'u5zi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -1125548818, 1497321728, '2024-09-21 04:14:02+00:00', 988954859, -1719383707, '2m', 0, '2021-10-18 07:51:02+00:00', 'ajjla3okv8u', 'tmu2n', -1817527403, -1402164108, 2123471885, 183, '1970-01-01 00:00:00+00:00', '2025-08-19 19:51:44+00:00', -526633767, '2024-06-27 07:12:45+00:00', 'zzbe8yvkv4', 'q7sx58b4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1849819405, -929383517, '2020-02-11 09:48:43+00:00', -790819470, -1278087274, 'rpdjwzw5ch', -1, '2021-10-23 07:09:38+00:00', 'mo705a9n0', 'xfo', -1793230843, -441521858, 2015094998, 2, '1969-12-31 23:59:59+00:00', '2023-11-02 10:05:42+00:00', -1197954156, '2020-04-02 11:13:10+00:00', 'q0k32od', 'cl5ams');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -1352968577, -519515742, '2025-04-18 20:42:36+00:00', -1689155697, -323362455, 'j9erhizgk1', -1, '2023-04-06 19:38:57+00:00', 'eyo6', 'l0hdt6fuqyx', -1418927432, -30041412, -277407746, 4, '1969-12-31 23:59:59+00:00', '2022-12-04 16:04:40+00:00', -1250380401, '2020-01-06 01:47:51+00:00', '6elbo', 'ow');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1610380698, -457369423, '2021-10-05 09:01:22+00:00', 548968280, -1552469358, '62q2xlyot', 183, '2025-07-02 03:36:52+00:00', 'w9oa', 'awg96aqb0tbi', 503053726, -1897615568, 2085299664, 2, '2020-01-05 17:53:54+00:00', '2021-04-16 21:57:00+00:00', -841516418, '2024-07-21 17:54:15+00:00', '5wcg', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1964331395, -1943814113, '2023-01-15 14:52:54+00:00', -379749892, -541917667, 'rxe9yfk', 183, '2024-07-02 05:26:35+00:00', 'k162n', '55', 2105860871, -141591627, 440797047, 0, '2020-12-29 08:01:31+00:00', '2022-10-20 05:01:15+00:00', -1934709172, '2020-01-19 20:53:01+00:00', '5rmkio18', 'i2hy0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, -1051623642, 2013745856, '2020-01-09 12:53:38+00:00', -2080232972, 462225708, 'n2mfx7h', 183, '2023-12-11 11:19:14+00:00', 'p6sto1cj', 'sh5knzys7', 1487347213, 1328948152, -1923069176, 4, '1970-01-01 00:00:00+00:00', '2024-12-17 00:18:59+00:00', -1520090613, '2025-06-04 14:14:14+00:00', 'ja', 'h');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483638, 280292620, 620355627, '2025-04-13 01:34:03+00:00', -531872415, -2125172723, 'v4ygmayq3', 183, '2022-02-24 01:09:12+00:00', 'dpuap96rnt', 'q', -951706262, -1324935647, -648564084, 4, '1969-12-31 23:59:59+00:00', '2021-02-19 01:26:12+00:00', 899787662, '2025-06-06 16:24:29+00:00', '2np4', '0xdmsqtge');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483637, -1025517017, 1374676344, '2024-09-21 18:52:55+00:00', -1750715330, 277649518, 'cukjq1quik1y', 183, '2025-10-15 06:35:43+00:00', 'b0', 'hlst1pqom', 2141720493, 1793241362, -1304516770, 183, '1969-12-31 23:59:59+00:00', '2021-03-02 05:21:54+00:00', -2128972904, '2022-03-09 16:51:49+00:00', 'ud8', 'tb');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (183, -55602865, '2024-02-19 01:18:26+00:00', 't2__1974f6', '2022-06-06 02:35:43+00:00', 'wqcgsk', 't2__d5d8c6', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '2022-01-22 16:14:13+00:00', 's5bbp02e', 'tliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -629784617, '2020-06-06 08:33:45+00:00', 'lph2gn', '2020-07-01 12:41:54+00:00', 'wnqcx', '5hncprjtu0d', '79fjgq8', -1255130038, -1762857309, 806170397, 513454646, -688216274, 'gcb98ozk3z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -1554531873, '2023-03-28 14:41:46+00:00', 'kn6vc', '2021-05-17 23:21:59+00:00', 'ah0f8jsww', 'q7x', '7', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1722106924, '2020-02-23 23:54:56+00:00', 'kf', '2025-08-13 14:13:20+00:00', 'acd0', '7z2zezjo7wg', 'd5ysxc', -405743609, -1935752926, -20116244, -176606723, -15162884, 'pim5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, 192271618, '2025-08-17 22:42:43+00:00', 't2__1974f6', '2024-09-25 06:07:56+00:00', '14qbre6', 't2__d5d8c6', 'j', -752650834, 2134937984, 1379644459, 136003842, -1486030107, '5wpxlvris');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.Id = 183 ORDER BY T1.LastEditDate DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__1974f6', 't2__d5d8c6')
*/

-- Prediction Query
SELECT T1.DisplayName, T1.Location FROM users AS T1 INNER JOIN (SELECT UserId FROM postHistory WHERE PostId = 183 ORDER BY CreationDate DESC, postHistory.id NULLS LAST LIMIT 1) AS T2 ON T1.Id = T2.UserId;

/*
Prediction Result:
*/