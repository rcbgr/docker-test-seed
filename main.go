package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"
)

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {

		f := fib()

		w.WriteHeader(http.StatusOK)
		io.WriteString(w, "Hello World\n")

		for _, e := range os.Environ() {
			pair := strings.Split(e, "=")
			io.WriteString(w, pair[0]+"="+pair[1]+"\n")
		}

		for i := 1; i <= 90; i++ {
			io.WriteString(w, strconv.Itoa(f())+"\n")
		}
	})

	port := "8080"

	if len(os.Getenv("PORT")) > 0 {
		port = os.Getenv("PORT")
	}


	fmt.Println(fmt.Sprintf("starting listener on: %s", port))

	if err := http.ListenAndServe(fmt.Sprintf(":%s", port), nil); err != nil {
		fmt.Println(err)
	}
}

func fib() func() int {
	a, b := 0, 1
	return func() int {
		a, b = b, a+b
		return a
	}
}
