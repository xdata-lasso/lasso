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
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (101, NULL, NULL, 151, 101, '2023-01-01 00:00:00.000000', 149, 149, 'default2', '2023-01-01 00:00:00.000000', 'default2', NULL, 100, NULL, 149, '2023-01-01 00:00:00.000000', NULL, 99, '2023-01-01 00:00:00.000000', NULL, 'default2'), (150, NULL, NULL, 149, 151, NULL, 100, 99, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 149, 0, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'default1', 'default2'), (99, NULL, NULL, 100, 2, '2023-01-01 00:00:00.000000', 149, 101, 'default1', NULL, 'default2', 'default1', 99, 150, 2, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 0, NULL, 'default1', NULL), (100, NULL, NULL, 0, 99, NULL, 100, 99, NULL, NULL, NULL, 'default1', 101, 1, NULL, '2023-01-01 00:00:00.000000', NULL, 150, '2023-01-01 00:00:00.000000', 'default1', 'default2'), (1, NULL, NULL, NULL, 2, '2023-01-01 01:00:00.000000', 101, NULL, NULL, NULL, 'default1', 'default1', 101, 1, 99, '2023-01-01 01:00:00.000000', NULL, 100, '2023-01-01 00:00:00.000000', NULL, NULL), (149, NULL, NULL, 100, NULL, '2023-01-01 00:00:00.000000', 150, 150, 'default1', NULL, 'default2', 'default1', 99, 149, 2, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 149, NULL, NULL, 'default2'), (151, NULL, NULL, 149, 151, '2023-01-01 01:00:00.000000', 150, 2, 'default2', '2023-01-01 00:00:00.000000', 'default2', NULL, 0, 99, 99, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 2, '2023-01-01 00:00:00.000000', NULL, 'default1'), (2, NULL, NULL, 0, 2, NULL, 100, 101, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'default1', 99, 0, 100, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', NULL), (0, NULL, NULL, 101, 99, NULL, 150, 1, 'default1', NULL, 'default1', 'default2', 151, 1, 100, '2023-01-01 00:00:00.000000', NULL, 100, '2023-01-01 01:00:00.000000', NULL, NULL), (3, NULL, NULL, 151, 1, NULL, 100, 0, 'default1', NULL, NULL, 'default1', 150, 151, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 99, NULL, 'default2', 'default1'), (4, NULL, NULL, 2, 101, '2023-01-01 01:00:00.000000', 101, 101, NULL, '2023-01-01 00:00:00.000000', NULL, 'default2', 2, 0, 1, NULL, '2023-01-01 01:00:00.000000', 101, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (5, NULL, NULL, 0, 100, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', NULL, 'default1', 'default1', 0, 101, 1, NULL, NULL, 149, NULL, 'default2', NULL), (6, NULL, NULL, 100, 151, NULL, NULL, 2, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 2, 149, 100, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 99, '2023-01-01 00:00:00.000000', 'default2', 'default1');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (2, 151, NULL, 1, 'default1', NULL, NULL), (149, 100, NULL, 100, 'default1', NULL, 'default2'), (100, 151, NULL, 2, 'default1', '2023-01-01 00:00:00.000000', NULL), (0, 150, NULL, 100, NULL, '2023-01-01 00:00:00.000000', 'default2'), (99, 100, NULL, 149, 'default2', NULL, NULL), (1, 99, NULL, 100, 'default1', '2023-01-01 00:00:00.000000', 'default2'), (151, 6, NULL, 151, NULL, '2023-01-01 01:00:00.000000', 'default1'), (101, 4, NULL, 99, 'default2', NULL, 'default1'), (150, 2, NULL, 100, 'default2', '2023-01-01 00:00:00.000000', NULL), (3, 3, NULL, 2, NULL, '2023-01-01 00:00:00.000000', NULL), (4, 149, NULL, 151, 'default1', '2023-01-01 00:00:00.000000', 'default1'), (5, 6, NULL, 100, NULL, '2023-01-01 00:00:00.000000', NULL), (6, 3, NULL, 149, 'default2', '2023-01-01 00:00:00.000000', 'default1'), (7, 2, NULL, 151, 'default2', '2023-01-01 00:00:00.000000', 'default1'), (8, 101, NULL, 1, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Text FROM comments WHERE PostId IN (SELECT Id FROM posts WHERE ViewCount BETWEEN 100 AND 150) ORDER BY Score DESC, comments.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT c.Text FROM posts AS p INNER JOIN comments AS c ON p.Id = c.PostId WHERE p.ViewCount BETWEEN 100 AND 150 ORDER BY c.Score DESC, p.id NULLS LAST, c.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/