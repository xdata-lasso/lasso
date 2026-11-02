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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'Open source tools for visualizing multi-dimensional data?', 'e5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1438850342, -305670381, '2021-03-25 19:22:18+00:00', 105869088, -2081315180, '2dwyrq13pyu7', 1, '2024-08-08 00:51:45+00:00', 'Open source tools for visualizing multi-dimensional data?', '9', 244829661, -1362461264, -904834265, -2147483647, '2023-07-26 21:52:05+00:00', '2020-03-25 00:00:06+00:00', 1692174491, '2024-03-18 20:04:07+00:00', 'i2rkf', 'vqx58pz0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 172461907, 1606439408, '2021-05-16 14:38:12+00:00', -155284187, 1686459626, 'lyr', 3, '2021-06-12 16:42:05+00:00', 'Open source tools for visualizing multi-dimensional data?', 'n6vck6ah0f', 138842628, -932772113, -639539893, 1, '2022-03-20 09:18:33+00:00', '2024-06-08 00:23:27+00:00', 1255343543, '2020-03-06 15:32:29+00:00', '72fxa7ryfd', 'z16ni');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1180042408, 199672698, '2023-06-27 00:27:42+00:00', -1962347906, -866772222, 'ttg6', 4, '2020-03-23 04:17:18+00:00', 'Open source tools for visualizing multi-dimensional data?', 'ou5z', 1691780814, 1944978593, 1722106924, 2, '2020-02-23 23:54:56+00:00', '2020-09-25 02:07:37+00:00', -1173368267, '2025-01-04 09:05:19+00:00', 'd', '7z2zezj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -604098478, 1248858185, '2020-06-06 19:46:47+00:00', 1999335832, -526612570, 'cmr0oz', 4, '2022-07-12 13:13:05+00:00', 'Open source tools for visualizing multi-dimensional data?', 'g', -20116244, -176606723, -15162884, -2147483647, '2021-11-07 05:17:12+00:00', '2022-01-04 01:02:12+00:00', 1692046802, '2021-09-04 22:07:03+00:00', 'k58qs27p', 'r94gth2m');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, -2136247961, -1478011227, '2020-02-06 22:46:22+00:00', 1919033056, -1428186898, 'uttmu2ne5', 4, '2024-11-14 17:33:35+00:00', 'Open source tools for visualizing multi-dimensional data?', '8lfvyz7zz', -2052653308, -489120589, -72442907, -2147483647, '2022-03-14 12:32:27+00:00', '2024-11-20 13:19:41+00:00', -2060082151, '2025-08-08 12:00:20+00:00', 'maus', 'auvmkrpd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1105964624, -663234145, '2020-04-07 03:05:00+00:00', -1674145149, 234957614, 'o705a9n0jxfo', 1, '2020-09-13 06:13:20+00:00', 'Open source tools for visualizing multi-dimensional data?', 'szdo2z', 270415200, -2071531094, -397848196, -2147483647, '2025-04-29 20:31:18+00:00', '2025-07-15 16:41:07+00:00', 375841374, '2021-05-20 02:31:08+00:00', '2odwcl5a', 'msorlwyngc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 681061317, 1935791961, '2025-06-07 08:57:59+00:00', -413043724, 761519897, 'yoeyo6l', 1, '2023-07-16 23:01:09+00:00', 'Open source tools for visualizing multi-dimensional data?', 'dt', -795975227, 1294064538, 778835680, 2, '2023-05-18 17:35:26+00:00', '2021-06-11 00:32:43+00:00', 450555855, '2023-11-05 01:08:45+00:00', 'gwnlas6', 'elboeowii1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -251205568, 287256667, '2023-03-16 20:38:44+00:00', 412199481, 727608179, 'awg96aqb0tbi', 1, '2025-04-01 08:16:25+00:00', 't1__88397c', 'dz39', 2085299664, 2038321753, 1376887048, -2147483647, '2024-10-08 16:57:12+00:00', '2022-08-02 17:02:31+00:00', 748154000, '2023-01-06 00:58:47+00:00', 'g', 'mbc3td');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 5, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 6, '2024-11-14 12:35:58+00:00', 'Open source tools for visualizing multi-dimensional data?', 'n8c4pgu7v', -1865039888, 1160656988, -992890117, 4, '2020-01-15 18:18:33+00:00', '2023-10-02 15:43:02+00:00', 1219478689, '2022-10-06 13:20:05+00:00', 'hsrwbbp', 'luhvdltti');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't2__22c7e0', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1179823637, '2021-09-24 11:50:48+00:00', 't2__22c7e0', '2025-01-09 01:18:18+00:00', 'rqrofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1937207087, '2023-09-10 09:37:01+00:00', 'y9uxj4', '2021-01-22 00:53:52+00:00', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', -1898531797, -1748371085, -1742081330, 894242932, -211209314, 'dqv0gcb9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 2011234363, '2021-04-25 14:26:05+00:00', 't2__22c7e0', '2020-01-23 21:20:16+00:00', '5dh', 'ogrgjd8y', 't1afgog', -946046410, -902895762, -197933860, 2111987706, -598313376, 'q4301jh');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1476361420, '2021-11-04 04:05:36+00:00', 'c68x8vacx', '2024-05-22 05:48:31+00:00', 'f', '5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Title = 'Open source tools for visualizing multi-dimensional data?';

/*
Gold Result:
('t2__22c7e0',)
('t2__22c7e0',)
('y9uxj4',)
('c68x8vacx',)
('c68x8vacx',)
('c68x8vacx',)
('t2__22c7e0',)
('t2__22c7e0',)
(None,)
*/

-- Prediction Query
SELECT "users"."displayname" FROM "posts" INNER JOIN "users" ON "posts"."lasteditoruserid" = "users"."id" WHERE "posts"."title" = 'What are some valuable Statistical Analysis open source projects?';

/*
Prediction Result:
*/