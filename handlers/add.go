package handlers

import (
	"log"
	"music_library/database"

	"github.com/gin-gonic/gin"
)

// @BasePath /api/v1

// @Summary Add new song
// @Schemes
// @Description Adds new song to database.
// @Param body body database.SongDetails true "Request body"
// @Tags Info
// @Accept json
// @Produce json
// @Success 200 {string} string
// @Failute 400 {object} handlers.APIError
// @Failure 500 {object} handlers.APIError
// @Router /add [post]
func AddSongHandler(db database.PostgresDB) gin.HandlerFunc {
	return func(c *gin.Context) {

		var songDetails database.SongDetails

		c.BindJSON(&songDetails)

		if songDetails.Song != "" && songDetails.Group != "" {
			err := db.AddSong(c, songDetails)

			if err != nil {
				log.Println(err)
				c.IndentedJSON(500, APIError{
					"Internal server error",
				})
				return
			}

			song, _ := db.GetSongs(c, songDetails.Song, songDetails.Group)

			c.IndentedJSON(200, song)
			return
		}

		c.IndentedJSON(400, APIError{
			"Bad request",
		})
	}
}
