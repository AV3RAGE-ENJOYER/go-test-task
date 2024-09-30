package database

import (
	"context"
	"log"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

type PostgresDB struct {
	Pool *pgxpool.Pool
}

// Create new PostgresDB instance
func NewDB(ctx context.Context, db_url string) (PostgresDB, error) {
	dbPool, err := pgxpool.New(ctx, db_url)

	if err != nil {
		return PostgresDB{}, err
	}

	postgres := PostgresDB{dbPool}
	return postgres, nil
}

// Get songs by name, group, both or all songs if parameters are empty
func (db *PostgresDB) GetSongs(ctx context.Context, song string, group string) ([]SongDetails, error) {
	args := pgx.NamedArgs{
		"song":  song,
		"group": group,
	}

	// Query to filter by songs name and/or group
	q := `SELECT sl.song, sl.group, sd.release_date, sd.text, sd.link
		FROM songs_details sd JOIN songs_list sl ON sd.id=sl.id
		WHERE (sl.song = @song OR @song IS NULL OR @song = '')
	  	AND (sl.group = @group OR @group IS NULL OR @group = '');`

	rows, err := db.Pool.Query(ctx, q, args)

	if err != nil {
		return []SongDetails{}, err
	}

	defer rows.Close()

	var songDetails SongDetails
	var songs []SongDetails

	for rows.Next() {
		err := rows.Scan(
			&songDetails.Song,
			&songDetails.Group,
			&songDetails.ReleaseDate,
			&songDetails.Text,
			&songDetails.Link,
		)

		if err != nil {
			return []SongDetails{}, err
		}

		songs = append(songs, songDetails)
	}

	return songs, nil
}

func (db *PostgresDB) DeleteSong(ctx context.Context, song string, group string) (int64, error) {
	tx, err := db.Pool.Begin(ctx)

	defer func() {
		if err != nil {
			log.Println(err)
			tx.Rollback(ctx)
		} else {
			tx.Commit(ctx)
		}
	}()

	args := pgx.NamedArgs{
		"song":  song,
		"group": group,
	}

	q := "DELETE FROM songs_list AS sl WHERE sl.song = @song AND sl.group = @group"

	tag, err := tx.Exec(ctx, q, args)

	return tag.RowsAffected(), nil
}

func (db *PostgresDB) AddSong(ctx context.Context, songDetails SongDetails) error {
	tx, err := db.Pool.Begin(ctx)

	defer func() {
		if err != nil {
			log.Println(err)
			tx.Rollback(ctx)
		} else {
			tx.Commit(ctx)
		}
	}()

	args := pgx.NamedArgs{
		"song":         songDetails.Song,
		"group":        songDetails.Group,
		"release_date": songDetails.ReleaseDate,
		"text":         songDetails.Text,
		"link":         songDetails.Link,
	}

	q := `WITH add_user AS (
		INSERT INTO songs_list("song", "group")
		VALUES(@song, @group)
		RETURNING id
		)
		INSERT INTO 
		songs_details("id", "release_date", "text", "link")
		SELECT id, @release_date, @text, @link FROM add_user`

	_, err = tx.Exec(
		ctx,
		q,
		args,
	)

	return nil
}

func (db *PostgresDB) EditSong(ctx context.Context, songDetails SongDetails) error {
	tx, err := db.Pool.Begin(ctx)

	defer func() {
		if err != nil {
			log.Printf(" [Error] %s", err)
			tx.Rollback(ctx)
		} else {
			tx.Commit(ctx)
		}
	}()

	args := pgx.NamedArgs{
		"song":         songDetails.Song,
		"group":        songDetails.Group,
		"release_date": songDetails.ReleaseDate,
		"text":         songDetails.Text,
		"link":         songDetails.Link,
	}

	q := `UPDATE 
		songs_details AS sd
		SET release_date = @release_date,
		text = @text, link = @link
		FROM songs_list AS sl
		WHERE 
		sl.id = sd.id and sl.song = @song
		and sl.group = @group`

	_, err = tx.Exec(
		ctx,
		q,
		args,
	)

	return nil
}
