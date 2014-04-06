require 'elasticsearch/rails/tasks/import'

# Reindex Person table 
#   Invoke with "bundle exec rake elasticsearch:reindex" from the command line
#
#   Note that number of shards and number of replicas may be set in /usr/local/Cellar/elasticsearch/1.1.0/config/elasticsearch.yaml
#   in the following lines:
#     1. index.number_of_shards: <number>
#     2. index.number_of_replicas: <number>

desc "Re-index elasticsearch data."
task "elasticsearch:reindex" => :environment do
	p "----->> Reindexing Person table <<-----"
	Person.import
end
