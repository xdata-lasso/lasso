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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1746373317, 1360271423, '2024-02-27 00:46:50+00:00', -1738458256, 1, 'jd', 1, '2024-07-26 15:42:53+00:00', 'yzt1afgogrit', 'sj3ayxp1q430', 1923912467, 518609210, 1948383687, 1, '2020-06-27 17:29:33+00:00', '2020-08-20 06:07:09+00:00', 195720193, '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1488156735, -1858644047, '2021-03-11 03:10:40+00:00', 1897687032, -241848752, '8507cvtjp', -2147483647, '2025-12-22 07:46:37+00:00', 'tg6bn', 'u5zi', 1944978593, 1722106924, -2072838897, 1, '2021-05-31 16:00:51+00:00', '2020-10-11 01:34:34+00:00', 1923659053, '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1055237066, 988954859, '2020-11-05 16:17:26+00:00', -244633520, 418247369, 'jla', 2, '2023-12-07 12:32:22+00:00', 'okv8uttmu2', 'e578', 1908593332, 697257217, -451030047, 2, '2025-05-30 03:33:11+00:00', '2025-02-28 08:35:18+00:00', -2052653308, '2024-08-15 05:55:27+00:00', 'yvkv42q7sx58', 'b4pmaus3auv');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 5, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', 1, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1602639011, -45536098, '2021-11-09 05:42:50+00:00', 44952191, 1151980946, 'a9', -2147483647, '2023-06-17 21:52:40+00:00', '00t5c4ecigc', 'e376nium52', -443340271, 757448742, -1179823637, 7, '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '5s5b');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't3__19bbe7', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -305670381, '2021-03-25 19:22:18+00:00', 't3__19bbe7', '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 176555546, '2020-08-21 23:51:43+00:00', 't3__19bbe7', '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1719800120, '2020-06-20 19:03:43+00:00', 't3__19bbe7', '2021-11-19 20:08:24+00:00', '2zobb0q0k32o', 'w', 'l', 895277769, 364043263, -1177989415, -1352968577, -519515742, 'gc1dj9erhi');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1056589776, '2020-11-27 04:53:28+00:00', 'k1yoeyo6l0h', '2020-05-28 05:20:14+00:00', '6fuqy', 'uzkb52', 'gwnlas6', -2076274980, 1731324803, -1159083009, -1589605308, -268740517, 'nxih662q');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, 328305758, 1, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -1099855564, 2, '72ct', '2020-06-07 10:59:23+00:00', -2147483647, 'Computer Game Datasets', 't', 'mfg62g0v5q8q');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 983324983, 3, 'ztdg', '2021-03-26 14:01:04+00:00', 2, 'Computer Game Datasets', '5i3lq5lnpim5', '58q');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 274891948, 4, 'pdjwzw5chn9', '2021-08-16 22:45:01+00:00', 1, 'Computer Game Datasets', 'o705a9n0jxfo', 'ws');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1396673167, 1, 'otow9oaawg', '2024-09-22 16:04:20+00:00', -2147483647, 'Computer Game Datasets', 'aqb0tbind', '39tajz9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, 152478847, 4, '5wcgumbc3td', '2024-11-28 14:19:46+00:00', 1, 'Computer Game Datasets', '6bd0w9', '03vzxw1rx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -505019168, 1, '7qk', '2024-12-06 05:16:35+00:00', 4, 'Computer Game Datasets', '162nh55y3d', 'ohvu06dza3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 1595632888, 4, 'mkio18ri2hy', '2025-09-10 18:51:56+00:00', 4, 'Computer Game Datasets', '08ftp6ewtqx', 'njabym');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 1528227252, 1, 'fx7h', '2023-12-11 11:19:14+00:00', 4, 'Computer Game Datasets', 'p6sto1cj', 'sh5knzys7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -531932574, 1, 'jmgjach', '2024-07-16 00:46:06+00:00', 3, 'Computer Game Datasets', 'qta8y3a17v4y', 'ma');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -1941472821, 1, 'uap96rntdqr', '2020-12-10 17:13:46+00:00', 3, 'Computer Game Datasets', '5wli', '7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 1409697108, 3, 'p490xdmsqt', '2020-11-30 04:51:31+00:00', 3, 'Computer Game Datasets', 'lc', 'qb9i9f');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, -1541581575, 3, '1quik1yhb08h', '2021-07-19 11:24:33+00:00', 2, 'Computer Game Datasets', 't1pqo', 'iztv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483635, 195316816, 3, 'qlud8', '2020-09-11 22:26:51+00:00', 3, 'Computer Game Datasets', 'tb8r9114qbre', '6bjeuuwsj8k');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483634, 1138926079, 1, 'pxlvri', '2022-06-18 15:18:07+00:00', 1, 't1__e3beaa', 'urz0kaqtncg', 'c8s3b7v88k');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, 1, 5, 'value', '2024-06-15 00:00:00+00:00', 2, NULL, 'value', 'value');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 13244799, 6, 'hvdltt', '2021-01-23 18:11:33+00:00', 2, 'Computer Game Datasets', 'bnp', 'mdpos');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 328305758, 7, 'tliqa1', '2023-08-19 04:29:46+00:00', 1, 'Computer Game Datasets', 'yytoo', 'o9hl72kl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(1, 't3__19bbe7')
(1, 't3__19bbe7')
(-241848752, 't3__19bbe7')
(418247369, 't3__19bbe7')
(1, 't3__19bbe7')
(418247369, 't3__19bbe7')
(1, 't3__19bbe7')
(418247369, 't3__19bbe7')
(1, 't3__19bbe7')
(-241848752, 't3__19bbe7')
(-241848752, 't3__19bbe7')
(-241848752, 't3__19bbe7')
(1, 't3__19bbe7')
(1, 't3__19bbe7')
(None, 't3__19bbe7')
(1151980946, None)
*/

-- Prediction Query
SELECT p.ViewCount, u.DisplayName FROM posts AS p INNER JOIN users AS u ON p.LastEditorUserId = u.Id WHERE p.Title = 'Computer Game Datasets';

/*
Prediction Result:
*/