package handlers

import (
	"music_library/database"

	"github.com/gin-gonic/gin"
)

// @BasePath /api/v1

// @Summary Delete song
// @Schemes
// @Description Delete song by its name and group
// @Param song query string true "Song Name"
// @Param group query string true "Group Name"
// @Tags Info
// @Produce json
// @Success 200 {array} string
// @Failute 400 {object} handlers.APIError
// @Failure 404 {object} handlers.APIError
// @Failure 500 {object} handlers.APIError
// @Router /delete [delete]
func DeleteSongHandler(db database.PostgresDB) gin.HandlerFunc {
	return func(c *gin.Context) {
		query := c.Request.URL.Query()

		song := query["song"]
		group := query["group"]

		if song != nil && group != nil {

			rowsAffected, err := db.DeleteSong(c, song[0], group[0])

			if err != nil {
				c.IndentedJSON(500, APIError{
					"Could not delete a song",
				})
				return
			}

			if rowsAffected == 0 {
				c.IndentedJSON(404, APIError{
					"Could not find a song",
				})
				return
			}

			c.IndentedJSON(200, gin.H{
				"message": "The song has been deleted",
			})
			return
		}

		c.IndentedJSON(400, APIError{
			"Bad request",
		})
	}
}
