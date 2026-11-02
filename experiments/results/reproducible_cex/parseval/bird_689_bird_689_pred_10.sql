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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -283454505, 233994589, '2023-02-15 11:45:56+00:00', -1492524358, -1612443122, 'd', 3, '2022-10-17 07:55:28+00:00', 'ph2', 'nd', -1052964641, -1245682094, -1660358170, 183, '2020-05-10 07:36:02+00:00', '2022-01-23 03:13:33+00:00', -988981234, '2022-08-03 01:56:16+00:00', '0dz79f', 'gq8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 195720193, 1774087382, '2020-02-13 02:40:04+00:00', 2035306060, 1523825314, 'u5', -1, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, 4, '1970-01-01 00:00:00+00:00', '2024-03-11 08:01:44+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -57705450, -915385605, '2020-04-12 14:45:54+00:00', -405743609, -1935752926, '5i3', -1, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58', -1125548818, 1497321728, -95808609, 3, '1969-12-31 23:59:59+00:00', '2022-08-10 04:39:07+00:00', 1273687251, '2024-11-29 13:11:46+00:00', 'mnajjla3', 'okv8uttmu2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1402164108, 2123471885, '2025-08-19 19:51:44+00:00', -526633767, 448935289, 'be8yvkv', 183, '2024-11-18 17:17:10+00:00', '2q7sx58b', 'pmaus3au', -699574669, 274891948, 609771851, -1, '2020-06-03 10:00:15+00:00', '2021-03-23 21:08:32+00:00', 1105964624, '2023-06-01 10:01:12+00:00', 'w5chn9mo705a', '9n0jxfofwsz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 2015094998, 1010672881, '2023-05-26 04:07:05+00:00', 270415200, -2071531094, 'q0k32od', 183, '2023-01-14 08:25:47+00:00', 'l', '5amsorlwyngc', -323362455, 453340472, 211603887, 183, '2025-05-23 18:24:29+00:00', '2025-08-08 02:41:00+00:00', -413043724, '2025-10-05 07:32:01+00:00', '1yo', 'yo');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -2061634386, -850941333, '2025-02-14 08:12:06+00:00', 868039568, 503053726, 'z', 1, '2023-12-20 17:13:08+00:00', 'tajz9td8n', '5wcgumbc3td', 1964331395, -1943814113, 1514371324, 3, '1969-12-31 23:59:59+00:00', '2024-10-13 14:46:56+00:00', -379749892, '2025-01-19 15:40:16+00:00', 'vzxw1rxe9yf', '7qk');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, 643589729, -1231488097, '2024-03-03 12:11:16+00:00', 774922170, 2105860871, 'dohvu06d', 0, '2023-05-21 01:39:33+00:00', '3', 'rmkio18r', 431832073, 1510892261, 1677948887, -1, '1970-01-01 00:00:00+00:00', '2025-01-09 08:20:29+00:00', 769234989, '2025-01-05 20:14:57+00:00', 'ftp6ewtqx', 'njabym');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 1528227252, -1277305894, '2023-02-03 12:07:21+00:00', 1243701948, -156175571, '6sto', 1, '2023-09-09 05:17:59+00:00', 'j', 'sh5knzys7', 1487347213, 1328948152, -1923069176, -1, '1970-01-01 00:00:00+00:00', '2024-12-17 00:18:59+00:00', -1520090613, '2025-06-04 14:14:14+00:00', 'ja', 'h');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (183, -55602865, '2024-02-19 01:18:26+00:00', 't2__b96986', '2022-06-06 02:35:43+00:00', 'wqcgsk', 't2__9ccb02', '9n8c4pgu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '2022-01-22 16:14:13+00:00', 's5bbp02e', 'tliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1485335077, '2024-12-22 09:14:04+00:00', 'rq13pyu', '2024-06-05 19:22:34+00:00', 'd99rljsl0', '4', 'p5qi2rk', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -1888505890, '2025-10-16 14:52:58+00:00', '16nijja', '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '8', 'yzt1afgogrit', 678047687, -1478134144, -491938169, -106471771, 1235416111, 'jh3den8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', '2024-05-07 03:46:17+00:00', 'n', 'u5zi', '6c4bfkfo', -1950324754, 2115816682, 76987628, -253138337, 641521863, 'o7w');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -477129795, '2025-10-17 20:09:18+00:00', 'zkb521', '2020-11-29 19:49:13+00:00', 'nlas6e', 'lboeowii1z5', 'xih6', -251205568, 287256667, 1614799674, 1083479253, 1774679448, 'oaawg96aq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.Id = 183 ORDER BY T1.LastEditDate DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__b96986', 't2__9ccb02')
*/

-- Prediction Query
SELECT "users"."displayname", "users"."location" FROM "users" INNER JOIN "posts" ON "users"."id" = "posts"."lasteditoruserid" WHERE "posts"."id" = 183 AND "posts"."lasteditdate" = (SELECT MAX("lasteditdate") FROM "posts" WHERE "id" = 183 AND NOT "lasteditoruserid" IS NULL);

/*
Prediction Result:
*/