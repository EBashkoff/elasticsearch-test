require 'elasticsearch/rails/tasks/import'

desc "Re-index elasticsearch data."
task "elasticsearch:reindex" => :environment do

  # m = Tire.search(:mail_logs, { :query => { :query_string => { :query => "source:Zillow" }}}).results.first

  elasticsearch_settings = {
    :index => {
      :number_of_shards => 5,
      :number_of_replicas => 3,
    },
    :analysis => {
      :analyzer => {
        :ngram_analyzer => { "tokenizer" => "nGram" }
      }
    }
  }

  elasticsearch_mappings = {
    :mail_log => {
      :properties => {
        :id          => { :type => 'integer', :index => :not_analyzed, :include_in_all => false },
        :age         => { :type => 'integer', :index => :not_analyzed, :include_in_all => false },
        :email       => { :type => 'string', :analyzer => :standard },
        :l_name      => { :type => 'string', :analyzer => :standard },
        :f_name      => { :type => 'string', :analyzer => :standard }
      }
    }
  }

  index = Elasticsearch::Index.new('person')
  index.delete
  index.create(:settings => elasticsearch_settings, :mappings => elasticsearch_mappings)
  index.refresh

  MailLog.all.each do |mail_log|
    mail_log.reindex(true)
  end

end
