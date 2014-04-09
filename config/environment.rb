# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ElasticsearchTest::Application.initialize!

Person.__elasticsearch__.client = Elasticsearch::Client.new( host: "localhost:9200" )
