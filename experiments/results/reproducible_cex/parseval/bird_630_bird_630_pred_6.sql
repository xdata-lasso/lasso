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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 't3__c342d5', 1151980946, 1620389964, 546571701, 1, '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00', 947159877, '2022-07-16 22:41:51+00:00', 'c4ecigce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1178000634, 1836127587, '2023-06-28 05:47:44+00:00', 836513442, 176555546, 'gd', -2147483647, '2023-11-06 04:09:03+00:00', 'vy9uxj4', 't3__c342d5', -1612443122, -2050247126, -736979194, -2147483647, '2022-01-26 11:13:48+00:00', '2020-12-31 11:15:26+00:00', -261132974, '2021-09-30 11:37:26+00:00', 'q', 'nqcx5h');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1722106924, -2072838897, '2021-05-31 16:00:51+00:00', 1201273976, 1923659053, 'c', 1, '2020-07-08 07:50:44+00:00', '7z2zezj', 't3__c342d5', 1448731351, -604098478, 1248858185, 4, '2020-06-06 19:46:47+00:00', '2024-02-20 16:52:17+00:00', -526612570, '2023-03-04 02:34:12+00:00', 'm', '0oztd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 875300074, -1609653472, '2021-06-20 20:52:42+00:00', -15162884, 1339733032, 'im5k', -2147483647, '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, 1, '2021-04-29 06:47:06+00:00', '2021-07-29 14:03:28+00:00', -2096405521, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1437333179, -921145356, '2023-01-16 20:10:41+00:00', -1022641847, -1726781632, '9n8', 4, '2020-04-30 23:22:06+00:00', 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', 'dpos');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 5, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 4, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 5, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 222415430, 556727997, '2024-02-28 14:45:41+00:00', 1836127587, -1529584866, 'd2', 1, '2023-09-10 09:37:01+00:00', 'y9uxj4', 'wb', -1929953647, 1581736075, -261132974, 6, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483647, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 3, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 600440952, 1568069663, '2020-09-12 13:47:57+00:00', -1717646459, -1696173285, 'tsj', 2, '2023-11-11 06:21:01+00:00', 'y', 'p1q430', 1923912467, 518609210, 1948383687, 6, '2020-06-27 17:29:33+00:00', '2020-08-20 06:07:09+00:00', 195720193, '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 6, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 4, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1999335832, -526612570, '2023-03-04 02:34:12+00:00', -2005628382, 1721638020, '0oztdgj5i3lq', 1, '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94', -1719383707, 1273687251, 333302050, 5, '2021-08-24 18:58:08+00:00', '2021-10-18 07:51:02+00:00', -2136247961, '2021-04-29 06:47:06+00:00', 'a3o', 'v8u');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 2, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 2, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (13, 292557306, 709097796, '2022-04-21 05:35:41+00:00', -1352968577, -519515742, 'gc1dj9erhi', 9, '2023-06-08 15:48:15+00:00', 'k1', 'yoeyo6l0hdt6', 1435223075, 1617348603, -477129795, 9, '2025-10-17 20:09:18+00:00', '2022-10-03 01:08:43+00:00', 1755752040, '2021-06-11 00:32:43+00:00', '5', '1gwnlas6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (14, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483647, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 9, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (15, 312804300, -246257698, '2020-12-13 20:46:34+00:00', 956819642, 774922170, '3dohvu0', 2, '2024-04-24 18:29:26+00:00', 'z', '3', 1595632888, 2072023304, 789756515, 8, '2021-12-14 20:39:54+00:00', '2023-08-06 06:41:23+00:00', 769234989, '2025-01-05 20:14:57+00:00', 'ftp6ewtqx', 'njabym');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (16, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', 9, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, 6, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'John Salvatier', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1666765085, '2025-11-19 11:50:18+00:00', 'John Salvatier', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -541746689, '2024-12-20 11:42:02+00:00', 'John Salvatier', '2024-06-05 23:32:14+00:00', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1538707438, '2023-12-06 02:24:58+00:00', 'e', '2021-11-04 04:05:36+00:00', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'John Salvatier', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1666765085, '2025-11-19 11:50:18+00:00', 'John Salvatier', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1520489792, '2022-12-13 04:17:12+00:00', 'John Salvatier', '2022-12-26 19:34:44+00:00', 'q7x', '7', '2fxa7ryfdrz', 61479715, -1496556994, -2115841792, 1746373317, 1360271423, 'ogrgjd8y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1582582341, '2025-02-24 17:48:00+00:00', 'John Salvatier', '2022-07-29 12:44:17+00:00', '6b', 'ou5z', '36c', 1722106924, -2072838897, -1173368267, 382831862, -406331049, 'ezjo7wg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -1278087274, '2024-10-18 07:07:54+00:00', 'John Salvatier', '2022-04-29 05:47:08+00:00', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 1719800120, -210159774, 270415200, -2071531094, -397848196, '0k32odwcl5a');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1044710644, '2022-03-05 18:43:06+00:00', 'John Salvatier', '2020-03-03 02:26:18+00:00', 'tbindz3', 'tajz9td8n', '5wcgumbc3td', 1964331395, -1943814113, 1514371324, -379749892, -541917667, 'rxe9yfk');

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

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, -747753377, 5, 'nrqrofqy', '2022-01-22 16:14:13+00:00', 5, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, -841004020, 7, 'dz79fjg', '2022-03-23 04:34:16+00:00', 6, 'n2f3dqv0g', 'cb98ozk3zbil', 'yrkn6vck6ah0');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 87529806, 9, 'ctdctmfg62g0', '2022-11-14 02:03:20+00:00', 7, 'q8qdjpe1', 'o22', '8507cvtjp');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, -1311735207, 11, 'ne578lfv', '2025-08-19 19:51:44+00:00', 8, 'z7zzbe8', 'yvkv42q7sx58', 'b4pmaus3auv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, 1468640756, 13, 'boeowii1z5nx', '2021-03-06 10:06:33+00:00', 9, '66', 'q2xlyoto', '9oaawg');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, 1528227252, 15, 'fx7h', '2023-12-11 11:19:14+00:00', 10, 'p6sto1cj', 'sh5knzys7', 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'John Salvatier';

/*
Gold Result:
('t3__c342d5',)
('t3__c342d5',)
('t3__c342d5',)
('th',)
('th',)
('th',)
('t3__c342d5',)
('t3__c342d5',)
('t3__c342d5',)
('w6kl',)
('wb',)
('p1q430',)
('qs27p2r94',)
('yoeyo6l0hdt6',)
('3',)
*/

-- Prediction Query
SELECT T1.Tags FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'John Salvatier';

/*
Prediction Result:
('t3__c342d5',)
('t3__c342d5',)
('t3__c342d5',)
('th',)
('w6kl',)
('wb',)
(None,)
(None,)
('qs27p2r94',)
('yoeyo6l0hdt6',)
(None,)
(None,)
*/