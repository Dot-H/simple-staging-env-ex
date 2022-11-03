// echo-server exposes a server listening on :8080 and echoing
// everything it receives
package main

import (
	"io"
	"log"
	"net/http"
)

type EchoHandler struct{}

func (h *EchoHandler) ServeHTTP(w http.ResponseWriter, rq *http.Request) {
	_, bodyE := io.Copy(w, rq.Body)
	if bodyE != nil {
		_, writeE := w.Write([]byte("failed to copy the body"))
		if writeE != nil {
			log.Printf("failed to write error to response body: %s", writeE)
		}
		w.WriteHeader(http.StatusInternalServerError)
	}

	w.Write([]byte("This is an update"))
}

func main() {
	http.Handle("/", &EchoHandler{})
	log.Println("listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
