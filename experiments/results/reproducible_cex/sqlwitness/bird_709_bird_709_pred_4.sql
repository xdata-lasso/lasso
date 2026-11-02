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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 6, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default1', 0, 4, -1, -1, 4, 'default2'), (6, 5, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', NULL, 1, NULL, 4, 1, 4, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 1, 6, 6, 4, '2023-01-01 01:00:00.000000', -1, 4, 'default2', NULL, 'default1', 'default2', 6, 1, 0, '2023-01-01 00:00:00.000000', NULL, -1, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (6, 6, NULL, -1, 6, NULL, 6, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default2', 4, 6, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'default1', 'default2'), (5, 6, 6, 5, NULL, '2023-01-01 01:00:00.000000', NULL, 1, 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, -1, NULL, 5, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', 'default2');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (0, 6, NULL, 1, 'default1', NULL, 'default2'), (5, 5, NULL, 0, 'default1', NULL, 'default2'), (-1, 0, 1, -1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.ViewCount < 5 AND T2.Score = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.PostId) FROM comments AS c JOIN posts AS p ON c.PostId = p.Id WHERE c.Score = 0 AND p.ViewCount < 5;

/*
Prediction Result:
(1,)
*/