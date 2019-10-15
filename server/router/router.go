package router

import (
	"github.com/go-chi/chi"

	"nook/server/app"
	"nook/server/requestlog"
)

func New(a *app.App) *chi.Mux {
	l := a.Logger()
	r := chi.NewRouter()
	r.Method("GET", "/", requestlog.NewHandler(app.HandleIndex, l))
	return r
}
