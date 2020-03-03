package main

import (
    "fmt"
    "log"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {

    // Let's print the info
    fmt.Println("Incoming Request: ")
    fmt.Println("Method: ", r.Method, " ", r.URL)

    // Collect all the header keys
    headerKeys := make([]string, len(r.Header))
    i := 0
    for k := range r.Header {
        headerKeys[i] = k
        i++
    }
    // Show Client Headers
    for _, line := range headerKeys {
        fmt.Println("  > ", line, ":", r.Header.Get(line))
    }

    // Answer the Client request
    fmt.Fprintf(w, "Hello World! Path is: %s!", r.URL.Path[1:])
}

func main() {
    http.HandleFunc("/", handler)

    log.Fatal(http.ListenAndServe(":80", nil))

}