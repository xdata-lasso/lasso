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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -566887085, 602161869, '2020-09-05 12:25:49+00:00', 2094425101, -961217731, 'dr', 4, '2025-10-16 14:52:58+00:00', '16nijja', '5dh', 1583472758, 1449284300, -977470238, 4, '2021-04-29 02:40:32+00:00', '2020-06-19 19:37:13+00:00', 1074760385, '2023-05-06 21:04:41+00:00', '1afgo', 'ri');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -290314193, 76996700, '2023-05-23 12:32:01+00:00', 87529806, -1957268147, 'c', 3, '2022-08-05 18:12:12+00:00', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, 3, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Community', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1055976837, '2023-08-25 07:55:29+00:00', 'Community', '2024-02-08 07:13:40+00:00', 'i7z', 'au2dwy', 'q13py', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 556727997, '2024-02-28 14:45:41+00:00', 'pz0f8jegd', '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, -1264842910, -1052964641, -1245682094, 'x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -734455130, '2020-07-23 07:32:15+00:00', 'Community', '2024-02-11 16:43:27+00:00', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -1364429300, -1257178728, 1236688122, 2087640001, 907682809, 'siie');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -868774469, '2021-03-04 19:22:02+00:00', 'Community', '2022-02-19 15:51:21+00:00', '1', 'ryytoo3', '9hl7', 1178636309, -1390245819, 1055976837, 1775126557, -74849714, '7zw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1196308825, '2020-06-01 02:38:05+00:00', 'Community', '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, -1264842910, -1052964641, -1245682094, 'x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -566887085, '2025-02-02 06:02:30+00:00', 'Community', '2024-06-19 13:37:53+00:00', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 820970595, '2024-07-28 14:01:55+00:00', 'Community', '2022-03-25 04:01:18+00:00', 'j', 'e1io', '278507cv', -866772222, -847293924, -2033879835, 1798111945, 944975670, 'i36c4bf');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 722884590, 1, 'hncprjtu0dz', '2024-06-08 14:05:00+00:00', 4, 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, -902895762, 3, 'ayxp1q43', '2023-06-28 02:52:00+00:00', 1, 'jh3den8', 'c68x8vacx7', 'f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 382831862, 1, '0', '2025-09-08 19:36:12+00:00', 4, 'z2zezjo7w', 'xd', 'ysxcmr0o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -55240145, 3, '8qs27p2r', '2024-09-21 04:14:02+00:00', 1, '4gth2mnajjla', 'okv8uttm', '2ne578');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -489120589, 1, 'v42', '2022-03-14 12:32:27+00:00', 4, '7sx58b4pma', 'us3auvmkrpdj', 'wzw5chn9mo70');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, 2015094998, 3, '2zobb0q0k32o', '2020-06-28 23:31:51+00:00', 1, 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 778835680, 1, 'kb521gw', '2021-10-10 22:42:32+00:00', 4, 'as6', 'elboeowii1', '5nxih66');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, -2094843966, 3, '96', '2020-01-10 04:27:01+00:00', 1, 'qb0tbindz39t', 'j', '9td8n5w');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 1147652228, 1, 'u', '2024-04-21 17:44:41+00:00', 1, 'd', 'w9603vz', 'xw1rxe9yfk7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -1046720861, 1, '162nh55y3d', '2025-02-15 07:25:43+00:00', 1, 'hvu0', 'dza35rmki', '18ri');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, -1670945624, 1, 'wlic7dn2', '2021-10-14 23:04:20+00:00', 1, 'p490xdmsqt', 'el', 'u');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, 1584429327, 1, 'k1y', '2025-10-15 06:35:43+00:00', 1, 'b0', 'hlst1pqom', 'ztv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -734455130, 1, '4h', '2022-04-15 05:01:35+00:00', 2, 'a2y', 'uzhs', 'rwbbp6luhvd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -45536098, 1, 'w6kl', '2020-09-15 12:11:12+00:00', 5, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 481163439, 1, '2dwyrq', '2023-09-08 22:37:16+00:00', 6, '3pyu78d99r', 'jsl', 'b4yp5qi');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 722884590, 1, 'hncprjtu0dz', '2024-06-08 14:05:00+00:00', 7, 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, 1923912467, 1, 'jh3den8c68', '2023-02-21 21:59:10+00:00', 8, 'vacx7afu5', '1of77p', 'o72ctdc');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, -1173368267, 1, 'cd07z2zezjo7', '2024-11-08 11:45:59+00:00', 9, 'gxd5ys', 'cmr0oz', 'dgj5i');

-- Inserting into table: tags --
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483648, '9hl7', 1178636309, 1, -1390245819);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483647, '6vck6ah0f8js', -658391922, 1, -1388029300);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483646, '4', -2072838897, 2, -1173368267);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483645, 'ztdgj5i3lq5l', 1339733032, 1, -1556979799);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483644, 'fvy', -451030047, 2, -2052653308);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483643, 'a9n0jxfo', -1793230843, 1, -441521858);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483642, 'o6l0hdt', -795975227, 2, 1294064538);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483641, 'q2xlyoto', 1774679448, 1, 205676091);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483640, 'g', -794767771, 2, 989306270);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483639, 'hy08ftp6', -1853955201, 1, -805997097);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483638, 'xnjaby', 462225708, 1, 1528227252);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483637, 'fx7h', -156175571, 1, 1220047834);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483636, '6sto1cj8sh5k', 1106724223, 1, 1966809332);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483635, '7dyyd', 357443379, 1, -1502591405);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483634, 'h', 1122899168, 1, -161108900);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483633, '7v4ygma', -499203870, 1, 1509621238);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483632, 'dpuap', -845136979, 1, -1042976410);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483631, 'qb9i9f2ccu', -1414362698, 1, 1046248997);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483630, '6', -1304516770, 1, -1558272216);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (2, '5k5swwqcgs', 247012447, 1, -1980249628);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3, '5k5swwqcgs', 247012447, 1, -1980249628);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (4, 'qyp5s5bbp0', 743312762, 1, -1822992503);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (5, 'rkf9vqx5', 1836127587, 1, -1529584866);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (6, '6vck6ah0f8js', -658391922, 1, -1388029300);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (7, 'mfg62', -1744557630, 1, 1870300798);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN INSTR(tags, '|r|') > 0 OR tags = 'r' OR INSTR(tags, 'r|') = 1 OR INSTR(tags, '|r') = LENGTH(tags) - 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage FROM posts INNER JOIN users ON posts.owneruserid = users.id WHERE users.displayname = 'Community';

/*
Prediction Result:
(50.0,)
*/