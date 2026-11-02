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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 't3__131dc1', 1151980946, 1620389964, 546571701, 1, '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00', 947159877, '2022-07-16 22:41:51+00:00', 'c4ecigce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1178000634, 1836127587, '2023-06-28 05:47:44+00:00', 836513442, 176555546, 'gd', -2147483647, '2023-11-06 04:09:03+00:00', 'vy9uxj4', 't3__131dc1', -1612443122, -2050247126, -736979194, -2147483647, '2022-01-26 11:13:48+00:00', '2020-12-31 11:15:26+00:00', -261132974, '2021-09-30 11:37:26+00:00', 'q', 'nqcx5h');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1722106924, -2072838897, '2021-05-31 16:00:51+00:00', 1201273976, 1923659053, 'c', 1, '2020-07-08 07:50:44+00:00', '7z2zezj', 't3__131dc1', 1448731351, -604098478, 1248858185, 4, '2020-06-06 19:46:47+00:00', '2024-02-20 16:52:17+00:00', -526612570, '2023-03-04 02:34:12+00:00', 'm', '0oztd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 875300074, -1609653472, '2021-06-20 20:52:42+00:00', -15162884, 1339733032, 'im5k', -2147483647, '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, 1, '2021-04-29 06:47:06+00:00', '2021-07-29 14:03:28+00:00', -2096405521, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1437333179, -921145356, '2023-01-16 20:10:41+00:00', -1022641847, -1726781632, '9n8', 4, '2020-04-30 23:22:06+00:00', 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', 'dpos');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 1, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 5, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'John Salvatier', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1666765085, '2025-11-19 11:50:18+00:00', 'John Salvatier', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -541746689, '2024-12-20 11:42:02+00:00', 'John Salvatier', '2024-06-05 23:32:14+00:00', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1538707438, '2023-12-06 02:24:58+00:00', 'e', '2021-11-04 04:05:36+00:00', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'John Salvatier', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -1245312912, 1, 'rjtu', '2023-07-15 22:31:56+00:00', 1, 'z', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 172461907, 1, 'k3zbily', '2022-05-18 00:14:53+00:00', 1, 'kn6vck6ah0f8', 'sww', 'q7x');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, -1180042408, 1, '78507cvt', '2021-03-27 11:42:11+00:00', 4, 'ttg6', 'n', 'u5zi');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -1817527403, 4, '78lfvyz7zz', '2025-05-30 03:33:11+00:00', 1, 'be8yvkv42q', '7sx58b4pma', 'us3auvmkrpdj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, 989018473, 1, 'chn9mo70', '2024-02-20 06:09:53+00:00', 4, 'a9n0jxfofws', 'do2zobb', 'q0k32od');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, 2061558815, 4, '5amsorlwyngc', '2023-08-12 12:46:14+00:00', 1, 'j', '9erhizgk1yoe', 'o6l0hdt');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, -477129795, 1, 'uzkb521gwnl', '2020-01-06 01:47:51+00:00', 4, '6elbo', 'ow', 'i1z');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 548968280, 4, 'h66', '2023-10-03 17:29:40+00:00', 1, '2xlyo', 'tow9oaawg96a', 'qb0tbindz39t');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -841516418, 1, 'n5wcgumbc', '2025-11-17 06:38:18+00:00', 1, '3tdu6bd0w9', '03vzxw1rx', '9y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -1046720861, 1, '162nh55y3d', '2025-02-15 07:25:43+00:00', 1, 'hvu0', 'dza35rmki', '18ri');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 2013745856, 1, 'b', '2023-03-16 17:59:19+00:00', 1, 'mzn2mfx7h3', 'p6sto1cj', 'sh5knzys7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1576219117, 2, '5u', '2021-11-09 05:42:50+00:00', 2, '6klfa9', '00t5c4e', 'cigce376nium');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -1377057208, 5, 'ilbnp', '2022-04-12 01:47:28+00:00', 5, 'dpos', 'ie5', 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'John Salvatier';

/*
Gold Result:
('t3__131dc1',)
('t3__131dc1',)
('t3__131dc1',)
('th',)
('th',)
('th',)
('t3__131dc1',)
('t3__131dc1',)
('t3__131dc1',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "tags"."tagname" FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" INNER JOIN "tags" ON "posts"."tags" LIKE '%' || "tags"."tagname" || '%' WHERE "users"."displayname" = 'John Salvatier';

/*
Prediction Result:
*/