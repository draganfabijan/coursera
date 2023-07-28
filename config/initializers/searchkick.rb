Searchkick.client = Elasticsearch::Client.new(hosts: ["elasticsearch:9200"], retry_on_failure: true)


