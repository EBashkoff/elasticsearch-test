#  See http://rubydoc.info/gems/elasticsearch-model/

require 'elasticsearch/model'

class Person < ActiveRecord::Base
  attr_accessible :age, :email, :f_name, :l_name, :city, :state, :zip

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_commit do 
    logger.debug("*********  SELF AS INDEXED #{self.__elasticsearch__.as_indexed_json}")
    self.__elasticsearch__.index_document
  end
  
  settings index: { :number_of_shards => 6, :number_of_replicas => 1 } do
    mappings _source: { :enabled => false }, _all: { :enabled => true } do
      indexes :f_name
      indexes :l_name
      indexes :email
      indexes :city, :index => :not_analyzed, :include_in_all => false
      indexes :state, :index => :not_analyzed, :include_in_all => false
      indexes :zip, :index =>  :not_analyzed, :include_in_all => true
      indexes :age, :type => :integer
    end
  end
end
