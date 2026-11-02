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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1072996612, 13244799, '2022-09-23 20:24:07+00:00', 1019800248, -1910425938, 'tilbn', 1, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 244829661, '2021-07-21 20:51:39+00:00', 'sl0', '2020-03-25 00:00:06+00:00', 'yp5qi2rk', '9v', 'x58pz', -1529584866, 1196308825, 910894705, -283454505, 233994589, 'j4hwbd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -736979194, '2022-01-26 11:13:48+00:00', 'h2gndqwnqcx5', '2025-05-27 16:57:17+00:00', 'nc', 'rjtu', 'dz79fjg', -1255130038, -1762857309, 806170397, 513454646, -688216274, 'gcb98ozk3z');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 3, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 3, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 3, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 1, 't2__f893bc', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483637, 1, 't2__f893bc', '2002-04-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 1, 'pim5', '2021-06-04 00:33:11+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 1, '8qs27p2r', '2024-09-21 04:14:02+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 1, 'value', NULL);

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 1, 'okv8uttmu2', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 1, '57', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 1, 'vy', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, 1, 'zzbe8yvkv', '2013-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (11, 1, 'q7sx58b4', '2013-01-01 00:00:00+00:00');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -1585009206, 1, '52zb', '2013-01-01 00:00:00+00:00', 1, 'uo4nrqrofqy', '5s5b', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 2107872094, 1, '02eutliqa11r', '2013-01-01 00:00:00+00:00', 1, 'ytoo3o9', 'l7', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 1178636309, 1, 'ex1', '2013-01-01 00:00:00+00:00', 1, 'ji7zwau2', 'dwyrq13pyu78', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1686459626, 1, 'lyr', '2013-01-01 00:00:00+00:00', 2, 'kn6vck6ah0f8', 'sww', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1388029300, 1, 'xb72fxa7r', '2013-01-01 00:00:00+00:00', 2, 'fdrz16n', 'jja', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -7597509, 1, 'h5ogrgjd8yz', '2013-01-01 00:00:00+00:00', 2, '1afgo', 'ri', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -902895762, 1, 'ayxp1q43', '2013-01-01 00:00:00+00:00', 1, '1jh3den', 'c68x8vacx', 't1__04cec7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -1762140823, 1, 'w1of77pz', '2010-03-31 23:59:59+00:00', 1, '72ct', 'c', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 1303877941, 1, 'mfg62g0v5q8q', '2013-01-01 00:00:00+00:00', 1, 'j', 'e1io', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, 199672698, 1, '7cvtjpt', '2025-02-24 17:48:00+00:00', 1, 'g6bno', '5zi36c', 'bfkfoacd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 76987628, 1, 'zezjo7wg', '2023-03-07 00:15:11+00:00', 1, '5', 'sxcmr0o', 'ztdgj5i3lq5l');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -1719383707, 1, '2m', '2013-01-01 00:00:00+00:00', 1, 'ajjl', '3', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 1, 1, 'value', NULL, 1, 'value', 'value', 'Samuel');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, 1, 1, 'value', NULL, 1, 'value', 'value', 't1__2f8247');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, 1, 1, 'value', '2013-01-01 00:00:00+00:00', 1, 'value', 'value', NULL);

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, 1, 1, 'value', '2000-03-01 23:59:59+00:00', 1, 'value', 'value', NULL);

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (11, 1, 1, 'value', NULL, 1, 'value', 'value', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
(1, '57')
(1, 'okv8uttmu2')
(1, 'q7sx58b4')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 'vy')
(1, 'zzbe8yvkv')
(1, '57')
(1, 'okv8uttmu2')
(1, 'q7sx58b4')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 'vy')
(1, 'zzbe8yvkv')
(1, '57')
(1, 'okv8uttmu2')
(1, 'q7sx58b4')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 'vy')
(1, 'zzbe8yvkv')
(1, '57')
(1, 'okv8uttmu2')
(1, 'q7sx58b4')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 'vy')
(1, 'zzbe8yvkv')
(1, '57')
(1, 'okv8uttmu2')
(1, 'q7sx58b4')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 't2__f893bc')
(1, 'vy')
(1, 'zzbe8yvkv')
*/

-- Prediction Query
SELECT T1.Id, T2.Name FROM posts AS T1 INNER JOIN badges AS T2 ON T1.OwnerUserId = T2.UserId INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id WHERE T3.DisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreaionDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Prediction Result:
*/