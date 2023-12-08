package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("input")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	// create scanner from the file to read text from
	scanner := bufio.NewScanner(file)
	// scan or read the bytes of text line by line
	sum, line := 0, 0
	copies := make(map[int]int)
	for scanner.Scan() {
		line++
		copies[line]++
		winners := make(map[int]bool)
		parts := strings.Split(scanner.Text(), "|")
		winningNums := strings.Split(parts[0], ":")
		// fmt.Println(parts[0])
		for _, v := range strings.Fields(strings.TrimSpace(winningNums[1])) {
			winner, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			winners[winner] = true
		}
		i := 0
		for _, v := range strings.Fields(strings.TrimSpace(parts[1])) {
			winner, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			if _, ok := winners[winner]; ok {
				i++
				copies[line+i] += copies[line]
			}
		}
		// fmt.Println(winnings)
		fmt.Println("line", line, "copies", copies[line])
		sum += copies[line]
	}
	println(sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
