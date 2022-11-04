// echo-server exposes a server listening on :8080 and echoing
// everything it receives
package main

import (
	"io"
	"log"
	"net/http"
	"os"
)

var ENV_USERNAME = "ECHO_SERVER_USERNAME"
var USERNAME = ""

func init() {
	hasUsername := false
	if USERNAME, hasUsername = os.LookupEnv(ENV_USERNAME); !hasUsername {
		log.Fatalf("missing mandatory environment variable %q", ENV_USERNAME)
	}
}

// EchoHandler implements http.Handler to echo the request body into
// the response.
//
// See EchoHandler.ServeHTTP for more details.
type EchoHandler struct{}

// ServeHTTP copies back the request body into the response and adds
// the header X-ECHO-SERVER-USERNAME in it
func (h *EchoHandler) ServeHTTP(w http.ResponseWriter, rq *http.Request) {
	_, bodyE := io.Copy(w, rq.Body)
	if bodyE != nil {
		_, writeE := w.Write([]byte("failed to copy the body"))
		if writeE != nil {
			log.Printf("failed to write error to response body: %s", writeE)
		}
		w.WriteHeader(http.StatusInternalServerError)
	}

	rq.Response.Header.Add("X-ECHO-SERVER-USERNAME", USERNAME)
}

func main() {
	http.Handle("/", &EchoHandler{})
	log.Println("listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
