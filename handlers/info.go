package handlers

import (
	"log"
	"music_library/database"
	"music_library/utils"

	"github.com/gin-gonic/gin"
)

// @BasePath /api/v1

// @Summary Get songs
// @Schemes
// @Description Get song details by its name and group.
// @Description Returns all songs if no name or group provided.
// @Param song query string false "Song Name"
// @Param group query string false "Group Name"
// @Param start query int false "Start verse"
// @Param end query int false "End verse"
// @Tags Info
// @Produce json
// @Success 200 {array} database.SongDetails
// @Failute 400 {object} handlers.APIError
// @Failure 404 {string} string
// @Failure 500 {object} handlers.APIError
// @Router /info [get]
func GetSongHandler(db database.PostgresDB) gin.HandlerFunc {
	return func(c *gin.Context) {
		query := c.Request.URL.Query()

		requestedSong, err := utils.ProcessQuery(
			[][]string{
				query["song"],
				query["group"],
			}, "",
		)

		if err != nil {
			log.Println(err)
			c.IndentedJSON(500, APIError{
				"Internal server error",
			})
			return
		}

		song, group := requestedSong[0], requestedSong[1]

		songs, err := db.GetSongs(c, song.(string), group.(string))

		if err != nil {
			log.Printf(" [Error] %s", err)
			c.IndentedJSON(500, APIError{
				"Internal server error",
			})
			return
		} else if songs == nil {
			c.IndentedJSON(404, APIError{
				"Song not found",
			})
			return
		}

		paginationFilters, err := utils.ProcessQuery(
			[][]string{
				query["start"],
				query["end"],
			}, 0,
		)

		if err != nil {
			c.IndentedJSON(500, APIError{
				"Internal server error",
			})
			return
		}

		start, end := paginationFilters[0], paginationFilters[1]

		var songsWithPagination []database.SongDetails
		for _, song := range songs {
			song.Text = utils.PaginateText(
				song.Text,
				start.(int),
				end.(int),
			)

			songsWithPagination = append(songsWithPagination, song)
		}

		c.IndentedJSON(200, songsWithPagination)
	}
}
