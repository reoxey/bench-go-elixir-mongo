package start

import (
	"net/http"
	"github.com/reoxey/bench-go-elixir-mongo/go-mongo/configs"
	"fmt"
	"github.com/reoxey/bench-go-elixir-mongo/go-mongo/pkg/mongo"
	"time"
	"gopkg.in/mgo.v2/bson"
//	"github.com/reoxey/bench/go-mongo/pkg/tool"
)

func process(w http.ResponseWriter, r *http.Request)  {

	if len(r.FormValue("profile")) > 0 {

		mongo.MongoDial(configs.MoDBNM, "profile")

		go concurrent(r)
		
	}else{
		fmt.Println("No profile id sent")
	}

}

func concurrent(r *http.Request)  {

	date := time.Now().Format("20060102150405")
	ua := r.UserAgent()

	in := bson.M{
		"date" : date,
		"name" : "Hemraj",
		"username" : "reoxey",
		"email" : "reoxey@example.com",
		"place" : "Goa",
		"country" : "India",
		"phone" : "+91 (000) 000 0000",
		"profile" : r.FormValue("profile"),
		"ua" : ua,
	}

	mongo.Insert(in)

	fmt.Print(".")
}

func Run()  {
	fmt.Println("server started")
	http.HandleFunc("/bench", process)
	http.ListenAndServe(":8000", nil)
}
