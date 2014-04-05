require 'elasticsearch/model'

class Person < ActiveRecord::Base
	attr_accessible :age, :email, :f_name, :l_name
	# include Tire::Model::Search
  # include Tire::Model::Callbacks

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_touch :update_index

  mapping do
    indexes :f_name
    indexes :l_name
    indexes :email
    indexes :age, type: 'integer' # , index: 'not analyzed'
  end

  # def as_indexed_json(options={})
  #   as_json(only: [:id, :upc, :title, :description, :manufacturer_id]).merge({
  #     'tag'          => tags,
  #     'manufacturer' => manufacturer.name,
  #     'in-stock'     => product_status.in_stock,
  #     'price'        => product_status.price_cents
  #   })
  # end

  private

  def update_index
    __elasticsearch__.update_document
  end

  # def self.search(params)
  #   queryexp = {}
  #   queryexp[:query] =  {
  #     { term:  { f_name:  params[:search] } },
  #     { term:  { l_name:  params[:search] } },
  #     { term:  { email:   params[:search] } },
  #     { term:  { age:     params[:search] } }
  #   }
  # end 

  # def self.search(params)
  # 	tire.search(load: true) do
  #   	query { string params[:search]} if params[:search].present?
  #   end
  # end
end

