package router

import (
	"github.com/go-chi/chi"
	"nook/server/app"
)

func New() *chi.Mux {
	r := chi.NewRouter()
	r.MethodFunc("GET", "/", app.HandleIndex)
	return r
}