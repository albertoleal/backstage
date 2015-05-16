package api

import "encoding/json"

//FIXME: Add test
type CollectionSerializer struct {
	Items interface{} `json:"items"`
	Count int         `json:"item_count"`
}

func (cs *CollectionSerializer) Serializer() string {
	payload, _ := json.Marshal(cs)
	return string(payload)
}
