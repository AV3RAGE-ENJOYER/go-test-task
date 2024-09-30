package handlers

import (
	"log"
	"music_library/database"

	"github.com/gin-gonic/gin"
)

// @BasePath /api/v1

// @Summary Edit song details
// @Schemes
// @Description Edit song details.
// @Param body body database.SongDetails true "Request body"
// @Tags Info
// @Accept json
// @Produce json
// @Success 200 {object} database.SongDetails
// @Failute 400 {object} handlers.APIError
// @Failure 500 {object} handlers.APIError
// @Router /edit [put]
func EdigSongHandler(db database.PostgresDB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var jsonRequest database.SongDetails

		c.BindJSON(&jsonRequest)

		songPreview := database.SongDetails{
			Song:  jsonRequest.Song,
			Group: jsonRequest.Group,
		}

		if songPreview.Song != "" && songPreview.Group != "" {
			songDetails, err := db.GetSongs(
				c,
				songPreview.Song,
				songPreview.Group,
			)

			if err != nil {
				log.Printf(" [Error] %s", err)
				c.IndentedJSON(500, APIError{
					"Internal server error",
				})
				return
			}

			if songDetails != nil {
				updatedSongDetails := database.SongDetails{
					Song:        jsonRequest.Song,
					Group:       jsonRequest.Group,
					ReleaseDate: jsonRequest.ReleaseDate,
					Text:        jsonRequest.Text,
					Link:        jsonRequest.Link,
				}

				err = db.EditSong(c, updatedSongDetails)

				if err != nil {
					c.IndentedJSON(500, APIError{
						"Internal server error",
					})
					return
				}

				c.IndentedJSON(200, updatedSongDetails)
				return
			}
		}

		c.IndentedJSON(400, APIError{
			"Bad request",
		})
	}
}
