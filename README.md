# bench-go-elixir-mongo
Load testing with jmeter against go concurrency and elixir concurrency with mongoDB


## PC Configuration
- **OS:**  Ubuntu 18.04 LTS 64 bit
- **RAM:** 8GB
- **CPU:** Intel® Core™ i5-4210U CPU @ 1.70GHz × 4


#### Go Mongo
- go version go1.10 linux/amd64
- MongoDB shell version v3.6.1

Load testing using jmeter with **200** concurrent users
- Total requests sent : **3,765,241**
- MongoDB : **3,765,239** (only 2 requests failed)
- Throughput : **5204** requests / sec eventually, running for 13 minutes


#### Elixir Mongo
- Erlang/OTP 20 [erts-9.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false]
- Elixir 1.6.5 (compiled with OTP 19)
- MongoDB shell version v3.6.1

Load testing using jmeter with **200** concurrent users
- Total requests sent : **918,541**
- MongoDB : **317,298**
- Throughput : **1496** requests / sec eventually, running for 10 minutes

## Conclusion
Go - Mongo combination gives high throughput with greater reliabilty than Elixir - Mongo combination.
