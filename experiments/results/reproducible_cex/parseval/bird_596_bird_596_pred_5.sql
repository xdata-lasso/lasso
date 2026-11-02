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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 13244799, -1659388584, '2020-06-20 11:35:06+00:00', -1377057208, -841692980, 'bnp', 1, '2022-04-12 01:47:28+00:00', 'dpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -688509700, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1360271423, '2024-02-27 00:46:50+00:00', 'grgj', '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3', 'y', -598313376, 1972233925, 1792827279, 804529642, -1538707438, 'den8c68x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -1941472821, '2025-06-16 07:53:05+00:00', 'ap96rn', '2022-07-31 02:11:06+00:00', 'q', 'hm5wl', 'c7d', 594760660, 833568923, -384749431, -934098178, -827883679, 'lc');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 't1__8ebcba', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 't1__8ebcba', '2021-07-01 18:29:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 't1__8ebcba', '2020-08-18 16:30:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 3, 't1__8ebcba', '2021-10-07 12:15:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 1, 't1__ed63ee', '2023-11-01 15:52:25+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 3, 't1__8ebcba', '2025-07-17 09:46:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 0, 't1__ed63ee', '2024-08-13 21:17:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 3, 't1__8ebcba', '2022-07-15 10:34:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 't1__ed63ee', '2021-03-27 11:42:11+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 3, 't1__8ebcba', '2025-11-16 21:50:04+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 1, 't1__ed63ee', '2024-03-22 11:27:27+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483637, 3, 't1__8ebcba', '2023-05-05 20:15:58+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483636, 1, 't1__ed63ee', '2024-06-27 07:12:45+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483635, 0, 't1__8ebcba', '2024-12-02 03:34:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483634, -1, 't1__ed63ee', '2022-09-26 08:18:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483633, 0, 't1__8ebcba', '2025-08-27 08:26:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483632, -1, 't1__ed63ee', '2024-04-28 21:55:59+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483631, 0, 't1__8ebcba', '2020-12-25 11:02:58+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483630, -1, 't1__ed63ee', '2025-03-01 13:00:27+00:00');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, -1585009206, '52zb', '2025-10-02 08:51:14+00:00', 1, 'o4nrqr');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, -2147483648, 775304493, 'qyp5s5bbp0', '2025-09-22 03:26:15+00:00', 1, 'eutliqa1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, -2147483648, 274769912, 'oo3o9', '2020-12-13 17:48:30+00:00', 1, '72k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -2147483648, 1775126557, 'ji7zwau2', '2025-11-10 22:24:59+00:00', 1, 'w');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, -2147483648, -953437896, '3pyu78d', '2024-09-04 21:17:21+00:00', 1, 'rljsl0b4y');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -2147483648, -1025564911, 'rkf9vqx5', '2024-08-09 01:13:45+00:00', 1, 'pz0f8jegd21');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, -2147483648, -1056308489, 'gcb98oz', '2021-05-16 14:38:12+00:00', 1, 'zbilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, -2147483648, -1672720816, '8j', '2022-05-28 16:44:30+00:00', 1, 'wlq7xb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, -2147483648, 1350414441, 'a7ryfd', '2022-05-09 09:35:03+00:00', 1, 'z16nijjai5d');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, -2147483648, 1732258051, 'afu5w1of7', '2024-05-28 03:27:01+00:00', 0, 'zo72');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, -2147483648, -820614248, 't', '2025-11-30 16:40:04+00:00', 0, 'mfg62g0v5q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, -2147483648, -1488156735, '1i', '2021-11-30 19:51:17+00:00', 0, '278507cv');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, -2147483648, 1582582341, 'tg6bnou5zi', '2023-12-14 20:00:33+00:00', 1, 'c4bfkfoac');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, -2147483648, 2115816682, '7z2zezjo7wg', '2023-03-07 00:15:11+00:00', 1, '5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483634, -2147483648, -915385605, 'm', '2022-04-20 03:52:20+00:00', 1, '0oztdgj5i3lq');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, -2147483648, 1339733032, 'im5k', '2024-03-11 05:11:39+00:00', 1, 'qs27p2r94');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483632, -2147483648, -244633520, 'ajjl', '2020-02-06 22:46:22+00:00', 1, 'okv8uttm');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483631, -2147483648, -229022515, '57', '2024-07-14 22:10:32+00:00', 1, 'fvy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483630, -2147483648, 458835042, '8y', '2022-11-08 19:06:29+00:00', 1, 'v42');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483629, -2147483648, 79330142, '58b4pm', '2020-01-08 04:07:26+00:00', 1, 'us3auvmkrpdj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483628, -2147483648, -663234145, 'h', '2021-10-23 07:09:38+00:00', 1, 'mo705a9n0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483627, -2147483648, -582376271, 'fwsz', '2020-06-20 19:03:43+00:00', 1, '2zob');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483626, -2147483648, -397848196, '0k32odwcl5a', '2025-04-19 10:34:51+00:00', 1, 'msorlwyngc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483625, -2147483648, 681061317, 'iz', '2020-11-27 04:53:28+00:00', 1, 'k1yoeyo6l0h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483624, -2147483648, 1435223075, 'qyxuzk', '2020-03-04 20:06:24+00:00', 1, '521gwnlas6e');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483623, -2147483648, 1048147204, 'eowi', '2021-01-23 12:42:14+00:00', 1, 'z5nxih6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483622, -2147483648, -1034034171, 'lyotow', '2024-08-29 05:28:03+00:00', 1, 'aawg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483621, -2147483648, 966412849, '0', '2022-07-26 21:24:54+00:00', 1, 'i');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483620, -2147483648, -1897615568, '9tajz9td', '2024-07-21 17:54:15+00:00', 1, '5wcg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483619, -2147483648, -1275298282, '3', '2025-03-26 09:37:26+00:00', 1, 'tdu6bd0w96');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483618, -2147483648, 740386991, 'xw1rxe9', '2023-04-03 03:00:30+00:00', 1, 'k7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483617, -2147483648, 312804300, '62nh55y3dohv', '2022-09-26 18:21:28+00:00', 1, '6dza35r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483616, -2147483648, -1580984044, '8ri2hy0', '2025-01-05 20:14:57+00:00', 1, 'ftp6ewtqx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483615, -2147483648, 1664452437, 'jabymzn2mfx7', '2020-12-18 19:09:13+00:00', 1, '3p6sto1c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483614, -2147483648, 1728926031, 'knzys7dy', '2025-09-13 12:59:23+00:00', 1, 'd1jmgja');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483613, -2147483648, 973811121, 'ta8y3a17v4', '2025-06-20 19:52:40+00:00', 1, 'gmayq3q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483612, -2147483648, -1750715330, 'ccukjq1qui', '2021-05-13 00:35:54+00:00', 0, 'yhb08hl');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483611, -2147483648, 1909521477, 'qomi', '2023-06-06 02:04:32+00:00', 0, 'tvb6m4iz78');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483610, -2147483648, 1728201214, 'ud8', '2020-09-11 22:26:51+00:00', 0, 'tb8r9114qbre');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483609, -2147483648, -1537647691, 'uuwsj8kjh8', '2024-02-22 11:09:09+00:00', 0, 'pxlvri');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483608, -2147483648, 2042428747, 'z0kaq', '2022-08-19 06:04:31+00:00', 0, 'ncgc8s3b7v');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483607, -2147483648, -622923312, 'dbdh', '2022-07-31 04:43:08+00:00', 0, 'j47nxar50');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483606, -2147483648, -1515201134, 'n', '2023-05-02 01:41:48+00:00', 0, 'dpunmw');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483605, -2147483648, -642512512, 'rlawk', '2023-07-20 15:35:59+00:00', 0, '14r5dqtsmg97');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483604, -2147483648, -1019350771, 'o20pj6dd', '2021-07-04 20:45:51+00:00', 0, 'su6iphd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__8ebcba',)
*/

-- Prediction Query
SELECT badges.name FROM badges INNER JOIN (SELECT userid, COUNT(id) AS comment_count FROM comments GROUP BY userid ORDER BY comment_count DESC, userid NULLS LAST LIMIT 1) AS most_commenting_users ON badges.userid = most_commenting_users.userid;

/*
Prediction Result:
('t1__8ebcba',)
('t1__ed63ee',)
('t1__ed63ee',)
('t1__ed63ee',)
('t1__ed63ee',)
('t1__8ebcba',)
('t1__8ebcba',)
*/