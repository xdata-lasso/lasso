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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 0, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', 'default2', 'default2', NULL, 0, 0, NULL, NULL, 'default2'), (1, 1, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', NULL, 'default1', 2, 2, 2, 1, 1, 'default1'), (2, 1, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'Harvey Motulsky', 'default2', 0, 1, 2, 2, 0, 'default1'), (3, 2, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'Harvey Motulsky', NULL, NULL, 1, NULL, 2, NULL, 'Harvey Motulsky'), (4, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', 'Harvey Motulsky', 'default2', 'Harvey Motulsky', NULL, 0, NULL, 1, 1, 'default1'), (5, 1, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 0, 2, 2, 2, 2, NULL), (6, NULL, NULL, 'Harvey Motulsky', '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, 2, 1, 2, 0, 2, NULL), (7, 2, '2023-01-01 01:00:00.000000', 'Harvey Motulsky', NULL, 'default2', 'default2', 'default2', NULL, 0, 2, 0, 1, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 2, 1, 0, 2, NULL, 1, 0, 'default2', NULL, NULL, 'default2', 2, 1, 0, NULL, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 'default1'), (0, 3, 0, 2, 2, '2023-01-01 00:00:00.000000', 0, 1, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'default1', 0, NULL, 0, NULL, '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'Harvey Motulsky', 'Harvey Motulsky'), (2, 2, 3, NULL, 0, '2023-01-01 00:00:00.000000', 2, 2, 'default2', '2023-01-01 00:00:00.000000', NULL, 'Harvey Motulsky', 2, 0, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'Harvey Motulsky'), (3, 6, 3, NULL, 0, '2023-01-01 01:00:00.000000', 0, 0, NULL, NULL, 'default2', NULL, 0, 0, 1, NULL, '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'default1', 'Harvey Motulsky'), (4, 2, 6, 0, 1, NULL, 2, 0, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'default2', 0, NULL, 1, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2'), (5, 2, NULL, 2, 0, NULL, 2, 1, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 2, 1, 1, '2023-01-01 00:00:00.000000', NULL, 1, NULL, NULL, 'Harvey Motulsky'), (6, 4, 7, 2, 0, '2023-01-01 00:00:00.000000', 1, 1, NULL, '2023-01-01 00:00:00.000000', 'Harvey Motulsky', NULL, 2, NULL, 0, NULL, NULL, 1, NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Id, T2.Title FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T1.DisplayName = 'Harvey Motulsky' ORDER BY T2.ViewCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(6, 'Harvey Motulsky')
*/

-- Prediction Query
SELECT Id, Title FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Harvey Motulsky') ORDER BY ViewCount DESC, posts.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(4, 'default2')
*/