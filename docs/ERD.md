# Entity Relationship Diagram (ERD)

## Entities and Relationships

### Users
- id (PK)
- email (UNIQUE)
- username (UNIQUE)
- password
- display_name
- bio
- profile_picture
- role (USER, ARTIST)
- created_at
- updated_at

**Relationships:**
- One-to-One with Artists (if role is ARTIST)
- One-to-Many with Playlists
- One-to-Many with Favorites
- One-to-Many with ListeningHistory

### Artists
- id (PK)
- user_id (FK to Users, UNIQUE)
- artist_name
- bio
- genre
- profile_picture
- banner_image
- instagram, twitter, youtube, spotify, website
- created_at
- updated_at

**Relationships:**
- One-to-One with Users
- One-to-Many with Songs
- One-to-Many with Albums

### Songs
- id (PK)
- title
- genre
- duration
- audio_file
- cover_image
- visibility (PUBLIC, UNLISTED)
- play_count
- artist_id (FK to Artists)
- album_id (FK to Albums, nullable)
- created_at
- updated_at

**Relationships:**
- Many-to-One with Artists
- Many-to-One with Albums (optional)
- Many-to-Many with Playlists
- One-to-Many with Favorites
- One-to-Many with ListeningHistory

### Albums
- id (PK)
- name
- description
- cover_art
- release_date
- artist_id (FK to Artists)
- created_at
- updated_at

**Relationships:**
- Many-to-One with Artists
- One-to-Many with Songs

### Playlists
- id (PK)
- name
- description
- is_public
- user_id (FK to Users)
- created_at
- updated_at

**Relationships:**
- Many-to-One with Users
- Many-to-Many with Songs (through playlist_songs)
- One-to-Many with PlaylistFollowers

### Favorites
- id (PK)
- user_id (FK to Users)
- song_id (FK to Songs)
- created_at

**Relationships:**
- Many-to-One with Users
- Many-to-One with Songs

### ListeningHistory
- id (PK)
- user_id (FK to Users)
- song_id (FK to Songs)
- played_at

**Relationships:**
- Many-to-One with Users
- Many-to-One with Songs

### PlaylistFollowers
- id (PK)
- user_id (FK to Users)
- playlist_id (FK to Playlists)
- followed_at

**Relationships:**
- Many-to-One with Users
- Many-to-One with Playlists

## Cardinality Summary

- User (1) ↔ (0..1) Artist
- User (1) ↔ (0..*) Playlist
- User (1) ↔ (0..*) Favorite
- Artist (1) ↔ (0..*) Song
- Artist (1) ↔ (0..*) Album
- Album (1) ↔ (0..*) Song
- Playlist (*) ↔ (*) Song
- User (*) ↔ (*) Playlist (followers)
