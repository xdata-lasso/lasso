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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 382831862, '2020-07-08 07:50:44+00:00', '7z2zezj', '2021-12-22 04:28:19+00:00', 'wgxd5ysxc', 'r0oz', 'dgj5i', -176606723, -15162884, 1339733032, -1556979799, -55240145, '8qs27p2r');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 't1__b02fad', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 't1__b02fad', '2021-07-01 18:29:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 't1__b02fad', '2020-08-18 16:30:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 3, '!', '2021-10-07 12:15:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 1, 'C', '2023-11-01 15:52:25+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 3, '1', '2025-07-17 09:46:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 'c', '2021-01-12 13:18:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 3, '.', '2023-01-06 16:23:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, ':', '2025-07-13 05:36:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 3, '!', '2020-02-08 07:26:28+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 0, 'C', '2024-09-21 04:14:02+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483637, 3, '$', '2023-11-09 04:27:38+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483636, 0, 'p', '2020-02-11 09:48:43+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483635, 1, '!', '2025-01-14 14:36:19+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483634, 0, '@', '2024-12-17 16:33:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483633, 1, '!', '2021-08-11 14:42:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483632, 0, '"', '2021-03-09 19:03:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483631, 1, '$', '2025-02-06 17:39:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483630, 0, 'A', '2020-04-13 12:25:56+00:00');

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

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, -2147483648, -1738458256, 'jd', '2024-07-26 15:42:53+00:00', 1, 'yzt1afgogrit');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, -2147483648, -1478134144, 'y', '2023-01-25 15:19:02+00:00', 1, '1q43');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, -2147483648, 1923912467, 'jh3den8c68', '2023-02-21 21:59:10+00:00', 1, 'vacx7afu5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, -2147483648, 765724008, '7pzo72ctd', '2020-04-27 21:49:53+00:00', 1, 'mfg62');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, -2147483648, -698610044, 'q8qdjpe1io22', '2024-05-29 05:19:47+00:00', 1, '507cvtjpt');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483634, -2147483648, 1467355421, 'ou5z', '2021-02-17 19:49:53+00:00', 1, '6c4bfkfo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, -2147483648, -1719383707, '2m', '2021-10-18 07:51:02+00:00', 0, 'ajjla3okv8u');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483632, -2147483648, 362376128, 'mu2ne578lf', '2022-11-17 03:25:43+00:00', 0, 'yz7zzbe8yvk');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483631, -2147483648, 318331233, 'q7sx58b4', '2025-08-08 12:00:20+00:00', 0, 'maus');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483630, -2147483648, -699574669, 'rpd', '2021-03-23 21:08:32+00:00', 0, 'wzw5chn9mo70');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483629, -2147483648, 238533676, 'jxfofws', '2023-05-19 01:23:31+00:00', 0, 'o');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483628, -2147483648, -1197954156, '0', '2022-03-19 07:41:34+00:00', 0, '0k32odwcl5a');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483627, -2147483648, -1177989415, 'wyn', '2025-04-18 20:42:36+00:00', 1, 'c1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483626, -2147483648, 453340472, '9erhizgk1yoe', '2023-04-04 11:32:59+00:00', 1, 'o6l0hdt6fu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483625, -2147483648, 1294064538, 'uzkb52', '2023-09-14 18:35:43+00:00', 1, 'wn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483624, -2147483648, 1718516876, '6elbo', '2020-08-28 14:27:04+00:00', 1, 'wii1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483623, -2147483648, -564679000, '66', '2023-10-03 17:29:40+00:00', 1, '2xlyo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483622, -2147483648, 1083479253, '9oaawg', '2024-09-22 16:04:20+00:00', 1, 'aqb0tbind');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483621, -2147483648, 2085299664, 'j', '2023-05-09 01:10:53+00:00', 1, 'td8n5wcgu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483620, -2147483648, 989306270, 'tdu6bd0w96', '2023-07-02 17:49:19+00:00', 1, 'vzxw1rxe');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483619, -2147483648, -1046720861, '162nh55y3d', '2025-02-15 07:25:43+00:00', 1, 'hvu0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483618, -2147483648, -438741674, '5rmkio18', '2022-05-12 04:24:33+00:00', 1, 'i2hy08ftp6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483617, -2147483648, -646944990, 'xxnja', '2020-02-18 15:32:47+00:00', 1, 'mzn2mfx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483616, -2147483648, -156175571, '6sto', '2023-09-09 05:17:59+00:00', 1, 'j');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483615, -2147483648, -1643065004, 'nzy', '2022-06-21 06:39:29+00:00', 1, 'dyyd1jmgj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483614, -2147483648, -2008781089, 'qta8y3a17', '2024-12-03 19:29:06+00:00', 1, '4ygmay');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483613, -2147483648, 1509621238, 'dpuap', '2024-09-13 03:07:40+00:00', 1, 'rntdqrhm5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483612, -2147483648, -1369148652, '7', '2025-06-14 15:18:28+00:00', 1, 'dn2np490xdms');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483611, -2147483648, -827883679, 'lc', '2022-09-26 08:18:54+00:00', 1, 'qb9i9f2ccu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483610, -2147483648, -1541581575, '1quik1yhb08h', '2021-07-19 11:24:33+00:00', 1, 't1pqo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483609, -2147483648, -696672546, 'm4iz78aqq', '2021-07-16 00:08:56+00:00', 1, 'd8ftb8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483608, -2147483648, -312228770, 'qbre6bje', '2024-12-21 23:01:28+00:00', 1, 'uwsj8k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483607, -2147483648, -55270062, 'xlvr', '2021-02-03 14:27:41+00:00', 1, 'surz0kaqtncg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483606, -2147483648, 438933248, '88kwdmdbdht6', '2024-11-15 10:34:01+00:00', 1, '47n');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483605, -2147483648, -982188592, 'hsjhanz', '2023-02-27 07:54:12+00:00', 1, 'p');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483604, -2147483648, 2014610660, 'wfwx', '2022-03-12 01:37:04+00:00', 1, 'lawk0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__b02fad',)
*/

-- Prediction Query
SELECT b.Name FROM badges AS b JOIN (SELECT UserId FROM comments GROUP BY UserId ORDER BY COUNT(Id) DESC, UserId NULLS LAST LIMIT 1) AS c ON b.UserId = c.UserId;

/*
Prediction Result:
('t1__b02fad',)
('C',)
('c',)
(':',)
('!',)
('!',)
('$',)
('t1__b02fad',)
('t1__b02fad',)
*/