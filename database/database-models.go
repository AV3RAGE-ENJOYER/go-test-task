package database

type SongDetails struct {
	Song        string `json:"song"`
	Group       string `json:"group"`
	ReleaseDate string `json:"release_date"`
	Text        string `json:"text"`
	Link        string `json:"link"`
}
