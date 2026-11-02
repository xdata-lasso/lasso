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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, 1, 'nprmdposii', 1, '2020-08-22 06:30:10+00:00', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, 1, '2021-08-19 01:10:02+00:00', '2024-10-24 14:16:53+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 894242932, 1, 'f3dqv0gc', -2147483647, '2020-04-02 07:45:47+00:00', '8ozk3zbil', 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, 2, '2024-06-08 00:23:27+00:00', '2023-02-17 08:54:45+00:00', -541746689, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 195720193, 1774087382, '2020-02-13 02:40:04+00:00', 2035306060, 1, 'x7afu5w1of77', 1, '2022-01-27 19:59:15+00:00', 'o72ctdc', 'mfg62', -1744557630, 1870300798, 820970595, 3, '2024-07-28 14:01:55+00:00', '2022-03-25 04:01:18+00:00', -1488156735, '2020-07-27 22:34:35+00:00', 'io22785', '7cvtjpt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 76987628, -253138337, '2020-07-17 23:11:50+00:00', -468701684, 1448731351, 'wgxd5ysxc', 3, '2021-08-06 04:52:45+00:00', '0oztd', 'j5', -1609653472, -1405314653, 1816660482, 1, '2021-07-27 00:10:12+00:00', '2021-11-07 05:17:12+00:00', -1556979799, '2024-02-22 11:40:18+00:00', '58q', 's27p2r94gth2');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -526633767, 448935289, '2023-04-29 21:53:50+00:00', -2052653308, -489120589, 'v42', -2147483647, '2022-03-14 12:32:27+00:00', '7sx58b4pma', 'us3auvmkrpdj', 1105964624, -663234145, -2013213247, 1, '2021-10-23 07:09:38+00:00', '2024-09-19 09:49:38+00:00', 101754718, '2024-02-20 06:09:53+00:00', 'a9n0jxfofws', 'do2zobb');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 5, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 1, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1602639011, -45536098, '2021-11-09 05:42:50+00:00', 44952191, 1151980946, 'a9', -2147483647, '2023-06-17 21:52:40+00:00', '00t5c4ecigc', 'e376nium52', -443340271, 757448742, -1179823637, 7, '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '5s5b');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't3__a7fd35', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -305670381, '2021-03-25 19:22:18+00:00', 't3__a7fd35', '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 176555546, '2020-08-21 23:51:43+00:00', 't3__a7fd35', '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -7597509, '2025-07-17 09:46:47+00:00', '5o', '2020-10-22 21:08:07+00:00', 'gjd8y', 't1afgog', 'itsj3', -491938169, -106471771, 1235416111, 1923912467, 518609210, '3d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 211603887, '2025-05-23 18:24:29+00:00', 'rhizgk1yoey', '2025-04-08 19:28:10+00:00', '6l0h', 't', 'fuqyxuzkb', -30041412, -277407746, -670154354, -2140468103, 469838697, 'lboeowii1z5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, 328305758, 1, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 1467355421, 2, 'ou5z', '2021-02-17 19:49:53+00:00', -2147483647, 'Computer Game Datasets', '6c4bfkfo', 'c');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 418247369, 3, 'jla', '2023-12-07 12:32:22+00:00', 2, 'Computer Game Datasets', 'okv8uttmu2', 'e578');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 375841374, 4, '32o', '2020-06-28 23:31:51+00:00', 3, 'Computer Game Datasets', 'cl5ams', 'orlwyngc1dj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1552469358, 1, '62q2xlyot', '2025-07-02 03:36:52+00:00', -2147483647, 'Computer Game Datasets', 'w9oa', 'awg96aqb0tbi');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -1897615568, 4, '9tajz9td', '2024-07-21 17:54:15+00:00', 2, 'Computer Game Datasets', '5wcg', 'mbc3td');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -1943814113, 1, '9603vz', '2025-10-31 13:59:15+00:00', -2147483647, 'Computer Game Datasets', 'xw1rxe9yfk7', 'k162n');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 774922170, 4, '3dohvu0', '2024-04-24 18:29:26+00:00', 3, 'Computer Game Datasets', 'z', '3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 1595632888, 1, 'mkio18ri2hy', '2025-09-10 18:51:56+00:00', 4, 'Computer Game Datasets', '08ftp6ewtqx', 'njabym');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 1528227252, 1, 'fx7h', '2023-12-11 11:19:14+00:00', 4, 'Computer Game Datasets', 'p6sto1cj', 'sh5knzys7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 1328948152, 1, '1', '2024-12-17 00:18:59+00:00', 1, 'Computer Game Datasets', 'mgj', 'c');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 280292620, 3, 'a8y3a17v4yg', '2024-11-09 23:43:28+00:00', -2147483647, 'Computer Game Datasets', 'ayq3', 'dpuap');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, -1042976410, 3, 'm5', '2025-01-14 14:36:19+00:00', 1, 'Computer Game Datasets', 'wlic7dn2np', '90xdmsqt');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, -1025517017, 3, 'i9f2ccukj', '2022-02-26 17:54:28+00:00', 4, 'Computer Game Datasets', '1quik1yhb08h', 'st1');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, 2101986789, 1, 'mizt', '2025-05-30 09:57:11+00:00', 4, 't1__44bb4b', 'b6m4iz', '78aqqlud8ft');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, 1, 5, 'value', '2024-06-15 00:00:00+00:00', 2, NULL, 'value', 'value');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 13244799, 6, 'hvdltt', '2021-01-23 18:11:33+00:00', 2, 'Computer Game Datasets', 'bnp', 'mdpos');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 328305758, 7, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(1, 't3__a7fd35')
(1, 't3__a7fd35')
(1448731351, 't3__a7fd35')
(-489120589, 't3__a7fd35')
(1, 't3__a7fd35')
(-489120589, 't3__a7fd35')
(1, 't3__a7fd35')
(-489120589, 't3__a7fd35')
(1, 't3__a7fd35')
(1448731351, 't3__a7fd35')
(1448731351, 't3__a7fd35')
(1448731351, 't3__a7fd35')
(1, 't3__a7fd35')
(1, 't3__a7fd35')
(None, 't3__a7fd35')
(1151980946, None)
*/

-- Prediction Query
SELECT T1.ViewCount, T2.DisplayName FROM posts AS T1 JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title = 'Computer game datasets';

/*
Prediction Result:
*/