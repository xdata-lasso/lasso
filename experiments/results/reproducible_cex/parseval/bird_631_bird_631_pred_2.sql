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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Daniel Vassallo', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1666765085, '2025-11-19 11:50:18+00:00', 'Daniel Vassallo', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 222415430, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'Daniel Vassallo', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1038707349, '2024-12-31 04:19:17+00:00', 'Daniel Vassallo', '2024-10-02 15:57:32+00:00', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 418417917, -1031969798, -1106983592, 1884179925, 902551284, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1021749117, '2025-01-11 14:32:08+00:00', 'Daniel Vassallo', '2023-11-27 00:51:18+00:00', 'yu78', '9', 'rljsl0b4y', -1116181514, 1255852738, -1555456236, -975213201, -705985602, 'x58pz0f8je');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1898531797, '2024-06-08 14:05:00+00:00', 'Daniel Vassallo', '2024-09-12 11:18:07+00:00', 'fjgq8n2f3dq', '0gcb98', 'zk3z', 1686459626, -1554531873, 982314585, 638024588, -688098735, '6ah');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1746373317, '2020-07-12 19:51:25+00:00', 'Daniel Vassallo', '2025-07-17 09:46:47+00:00', '5o', 'rg', 'd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -47052816, '2025-07-13 05:36:35+00:00', 'Daniel Vassallo', '2023-09-05 10:31:30+00:00', 'f77p', 'o72ctdc', 'mfg62', -1744557630, 1870300798, 820970595, 1421303999, -1488156735, '1i');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, -2147483648, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -1748371085, -2147483648, 'q8', '2021-10-07 12:15:00+00:00', 4, 'f3dqv0gc', '9', 'ozk3zbily');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 1038566008, -2147483648, 'n6vck6ah0f', '2024-07-11 21:09:52+00:00', 4, 'sww', 'q7x', '7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1350414441, -2147483648, 'a7ryfd', '2022-05-09 09:35:03+00:00', 4, 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -946046410, -2147483648, 'tsj3ayxp1q4', '2023-11-21 06:57:41+00:00', 4, '1jh3den', 'c68x8vacx', 'afu5w1of7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -435350511, -2147483648, '72ctdctmfg62', '2020-10-18 11:14:36+00:00', 1, 'v5q8qdj', 'e1io', '278507cv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -1523347137, -2147483648, 'ttg6bnou5zi3', '2024-05-05 04:13:50+00:00', 1, '4', 'f', 'foa');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -468701684, -2147483648, '7wgx', '2020-06-06 19:46:47+00:00', 1, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 1379859112, -2147483648, 'qs27p2r94', '2020-11-05 16:17:26+00:00', 1, 'h2mna', 'jla', 'okv8uttm');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1437333179, -2147483648, 'wwqcg', '2022-06-28 11:34:24+00:00', 2, '9n8', '4', 'gu7v');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -1910425938, -2147483648, 'tilbn', '2022-01-18 15:57:55+00:00', 5, 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 743312762, -2147483648, 'eutliqa11r', '2023-03-22 03:47:49+00:00', 6, 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 910894705, -2147483648, '1vy9uxj4', '2021-01-22 00:53:52+00:00', 7, 'bdvlph', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, -1520489792, -2147483648, 'wlq7xb', '2025-02-02 06:02:30+00:00', 8, '2fxa7ryfd', 'z16ni', 'jai');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, 518609210, -2147483648, '3d', '2020-08-20 06:07:09+00:00', 9, '8c68', '8vacx7', 'f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, -241848752, -2147483648, '8507cvtjp', '2025-12-22 07:46:37+00:00', 10, 'tg6bn', 'u5zi', '6c4bfkfo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Daniel Vassallo';

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(*) AS PostCount FROM users INNER JOIN posts ON users.Id = posts.OwnerUserId WHERE users.DisplayName = 'Daniel Vassallo';

/*
Prediction Result:
(1,)
*/