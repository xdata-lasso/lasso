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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -688509700, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -211209314, '2023-11-18 03:19:57+00:00', 'dqv0gcb98ozk', '2023-12-12 02:47:46+00:00', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1732258051, '2024-05-22 05:48:31+00:00', 'f', '2022-09-01 11:41:59+00:00', 'w1of77pz', '72ct', 'c', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 't1__678463', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 't1__678463', '2021-07-01 18:29:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 't1__678463', '2020-08-18 16:30:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, '@', '2021-10-07 12:15:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 5, 't1__4ca15d', '2025-07-17 09:46:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 4, 'A', '2023-02-21 21:59:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 5, 't1__4ca15d', '2024-08-13 21:17:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 4, '!', '2021-06-20 20:52:42+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 5, 't1__4ca15d', '2022-03-31 13:29:22+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 4, '"', '2023-05-05 20:15:58+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 5, 't1__4ca15d', '2024-06-27 07:12:45+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 0, 'njabym', '2023-05-26 17:37:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 0, 'n2mfx7h33p', '2024-05-18 01:33:40+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 0, 'el', '2020-05-04 22:25:03+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 5, 'qb9i9f2ccu', '2021-06-14 07:47:39+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 1, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 1, 'uhv', '2020-06-20 11:35:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, 1, 'wbbp6luhvdlt', '2022-08-02 13:58:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (11, 1, 'nium52zbu', '2021-11-30 23:39:10+00:00');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, -1585009206, '52zb', '2025-10-02 08:51:14+00:00', 1, 'o4nrqr');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, -2147483648, 775304493, 'qyp5s5bbp0', '2025-09-22 03:26:15+00:00', 1, 'eutliqa1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, -2147483648, 274769912, 'oo3o9', '2020-12-13 17:48:30+00:00', 1, '72k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -2147483648, 1775126557, 'ji7zwau2', '2025-11-10 22:24:59+00:00', 1, 'w');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, -2147483648, -953437896, '3pyu78d', '2024-09-04 21:17:21+00:00', 1, 'rljsl0b4y');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -2147483648, -1025564911, 'rkf9vqx5', '2024-08-09 01:13:45+00:00', 1, 'pz0f8jegd21');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, -2147483648, 1583472758, 'rg', '2021-04-29 02:40:32+00:00', 1, '8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, -2147483648, 1129658414, '1afgo', '2020-11-22 11:14:57+00:00', 1, 'itsj3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, -2147483648, 2111987706, 'p1q430', '2023-08-17 20:15:35+00:00', 1, 'jh3den8c68');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, -2147483648, -1180042408, '78507cvt', '2021-03-27 11:42:11+00:00', 0, 'ttg6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, -2147483648, -1171104889, '5zi36c4bfkfo', '2020-02-08 07:26:28+00:00', 0, 'cd07z2zezjo7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, -2147483648, -542502665, 'ysxcmr0o', '2025-12-11 00:03:18+00:00', 0, 'tdgj5i3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, -2147483648, -1212676731, 'm5k', '2024-03-11 05:11:39+00:00', 1, 'qs27p2r94');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, -2147483648, -244633520, 'ajjl', '2020-02-06 22:46:22+00:00', 1, 'okv8uttm');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483634, -2147483648, -229022515, '57', '2024-07-14 22:10:32+00:00', 1, 'fvy');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, -2147483648, 458835042, '8y', '2022-11-08 19:06:29+00:00', 1, 'v42');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483632, -2147483648, 79330142, '58b4pm', '2020-01-08 04:07:26+00:00', 1, 'us3auvmkrpdj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483631, -2147483648, -663234145, 'h', '2021-10-23 07:09:38+00:00', 1, 'mo705a9n0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483630, -2147483648, -582376271, 'fwsz', '2020-06-20 19:03:43+00:00', 1, '2zob');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483629, -2147483648, -397848196, '0k32odwcl5a', '2025-04-19 10:34:51+00:00', 1, 'msorlwyngc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483628, -2147483648, 681061317, 'iz', '2020-11-27 04:53:28+00:00', 1, 'k1yoeyo6l0h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483627, -2147483648, 1435223075, 'qyxuzk', '2020-03-04 20:06:24+00:00', 1, '521gwnlas6e');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483626, -2147483648, 1048147204, 'eowi', '2021-01-23 12:42:14+00:00', 1, 'z5nxih6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483625, -2147483648, -1034034171, 'lyotow', '2024-08-29 05:28:03+00:00', 1, 'aawg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483624, -2147483648, 966412849, '0', '2022-07-26 21:24:54+00:00', 1, 'i');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483623, -2147483648, -1897615568, '9tajz9td', '2024-07-21 17:54:15+00:00', 1, '5wcg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483622, -2147483648, -1275298282, '3', '2025-03-26 09:37:26+00:00', 1, 'tdu6bd0w96');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483621, -2147483648, 740386991, 'xw1rxe9', '2023-04-03 03:00:30+00:00', 1, 'k7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483620, -2147483648, 312804300, '62nh55y3dohv', '2022-09-26 18:21:28+00:00', 1, '6dza35r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483619, -2147483648, -1580984044, '8ri2hy0', '2025-01-05 20:14:57+00:00', 1, 'ftp6ewtqx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, -2147483648, -843082635, 'cj8sh5k', '2021-10-06 21:42:28+00:00', 0, 'zys7dyyd1jmg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, -2147483648, -2108844113, '8q', '2024-10-22 04:53:36+00:00', 0, 'a8y3a');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, -2147483648, 339193890, 'ygmayq3q', '2024-12-02 03:34:47+00:00', 0, 'dpuap96rntdq');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, -2147483648, -1670945624, 'wlic7dn2', '2021-10-14 23:04:20+00:00', 0, 'p490xdmsqt');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483614, -2147483648, -1980249628, 'gu7v', '2020-09-25 19:25:33+00:00', 4, '4h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, -2147483648, -252690330, 'uzhs', '2025-08-22 00:34:24+00:00', 1, 'wbbp6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483612, -2147483648, -845863578, 'lbn', '2022-01-18 15:57:55+00:00', 5, 'mdpos');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, -1602639011, 'unw6klfa', '2024-12-31 04:19:17+00:00', 1, '000t5c4ec');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483610, -2147483648, -59984348, 'wqcgsk', '2024-11-14 12:35:58+00:00', 4, 'n8c4pgu7v');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, 1744686505, 'hria2ypu', '2023-05-25 17:04:36+00:00', 1, 'sr');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483608, -2147483648, 429706943, 'rmdp', '2021-12-08 15:32:00+00:00', 4, 'siie5unw6k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, -2147483648, 1620389964, '00t5c4ecigc', '2025-04-19 21:11:20+00:00', 1, '37');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__678463',)
*/

-- Prediction Query
SELECT "users"."displayname", "badges"."name" FROM "users" INNER JOIN "comments" ON "users"."id" = "comments"."userid" INNER JOIN "badges" ON "users"."id" = "badges"."userid" GROUP BY "users"."id" ORDER BY COUNT("comments"."id") DESC, "users"."displayname" NULLS LAST, "badges"."name" NULLS LAST LIMIT 1;

/*
Prediction Result:
('wwqcg', '5k5swwqcgs')
*/