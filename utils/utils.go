package utils

import (
	"strconv"
	"strings"
)

// Returns processed query with values converted to default value type and inserts default values if element is nil
func ProcessQuery(query [][]string, defaultValue interface{}) ([]interface{}, error) {
	var processedQuery []interface{}

	for _, el := range query {
		if len(el) > 0 {
			if _, ok := any(defaultValue).(int); ok {
				convertedEl, err := strconv.Atoi(el[0])

				if err != nil {
					return nil, err
				}

				processedQuery = append(processedQuery, convertedEl)
			} else {
				processedQuery = append(processedQuery, el[0])
			}
		} else {
			processedQuery = append(processedQuery, defaultValue)
		}
	}

	return processedQuery, nil
}

func PaginateText(text string, start int, end int) string {
	verses := strings.Split(text, "\n\n")
	versesNum := len(verses)

	if start > versesNum || start < 0 {
		return ""
	}

	if end > versesNum || end == 0 {
		end = versesNum
	}

	return strings.Join(verses[start:end], "\n\n")
}
