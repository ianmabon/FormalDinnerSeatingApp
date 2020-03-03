package main

import (
	"bufio"
	"encoding/csv"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"math/rand"
	"net/http"
	"os"
	"time"
)

var studentNum []int

//Person is the struct for the peeps
type Person struct {
	Firstname string "json: firstname"
	Lastname  string "json: lastname"
	Table     []int  "json: table"
	Table2    []int
	Table3    []int
}

//defined person
var person []Person
var jsonData []byte

func replaceTable2(person []Person, studentNum int) {
	person[studentNum].Table2 = append(person[studentNum].Table2, rand.Intn(32))
	//gets rid of first element in array
	person[studentNum].Table2 = append(person[studentNum].Table2[:0], person[studentNum].Table2[1:]...)
}
func replaceTable3(person []Person, studentNum int) {
	person[studentNum].Table3 = append(person[studentNum].Table3, rand.Intn(32))
	person[studentNum].Table3 = append(person[studentNum].Table3[:0], person[studentNum].Table3[1:]...)
}
func arrangeTables() {
	//empty tables
	tableFill := []int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	//used table array
	usedTables := []int{}

	csvFile, _ := os.Open("seating.csv")
	reader := csv.NewReader(bufio.NewReader(csvFile))
	for {
		line, error := reader.Read()
		if error == io.EOF {
			break
		} else if error != nil {
			log.Fatal(error)
		}
		//append the seating list to person
		person = append(person, Person{
			Firstname: line[1],
			Lastname:  line[0],
		})
	}

	//random seed
	rand.Seed(time.Now().UnixNano())

	for studentNum, student := range person {
		//random table number
		var table = rand.Intn(32)
		var table2 = rand.Intn(32)
		var table3 = rand.Intn(32)
		//table + 1
		table++
		table2++
		table3++
		//appends the variable to the array
		person[studentNum].Table = append(person[studentNum].Table, table)
		person[studentNum].Table2 = append(person[studentNum].Table2, table2)
		person[studentNum].Table3 = append(person[studentNum].Table3, table3)
		//never runs just used to declare student
		if table == 34 {
			fmt.Println(student)
		}
		if table == 32 {
			if tableFill[table] < 9 {
				//if any of the tables equal eachother, then create a new table
				if person[studentNum].Table[0] == person[studentNum].Table2[0] {
					replaceTable2(person, studentNum)

				} else if person[studentNum].Table[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table2[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table[0] == 32 || person[studentNum].Table2[0] == 32 || person[studentNum].Table3[0] == 32 {
					//if the number generated is 32 (Kitchen Crew Table), then print KC
					fmt.Println(person[studentNum], "KC")
					tableFill[table]++

				} else {
					fmt.Println(person[studentNum])
					tableFill[table]++
				}
			} else {
				if person[studentNum].Table[0] == person[studentNum].Table2[0] {
					replaceTable2(person, studentNum)

				} else if person[studentNum].Table[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table2[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table[0] == 32 || person[studentNum].Table2[0] == 32 || person[studentNum].Table3[0] == 32 {
					fmt.Println(person[studentNum], "KC")
					tableFill[table]++

				} else {
					fmt.Println(person[studentNum])
					//adds to usedTables array
					usedTables = append(usedTables, table)
				}
			}
		} else {
			//if the table is not the Kitchen Crew Table, repeat the same process by checking each table
			if tableFill[table] < 9 {
				if person[studentNum].Table[0] == person[studentNum].Table2[0] {
					replaceTable2(person, studentNum)

				} else if person[studentNum].Table[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table2[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table[0] == 32 || person[studentNum].Table2[0] == 32 || person[studentNum].Table3[0] == 32 {
					fmt.Println(person[studentNum], "KC")
					tableFill[table]++

				} else {
					fmt.Println(person[studentNum])
					tableFill[table]++
				}
			} else {
				if person[studentNum].Table[0] == person[studentNum].Table2[0] {
					replaceTable2(person, studentNum)

				} else if person[studentNum].Table[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else if person[studentNum].Table2[0] == person[studentNum].Table3[0] {
					replaceTable3(person, studentNum)

				} else {
					//one extra place at each table to make waiters
					fmt.Println(person[studentNum], "Waiter")
					usedTables = append(usedTables, table)
				}
			}
		}
	}
}
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, string(jsonData))
}

func main() {
	arrangeTables()

	var err error

	jsonData, err = json.Marshal(person)

	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	fmt.Println(string(jsonData))
	http.HandleFunc("/", handler)

	log.Fatal(http.ListenAndServe(":80", nil))
}
