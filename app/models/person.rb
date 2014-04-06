require 'elasticsearch/model'

class Person < ActiveRecord::Base
	attr_accessible :age, :email, :f_name, :l_name

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_touch :update_index

  mapping do
    indexes :f_name
    indexes :l_name
    indexes :email
    indexes :age, type: 'integer' # , index: 'not analyzed'
  end

  private

  def update_index
    __elasticsearch__.update_document
  end
end


