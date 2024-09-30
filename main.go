package main

import (
	"context"
	"io"
	"log"
	"music_library/database"
	"music_library/handlers"
	"os"

	docs "music_library/docs"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/stdlib"
	"github.com/joho/godotenv"
	"github.com/pressly/goose/v3"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// @title           Music library test task
// @version         1.0
// @description     This is a test task for Juniour Go Developer in Effective Mobile.

// @contact.name   Andrei Dombrovskii
// @contact.email  andrushathegames@gmail.com

// @license.name  Apache 2.0
// @license.url   http://www.apache.org/licenses/LICENSE-2.0.html

// @host      127.0.0.1:8080
// @BasePath  /api/v1
func main() {
	godotenv.Load("config.env")

	GIN_MODE := os.Getenv("GIN_MODE")
	GIN_ADDR := os.Getenv("GIN_ADDR")

	// Write logs to app.logs

	f, _ := os.Create("app.logs")
	gin.DefaultWriter = io.MultiWriter(f, os.Stdout)

	gin.SetMode(GIN_MODE)

	POSTGRES_URL := os.Getenv("POSTGRES_URL")

	db, err := database.NewDB(context.Background(), POSTGRES_URL)

	if err != nil {
		log.Fatalf(" [Error] Failed to establish a connection to Postgres. %s\n", err)
	}

	defer db.Pool.Close()

	// Setup migrations

	if err := goose.SetDialect("postgres"); err != nil {
		log.Fatalf(" [Error] %s", err)
	}

	driver := stdlib.OpenDBFromPool(db.Pool)

	log.Println(" [Info] Migrating database...")

	if err := goose.Up(driver, "migrations"); err != nil {
		log.Fatalf(" [Error] %s", err)
	}

	if err := driver.Close(); err != nil {
		log.Fatalf(" [Error] %s", err)
	}

	// Setup Gin

	serv := gin.New()
	serv.Use(gin.Recovery(), gin.Logger())

	docs.SwaggerInfo.BasePath = "/api/v1"
	v1 := serv.Group("/api/v1")
	{
		v1.GET("/info", handlers.GetSongHandler(db))
		v1.GET("/text", handlers.GetTextWithPaginationHandler(db))
		v1.DELETE("/delete", handlers.DeleteSongHandler(db))
		v1.POST("/add", handlers.AddSongHandler(db))
		v1.PUT("/edit", handlers.EdigSongHandler(db))
	}
	serv.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerfiles.Handler))
	serv.Run(GIN_ADDR)
}
