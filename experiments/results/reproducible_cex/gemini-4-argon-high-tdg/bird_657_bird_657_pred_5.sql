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
-- DATASET 2
INSERT INTO users (Id, DisplayName, WebsiteUrl) VALUES (1, 'User_MinBounty_MinId', 'https://u1.example.com');
INSERT INTO users (Id, DisplayName, WebsiteUrl) VALUES (2, 'User_MaxBounty_LargerId', 'https://u2.example.com');
INSERT INTO users (Id, DisplayName, WebsiteUrl) VALUES (3, 'User_MaxBounty_SmallerId_Winner', 'https://u3.example.com');
INSERT INTO users (Id, DisplayName, WebsiteUrl) VALUES (4, 'User_MinBounty_MaxId', 'https://u4.example.com');
INSERT INTO posts (Id, OwnerUserId, Title) VALUES (100, 1, 'First Post');
INSERT INTO posts (Id, OwnerUserId, Title) VALUES (200, 2, 'Second Post');
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount) VALUES (1, 100, 8, '2023-02-01', 1, 100);
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount) VALUES (5, 200, 8, '2023-05-01', 3, 250);
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount) VALUES (8, 100, 8, '2023-01-01', 2, 250);
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount) VALUES (9, 200, 8, '2023-06-01', 4, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName, WebsiteUrl FROM users WHERE Id = (SELECT UserId FROM votes WHERE VoteTypeId = 8 ORDER BY BountyAmount DESC, votes.id NULLS LAST LIMIT 1);

/*
Gold Result:
('User_MaxBounty_SmallerId_Winner', 'https://u3.example.com')
*/

-- Prediction Query
SELECT T1.DisplayName, T1.WebsiteUrl FROM users AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.UserId WHERE T2.VoteTypeId = 8 ORDER BY T2.BountyAmount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('User_MaxBounty_LargerId', 'https://u2.example.com')
*/