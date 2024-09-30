package handlers

import (
	"music_library/database"
	"music_library/utils"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
)

// @BasePath /api/v1

// @Summary Get song text with pagination by verses
// @Schemes
// @Description Get song text with pagination by verses.
// @Description	Returns full text if no parameters provided.
// @Param song query string true "Song name"
// @Param group query string true "Group name"
// @Param start query int false "Start verse"
// @Param end query int false "End verse"
// @Tags Info
// @Produce json
// @Success 200 {object} handlers.JSONResult
// @Failute 400 {object} handlers.APIError
// @Failure 500 {object} handlers.APIError
// @Router /text [get]
func GetTextWithPaginationHandler(db database.PostgresDB) gin.HandlerFunc {
	return func(c *gin.Context) {
		query := c.Request.URL.Query()

		requestedSong, err := utils.ProcessQuery(
			[][]string{
				query["song"],
				query["group"],
			}, "",
		)

		if err != nil {
			c.IndentedJSON(500, APIError{
				"Internal server error",
			})
			return
		}

		song, group := requestedSong[0], requestedSong[1]

		songDetails, err := db.GetSongs(c, song.(string), group.(string))

		if songDetails == nil || err == pgx.ErrNoRows {
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

		paginatedText := utils.PaginateText(songDetails[0].Text, start.(int), end.(int))
		c.IndentedJSON(200, gin.H{
			"text": paginatedText,
		})
	}
}
