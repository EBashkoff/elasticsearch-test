require 'elasticsearch/model'

class Person < ActiveRecord::Base
	attr_accessible :age, :email, :f_name, :l_name
	# include Tire::Model::Search
  # include Tire::Model::Callbacks

  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # def self.search(params)
  # 	tire.search(load: true) do
  #   	query { string params[:search]} if params[:search].present?
  #   end
  # end
end

