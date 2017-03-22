require 'couchrest_model'

class BlinkboxFile < CouchRest::Model::Base
  property :_id, String
  property :_rev, String
  property :name,      String
  property :owner,      String
  property :uploaded_date, Float
  property :expiring_date, Float
  property :shared, [String]

  design do
  end
end
