require 'elasticsearch/model'

class Person < ActiveRecord::Base
	attr_accessible :age, :email, :f_name, :l_name
	# include Tire::Model::Search
  # include Tire::Model::Callbacks

  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # field :f_name, type: String
  # field :l_name, type: String
  # field :email,  type: String
  # field :age,    type: integer

  def self.search(params)
    query = "match" : 
      {
        "f_name" :  params[:search],
        "l_name" :  params[:search],
        "email" :   params[:search],
        "age" : params[:search]
      }
    

  end 

  # def self.search(params)
  # 	tire.search(load: true) do
  #   	query { string params[:search]} if params[:search].present?
  #   end
  # end
end

