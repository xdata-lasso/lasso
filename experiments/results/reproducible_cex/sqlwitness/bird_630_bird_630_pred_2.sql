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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', '%', 'default1', 'default2', NULL, NULL, NULL, 0, NULL, 'John Salvatier'), (0, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', 'John Salvatier', '%', NULL, 0, NULL, NULL, NULL, 'default2'), (2, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'John Salvatier', '%', NULL, NULL, NULL, NULL, 0, 0, '%'), (3, 1, '2023-01-01 00:00:00.000000', 'John Salvatier', '2023-01-01 00:00:00.000000', 'John Salvatier', '%', NULL, 1, 1, 0, NULL, 1, '%'), (4, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default1', 0, 1, NULL, 0, 0, 'default2'), (5, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1', NULL, 0, 0, 1, NULL, NULL, 'default2'), (6, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', NULL, 'default1', NULL, 1, 0, NULL, 1, 'default1'), (7, NULL, '2023-01-01 00:00:00.000000', 'John Salvatier', '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 0, 1, 0, 0, NULL, 'John Salvatier'), (8, 0, '2023-01-01 01:00:00.000000', '%', '2023-01-01 00:00:00.000000', NULL, 'default1', '%', 1, 0, 0, 1, 1, 'John Salvatier');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 0, 7, 1, 0, '2023-01-01 01:00:00.000000', 1, 1, NULL, '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 0, 1, NULL, NULL, 1, NULL, 'default2', '%'), (0, NULL, 2, 1, 0, '2023-01-01 00:00:00.000000', 1, 0, 'default2', '2023-01-01 01:00:00.000000', 'default1', 'default2', 1, NULL, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, NULL, 'default2', NULL), (2, 2, 8, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 0, 'default2', NULL, 'default1', 'default1', NULL, 0, 1, '2023-01-01 01:00:00.000000', NULL, 0, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (3, 8, 2, 1, 1, NULL, NULL, 1, 'John Salvatier', NULL, 'John Salvatier', 'John Salvatier', 1, 1, 0, NULL, '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'default1', NULL), (4, 3, 2, 0, 0, '2023-01-01 00:00:00.000000', 0, NULL, 'John Salvatier', '2023-01-01 00:00:00.000000', 'John Salvatier', 'John Salvatier', NULL, 1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 1, NULL, NULL, 'John Salvatier'), (5, 4, 8, 0, 0, '2023-01-01 01:00:00.000000', 1, 0, '%', '2023-01-01 01:00:00.000000', 'default1', '%', 1, 0, 0, NULL, '2023-01-01 01:00:00.000000', 0, NULL, '%', NULL), (6, NULL, 2, 1, NULL, NULL, NULL, 1, 'default1', '2023-01-01 00:00:00.000000', '%', 'default1', 0, NULL, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'John Salvatier', NULL), (7, 1, 7, NULL, 0, '2023-01-01 00:00:00.000000', NULL, NULL, NULL, NULL, 'default1', 'default1', NULL, NULL, NULL, NULL, NULL, 0, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (8, 0, 2, 0, 0, '2023-01-01 01:00:00.000000', NULL, 0, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'John Salvatier', 1, 1, NULL, NULL, '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'default2', 'John Salvatier');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (0, 8, 'default2', NULL, NULL), (1, 0, 'default1', NULL, 1), (2, NULL, 'default1', NULL, NULL), (3, 1, 'John Salvatier', 0, 1), (4, 7, NULL, 1, 1), (5, 8, 'John Salvatier', 1, 1);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (1, NULL, NULL, 0, 'default1', '2023-01-01 00:00:00.000000', 'default1', '%', '%'), (0, 2, 0, 0, '%', '2023-01-01 01:00:00.000000', 'default2', 'default2', 'default1'), (2, 5, 7, NULL, 'default1', NULL, 'default2', '%', 'default2'), (3, 1, 5, 1, 'default2', '2023-01-01 01:00:00.000000', 'default1', '%', 'John Salvatier'), (4, 7, 7, 1, 'John Salvatier', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'John Salvatier'), (5, 1, 5, NULL, 'default2', NULL, NULL, 'John Salvatier', NULL), (6, 2, 2, NULL, 'default2', '2023-01-01 01:00:00.000000', 'John Salvatier', 'John Salvatier', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'John Salvatier';

/*
Gold Result:
('%',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT "tags"."tagname" FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" INNER JOIN "tags" ON "posts"."tags" LIKE '%' || "tags"."tagname" || '%' WHERE "users"."displayname" = 'John Salvatier';

/*
Prediction Result:
('default2',)
('default1',)
*/