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
-- DATASET 1
INSERT INTO users (Id, Reputation, DisplayName) VALUES (1, 100, 'Alice');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, CommunityOwnedDate, ParentId, ClosedDate, OwnerDisplayName, LastEditorDisplayName)
VALUES (1, 1, 2, '2023-01-01 00:00:00', 10, 20, 'Clustering 1D data', 1, '2023-01-02 00:00:00', 'Clustering 1D data', '<clustering>', 3, 5, 7, 1, '2023-01-01 12:00:00', '2023-01-01 12:00:00', 99, '2023-01-03 00:00:00', 'Alice', 'Alice');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, Body, Title, Tags, AnswerCount, CommentCount, FavoriteCount)
VALUES (2, 2, 100, 200, 'Clustering 1D data', 'clustering 1d data', 'Clustering 1D data', 30, 50, 70);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, Body, Title, Tags, AnswerCount, CommentCount, FavoriteCount)
VALUES (3, 1, 1000, 2000, 'How to cluster?', 'Clustering 1D data ', '<data>', 300, 500, 700);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, Body, Title, Tags, AnswerCount, CommentCount, FavoriteCount)
VALUES (4, 1, 10000, 20000, 'Other topic', NULL, '<other>', 3000, 5000, 7000);
INSERT INTO comments (Id, PostId, Score, Text, UserId) VALUES (1, 1, 1, 'Nice post', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CommentCount, AnswerCount FROM posts WHERE Title = 'Clustering 1D data';

/*
Gold Result:
(5, 3)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM comments WHERE PostId = (SELECT Id FROM posts WHERE Title = 'Clustering 1D data')) AS CommentCount, (SELECT COUNT(*) FROM posts WHERE PostTypeId = 2 AND ParentId = (SELECT Id FROM posts WHERE Title = 'Clustering 1D data')) AS AnswerCount;

/*
Prediction Result:
(1, 0)
*/