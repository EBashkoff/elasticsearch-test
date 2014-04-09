# See http://rubydoc.info/gems/elasticsearch-model/#Importing_the_data

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
  p "Person.index_name: #{Person.index_name}"

  Person.__elasticsearch__.client.indices.delete index: Person.index_name rescue nil
  Person.__elasticsearch__.client.indices.create \
    index: Person.index_name, 
    # settings: {:number_of_shards=>6, :number_of_replicas=>3 }
    body: { settings: Person.settings.to_hash, mappings: Person.mappings.to_hash }

  Person.import
end
